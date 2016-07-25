function tbPlayOnCallback(hObject, eventdata, playback, VS, ~)
%TBPLAYONCALLBACK Toolbar Playback Button Callback. This callback
%implements all the audio processing.
%
% This function manages the user interaction in the profile view. 
%
% Input:
%    hObject   - Reference object (figure)
%    eventdata - (Reserved)
%    plyaback  - Data structure needed for playback, with fields
%       playback.handles
%       playback.fs
%       playback.buffersize
%       playback.channelmapping 
%       playback.queue
%       playback.NLS
%       playback.samplesperframe
%       playback.NVS 
%       playback.fadebuffers 
%    VS        - Cell array of virtual source handles.
%
% See also: SART3D, gDnDplan, VSource

%*****************************************************************************
% Copyright (c) 2013-2016 Signal Processing and Acoustic Technology Group    *
%                         SPAT, ETSE, Universitat de València                *
%                         46100, Burjassot, Valencia, Spain                  *
%                                                                            *
% This file is part of the SART3D: 3D Spatial Audio Rendering Toolbox.       *
%                                                                            *
% SART3D is free software:  you can redistribute it and/or modify it  under  *
% the terms of the  GNU  General  Public  License  as published by the  Free *
% Software Foundation, either version 3 of the License,  or (at your option) *
% any later version.                                                         *
%                                                                            *
% SART3D is distributed in the hope that it will be useful, but WITHOUT ANY  *
% WARRANTY;  without even the implied warranty of MERCHANTABILITY or FITNESS *
% FOR A PARTICULAR PURPOSE.                                                  *
% See the GNU General Public License for more details.                       *
%                                                                            *
% You should  have received a copy  of the GNU General Public License  along *
% with this program.  If not, see <http://www.gnu.org/licenses/>.            *
%                                                                            *
% SART3D is a toolbox for real-time spatial audio prototyping that lets you  *
% move in real time virtual audio sources from a set of WAV files using      *
% multiple spatial audio rendering methods.                                  *
%                                                                            *
% https://github.com/spatUV/SART3Dmaster                  maximo.cobos@uv.es *
%*****************************************************************************


%% === Initialize Repproduction =======================================

    handles = playback.handles;
    subwactive  = playback.subwactive;
    if subwactive
        subwchannel = playback.subwchannel;
    end

    out = dsp.AudioPlayer;
    
    % Selected reproduction device from popupMenu:
    deviceNames = get(handles.pmDevice, 'String');
    deviceNameSelected = deviceNames(get(handles.pmDevice, 'Value'));
    auxchar = char(deviceNameSelected);
    out.DeviceName = auxchar;    
    
    % Set reproduction parameters:
    out.SampleRate = playback.fs;
    out.BufferSizeSource = 'Property';     
    out.BufferSize = playback.buffersize;    
    out.ChannelMappingSource = 'Property';
    out.ChannelMapping = playback.channelmapping;
    out.QueueDuration = playback.queue;
    
    % Initialize output data:
    voidChannels = zeros(playback.samplesperframe,playback.NLS);
    
    % Initialize required output data for smoothing:
    y  = voidChannels;
    y1 = voidChannels;
    y2 = voidChannels;
    
    % Initialize input data:
    x = zeros(playback.samplesperframe,playback.NVS);
    
    % Total audio out (will accumulate signals from different sources)   
    audio_out = voidChannels;
    
    % Auxiliar vector storing last-frame contributing loudspeakers
    Ilast = cell(playback.NVS,1);
    
    % linear fade-in/out
    %fadeOutMono = linspace(1, 0, conf.SamplesPerFrame).'; % [SamplesPerFrame]
    %fadeInMono  = linspace(0, 1, conf.SamplesPerFrame).';
    
    % hanning fade-in/out
    auxhann = hann(2*playback.samplesperframe,'periodic');
    fadeInMono = auxhann(1:playback.samplesperframe);
    fadeOutMono = auxhann(playback.samplesperframe+1:end);
    
    fadeOut = repmat(fadeOutMono, 1, playback.NLS); % [SamplesPerFrame x nLS]
    fadeIn = repmat(fadeInMono, 1, playback.NLS);
    
    if subwactive
        fadeOut = repmat(fadeOutMono, 1, playback.NLS+1); 
        fadeIn  = repmat(fadeInMono,  1, playback.NLS+1);
        out.ChannelMapping = [out.ChannelMapping, subwchannel];
        voidChannels = zeros(playback.samplesperframe, playback.NLS+1);
        void_subw    = zeros(playback.samplesperframe,1);      
        audio_out    = voidChannels;
    end

    audioin = cell(playback.NVS,1);
    for ii = 1:playback.NVS
        audioin{ii} = dsp.AudioFileReader;
        audioin{ii}.Filename = VS{ii}.filename;
        audioin{ii}.SamplesPerFrame = playback.samplesperframe;
        audioin{ii}.PlayCount = inf;
    end
    
 
    
    %% === While play button is on ====================================
    
    while get(hObject, 'State') % 'On' by default
       % Load data from GUI (needed to get updated filters)       
       % data = guidata(hObject);

        % If play button is pressed again, break
        if strcmp(get(hObject, 'State'), 'off')
            break;
        end
                
        for ii = 1:playback.NVS
            % Read audio files:
            x(:,ii) = step(audioin{ii});
            
            y1 = voidChannels;
            y2 = voidChannels;
