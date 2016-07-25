%% GCONFIG - SART3D configuration structure script.
%
% Creates a configuration structure (conf), a scene structure (scene) and a
% reproduction setup structure (setup) needed for SART3D.
%
% See also: gCheckConfig


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

%% GENERAL CONFIGURATION  (conf structure)

%======= Audio-related Options =========
conf.root = getrootfolder();          % rootfolder
conf.devices = getdevices();          % get available audio devices
conf.fs = 44100;                      % sampling frequency (in Hz)
conf.bufferSize = 4096;               % audio buffer size (in samples)
conf.SamplesPerFrame = 4096;          % audio processing frame length (in samples)
conf.QueueDuration = 0.5;             % audio queue duration
conf.fadeBuffers = 'on';              % use fading to avoid audio clipping
conf.subwoofer.active = 'off';        % use subwoofer mix

%======== GUI-related Options ==========
conf.sres = 0.2;                      % spatial resolution when moving sources with the GUI
conf.rmax = 5;                        % maximum distance in GUI
conf.plot.activels = 'off';           % plot active loudspeakers when moving a source
conf.profile = 'on';                  % see profile view
conf.methods = getrendermethods();    % get available rendering methods
conf.sceneDim = '3D';                 % sound scene dimensionality (not currently used)
conf.setupDim = '3D';                 % reproduction setup dimensionality (not currently used)

% Note: 
% To speed-up the processing consider setting 'conf.plot.activels' to 'off',
% increasing the spatial resolution 'conf.sres' and/or setting
% 'conf.profile' to 'off'.

%% SOUND SCENE CONFIGURATION  (scene structure)

%=== Virtual Source Coordinates === (in this example, 7 virtual sources)
scene.VScoord = {
    [2.50,  +0, 0],...                % In spherical coordinates:
    [2.50, +10, 0],...                % [radius, azimuth, elevation]
    [2.50, +20, 0],...
    [2.50, +30, 0],...
    [2.50, -30, 0],...
    [2.50, -20, 0],...
    [2.50, -10, 0]};

%=== Virtual Source Filenames === 
scene.VSfilenames = {
    'test_440.wav',...
    '3_Hat.wav',...
    '4_Arp.wav',...
    '5_Clap.wav',...
    '6_Loop.wav',...
    '7_Snare.wav',...
    '8_FX.wav'};

%=== Virtual Source Names === (if empty, extracted from filename)
scene.VSnames = {};


%% REPRODUCTION SETUP CONFIGURATION  (setup structure)


setup.Rep = 'Two Channel';          % Setup Name
setup.LScoord = {                   % Loudspeaker locations
    [1.75, 45, 0],...               % In spherical coordinates:
    [1.75, -45, 0]};                % [radius, azimuth, elevation]
setup.ChannelMapping = [1 2];       % Channel mapping
setup.Renderer = 'StSL';            % Selected reproduction method
setup.subwchannel = [];             % Subwoofer channel (empty)

% Note: channel mapping specifies which output channel of your audio
% interface corresponds to loudspeaker 1, 2, etc.:
% [out channel for loudspeaker 1, out channel for loudspeaker 2, etc]

% Note: the rendering method must match the loudspeaker configuration.
% The GUI can be used to change in real-time the rendering method, but only
% those methods matching the loudspeaker configuration will be loaded.



