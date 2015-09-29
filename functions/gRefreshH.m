function gRefreshH(hObject, ii)
%GREFRESHH Updates the filter corresponding to a selected source.
%
% This function is very important, since it is the one that calls a specific
% rendering method and obtains the filter coefficients and contributing
% loudspeakers for achieving the rendering of a virtual source.
%
% The function is called initially by SART3D and is modified whenever a 
% virtual source is moving (called by gDnD).
%
% The input parameters are:
%   hObject - Handle of the GUI to load the corresponding data.
%
%   ii - Index of the source that is being updated.
%
% See also: gDnD, SART3D

%*****************************************************************************
% Copyright (c) 2013-2015 Signal Processing and Acoustic Technology Group    *
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

global conf handles

% Load data from GUI
data = guidata(hObject);

%*************************************************************************
% CALL TO RENDERING METHOD
%*************************************************************************
% Methods should return a matrix H [nCoeffs x length(I)] with
% the filtering coefficients for each of the loudspeakers contributing
% to the rendering and specified in vector I.
switch conf.methods.names{get(handles.pmMethod, 'Value')}
    case 'VBAP'
        pc = gSph2Car(data.vSSph(:,ii));
        [H, I] = gVBAP(pc, data.vSSph(1,ii));
       
    case 'HRTF'
        [H, I] = gHRTF(data.vSSph(:,ii));
        
    case 'AAP'
        [H, I] = gAAP(data.vSSph(2,ii));
        
    case 'StTL'
        [H,I] = gStTL(data.vSSph(:,ii));
    
    case 'StSL'
        [H,I] = gStSL(data.vSSph(:,ii));
    
    case 'WFS'
        [H,I] = gWFS(data.vSSph(:,ii));
    
    case 'NFCHOA'
        [H,I] = gNFCHOA(data.vSSph(:,ii));
    % INCLUDE HERE MORE CASES FOR NEW RENDERING METHODS!    
    otherwise
    h = msgbox('Reproduction method not found' ...
            ,'Error','custom',imread('spaticon.png'));
    error('The selected reproduction method has not been defined.');
end

if isempty(I)
    setfigptr('forbidden');
else
    setfigptr('closedhand');
end

% Loudspeakers that will change their rendering
data.I(ii,I) = 1;
Ichange = find(data.I(ii,:)==1);
% Set active loudspeakers for source ii
data.I(ii,:) = 0;
data.I(ii,I) = 1;

% Update filter matrix
data.H(ii,:,:) = zeros(1,conf.nLS,conf.nCoeffs);
if isempty(I)==0
data.H(ii,I,:) = reshape(H.',1,length(I),conf.nCoeffs);
end

% Update filtering for each of the changing loudspeakers
for jj = 1:length(Ichange)
    % When objects are created for the first time
    if isempty(data.Ho{ii,Ichange(jj)})        
        data.Ho{ii,Ichange(jj)} = GfftFIRm(conf.SamplesPerFrame,squeeze(data.H(ii,Ichange(jj),:)));
    end
    UpdateFilter(data.Ho{ii,Ichange(jj)},squeeze(data.H(ii,Ichange(jj),:)));
end

% Save GUI data
guidata(hObject, data); 



end