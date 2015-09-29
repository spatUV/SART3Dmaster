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
            obj = obj@GUicontrol(parent, 'popupmenu', string, tag, bounds);
            
            % Load properties:
            obj.Tag = tag;
                        
            % Set background color to white:
            setBackgroundColor(obj, 'w');
            
            % Set selected item:
            setValue(obj, value);
            

            
        end
        
        function callback(hObject, ~, ~)
            % Actions to performed when the object is selected.
            % hObject - Reference to selected object.

            % If the rendering method changes, we automatically reset
            % the filters to change instantly to the new method.
            if strcmp(hObject.Tag, 'pmMethod')
                global conf handles;
                
                % load GUI data
                data = guidata(getParent(hObject));
                guidata(getParent(hObject), data);
                
                % Set normal listener image
                GImage(gcf, '', get(handles.axes_plan,'Position'), (['guy_plan.png']));
                GImage(gcf, '', get(handles.axes_profile,'Position'), (['guy_profile.png']));
                
                switch conf.methods.names{get(handles.pmMethod, 'Value')}
                    case 'VBAP'
                        conf.nCoeffs = 1;
                        if isfield(conf,'VBAP')==0
                            VBAPstart;
                        end
                    case 'AAP'
                        conf.nCoeffs = 1;
                        if isfield(conf,'AAP')==0
                            AAPstart;
                        end
                    case 'HRTF'
                        conf.nCoeffs = 128;
                        % Set listener with headphones image
                        GImage(gcf, '', get(handles.axes_plan,'Position'), (['guy_plan_hp.png']));
                        GImage(gcf, '', get(handles.axes_profile,'Position'), (['guy_profile_hp.png']));
                        if isfield(conf,'HRIR')==0
                            HRTFstart;
                        end
                    case  'StTL'
                        conf.nCoeffs = 1;
                        if isfield(conf,'StTL')==0
                            StTLstart;
                        end                        
                    case  'StSL'
                        conf.nCoeffs = 1;
                        if isfield(conf,'StSL')==0
                            StSLstart;
                        end                        
                    case  'WFS'
                        conf.nCoeffs = 128;
                        if isfield(conf,'WFS')==0
                            WFSstart;
                        end                        
                    case  'NFCHOA'
                        conf.nCoeffs = 128;
                        if isfield(conf,'NFCHOA')==0
                            NFCHOAstart;
                        end 
                    otherwise
                        h = msgbox('Reproduction method not found' ...
                        ,'Error','custom',imread('spaticon.png'));
                        error('The selected reproduction method has not been defined.');
                        return;
                end            
                
                if exist('data')
                    if isfield(data,'H');
                        data.H = zeros(conf.nVS, conf.nLS, conf.nCoeffs);
                    end
                end
                
                % reset filtering objects
                data.Ho = cell(size(data.H));
                guidata(getParent(hObject), data);
                % initialize rendering objects
                for ii = 1:size(data.H,1)
                    gRefreshH(getParent(hObject), ii);
                end
            end            
        end
    end
end