%             if strcmp(conf.SubWoofer.active,'on')
%                 subw_audio = void_subw;
%             end
            
            % Play audio from sources with active checkbox. If not, mute by
            % adding zeros. This is necessary for having synchronized
            % sources
            if get(handles.checkboxesVS(ii), 'Value')
                
                % Cross-fading
                if strcmp(playback.fadebuffers, 'on')                    
                    y1 = voidChannels;
                    y2 = voidChannels;
                    Ip = VS{ii}.renderer.Iactive;
                    if VS{ii}.renderer.change
                        dofade = 1;
                        I = unique([Ip; Ilast{ii}]);
                        VS{ii}.renderer.change = 0;
                    else                        
                        I = Ip;
                        dofade = 0;
                    end
                    for jj = 1:length(I)
                        if dofade
                            y1(:, I(jj)) = steplast(VS{ii}.renderer.Filters{I(jj)},x(:,ii));
                            y2(:, I(jj)) = step(VS{ii}.renderer.Filters{I(jj)},x(:,ii));
                        else
                            y2(:, I(jj)) = step(VS{ii}.renderer.Filters{I(jj)},x(:,ii));
                        end
                    end
                    Ilast{ii} = Ip;
                    
                    % Apply cross-fading if necessary:
                    if dofade
                        y = y1.*fadeOut+y2.*fadeIn; % Mix fade-in and fade-out signal
                    else
                        y = y2;
                    end
                    
                else % No frame smoothing
                    y = voidChannels;
                    Ip = VS{ii}.renderer.Iactive;
                    for jj = 1:length(Ip)
                       y(:, Ip(jj)) = step(VS{ii}.renderer.Filters{Ip(jj)},x(:,ii));
                    end
                end           
                
            else
                y = voidChannels; % Mute
            end
            % Accumulate audio from different sources
            audio_out = audio_out + y;                       
           
        end
          
        % If subwoofer is enabled
        if subwactive
            active_sources = find(cell2mat(get(handles.checkboxesVS, 'Value'))==1);
            subw_audio = void_subw;
            Nact = length(active_sources);
            coordact = getVScoords(VS(active_sources));
            rmin = min(coordact(1,:));
            for ii = 1:Nact                           % Subwoofer mix
                coordii = getCoord(VS{ii});
                rs = max(coordii(1), rmin);
                att = rmin/rs;
                subw_audio = subw_audio + x(:,active_sources(ii))*att;
            end
            audio_out(:,end) = subw_audio*(1/Nact);
            %Listen only to subwoofer output
            %audio_out(:,1:end-1) = zeros(conf.SamplesPerFrame,conf.nLS);
        end

         step(out, audio_out); % Reproduce audio stream
         
         % Reset audio stream for next callback.
         audio_out = voidChannels;        
         drawnow;
    end
    
    % Release resources:
    for ii = 1:playback.NVS
        release(audioin{ii});
    end
    release(out);

    
end