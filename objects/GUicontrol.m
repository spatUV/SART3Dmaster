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

classdef GUicontrol < hgsetget
    %GUicontrol is the SuperClass corresponding to all customized
    %uicontrols in this toolbox
    
    properties (Access = private)
        Control
    end
    
    methods
        function obj = GUicontrol(parent, style, string, tag, bounds, value)
            % Constructor.
            % parent - Parent figure.
            % style - Uicontrol type.
            % string - Text with the value.
            % tag - Label (to be used with guihandles).
            % bounds - Uicontrol dimensions.
            
            % Call uicontrol class constructor:
            obj.Control = uicontrol(parent,...
            'Style', style,...
            'String', string,...
            'Tag', tag,...
            'Position', bounds,...
            'Value', value,...
            'Callback', @obj.callback);
            
            % Get sure that the object is deleted if the uicontrol is
            % eliminated
            set(obj.Control, 'DeleteFcn', {@(source, eventData)delete(obj)});
        end
        
      
        %------------------------------------------------------------------
        % We define setters and getters for the properties dependent on the
        % parent class. Basically, they only redirect the calls to
        % uicontrol.
          %------------------------------------------------------------------
        function fontSize = getFontSize(obj)
            fontSize = get(obj.Control, 'FontSize');
        end

        function setFontSize(obj, fontSize)
            set(obj.Control, 'FontSize', fontSize);
        end
        
        function fontWeight = getFontWeight(obj)
            fontWeight = get(obj.Control, 'FontWeight');
        end

        function setFontWeight(obj, fontWeight)
            set(obj.Control, 'FontWeight', fontWeight);
        end

        function backgroundColor = getBackgroundColor(obj)
            backgroundColor = get(obj.Control, 'BackgroundColor');
        end

        function setBackgroundColor(obj, backgroundColor)
            set(obj.Control, 'BackgroundColor', backgroundColor);
        end

        function foregroundColor = getForegroundColor(obj)
            foregroundColor = get(obj.Control, 'ForegroundColor');
        end

        function setForegroundColor(obj, foregroundColor)
            set(obj.Control, 'ForegroundColor', foregroundColor);
        end

        function string = getString(obj)
            string = get(obj.Control, 'String');
        end

        function setString(obj, string)
            set(obj.Control, 'String', string);
        end
        
        function bounds = getBounds(obj)
            bounds = get(obj.Control, 'Position');
        end
        
        function setBounds(obj, bounds)
            set(obj.Control, 'Position', bounds);
        end
        
        function tag = getTag(obj)
            tag = get(obj.Control, 'Tag');
        end

        function setTag(obj, tag)
            set(obj.Control, 'Tag', tag);
        end

        function setImage(obj, image)
            set(obj.Control, 'CData', image);
        end

        function setHitTest(obj, val)
            set(obj.Control, 'HitTest', val);
        end

        function setEnabled(obj, val)
            set(obj.Control, 'Enable', val);
        end

        function parent = getParent(obj)
            parent = get(obj.Control, 'Parent');
        end

        function value = getValue(obj)
            value = get(obj.Control, 'Value');
        end

        function setValue(obj, val)
            set(obj.Control, 'Value', val);
        end
        
        function setButtonDownFcn(obj, val)
            set(obj.Control, 'ButtonDownFcn', val);
        end
        
        % The callback must be overlodad in the child class
        function callback(~, ~, ~)
        end
    end
end