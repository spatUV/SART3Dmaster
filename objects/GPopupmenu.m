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

classdef GPopupmenu < GUicontrol
    %GImage is a customized pop-up menu uicontrol.
    %   It is used to select options from pop-up menus.
    
    properties
        Tag; % Uicontrol tag.
    end
    
    methods
        function obj = GPopupmenu(parent, string, value, tag, bounds)
            % Constructor.
            % parent - Parent figure.
            % string - Text with value.
            % value - Selected item.
            % tag - Tag (to be used with guihandles).
            % bounds - Uicontrol dimensions.
         
            % SuperClass constructor:
            obj = obj@GUicontrol(parent, 'popupmenu', string, tag, bounds, []);
            
            % Load properties:
            obj.Tag = tag;
                        
            % Set background color to white:
            setBackgroundColor(obj, 'w');
            
            % Set selected item:
            setValue(obj, value);
            

            
        end
        
%         function callback(hObject, conf, setup, method, VS, ~)
%             % Actions to performed when the object is selected.
%             % hObject - Reference to selected object.
% 
%             % If the rendering method changes, we automatically reset
%             % the filters to change instantly to the new method.
%             
%             if strcmp(hObject.Tag, 'pmMethod')
%             
%                 selmethod = get(hObject,'Value');                        
%                 NVS = size(VS,1);
%                 for ii = 1:NVS
%                     % By default, all sources are rendered using the setup method
%                     setMethod(VS{ii}, method{selmethod});
%     
%                     % Create filter objects for each source
%                     createRenderer(VS{ii}, conf, setup);
%     
%                     % Update filters
%                     updateRenderer(VS{ii});   
%                 end                
%             end
%             
%             if strcmp(hObject.Tag, 'pmBufferSize')
%                 global handles;
%                 disp('Buffer Size changed to:'); 
%                 bufferSize = get(handles.pmBufferSize, 'String');
%                 bufferSizeSelected = bufferSize(get(handles.pmBufferSize, 'Value'));
%                 disp(bufferSizeSelected)
%             end
%             
%         end
    end
end