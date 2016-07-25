function methodpopupcallback(hObject, eventdata, popupdata, VS, ~)
%%METHODPOPUPCALLBACK is the callback function used for changing the
%%reproduction method popup.
%
%
% Input parameters:
%   hObject    -   Handles to reference object.
%   eventdata  -   (Reserved)
%   popupdata  -   Data structure needed, with fields:
%         popupdata.method           -  Array of handles to method objects
%         popupdata.SamplesPerFrame  -  Samples per frame
%         popupdata.NLS              -  Number of loudspeakers
%   VS         -   Cell array of VSource objects.
%
%
% See also: Compstart, VSource, RMethod
%
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

selmethod = get(hObject,'Value');
SamplesPerFrame =  popupdata.SamplesPerFrame;         
method = popupdata.method;
NLS = popupdata.NLS;
NVS = size(VS,1);

% if strcmp(method{selmethod}.type,'AAP')||strcmp(method{selmethod}.type,'WFS')||strcmp(method{selmethod}.type,'NFCHOA')
%     if (sum(setup.LSsph(3,:))~=0 || range(setup.LSsph(1,:))~=0)
%         h = msgbox('Please, check that you are using a circular loudspeaker array.' ...
%              ,'AAP Rendering','custom',imread('spaticon.png'));
%     end
% end

for ii = 1:NVS
% By default, all sources are rendered using the setup method
    setMethod(VS{ii}, method{selmethod});
    
    % Create filter objects for each source
    createRenderer(VS{ii}, SamplesPerFrame, NLS);
    
    %Update filters
    updateRenderer(VS{ii});   
end          

end