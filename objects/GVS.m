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

classdef GVS < GUicontrol
    %GVS is a cutomized edit (text) uicontrol.
    %   It is used to depict a virtual source object. The user can interact
    %   with this uicontrol to move virtual sources in the scene.
    
    properties
        N; % Corresonding virtual source index
        Coord; % Spherical coordinates of the source.
        % radius [m], azimuth [º], elevation [º].
    end
    
    methods
        function obj = GVS(parent, string, tag, bounds, n, coord)
            % Constructor.
            % parent - Parent figure.
            % string - Text with value.
            % tag - Label (to be used with guihandles).
            % bounds - Uicontrol dimensions.
            % n - Virtual source index.
            % coord - Spherical coordinates of the source.
            
            % Call the SuperClass constructor:
            obj = obj@GUicontrol(parent, 'edit', string, tag, bounds);
            
            % Assign virtual source index and coordinates:
            obj.N = n;
            obj.Coord = coord;
            
            % Graphical aspects:
            %setBackgroundColor(obj, 'g'); % Green background default
            color = [0.7 0.9 0.7];
            setBackgroundColor(obj, color);
            setForegroundColor(obj,'b');  % Blue foreground default
            setFontSize(obj, 12); % Font size
        end
        
        function setCoord(obj, coord)
            % Changes the virtual source coordinates
            % obj - Reference to object.
            % coord - New source coordinates (overwrite the previous ones)

            obj.Coord = coord;
        end
        
        function coord = getCoord(obj)
            % Returns the source coordinates.
            % obj - Reference to object.
            
            coord = obj.Coord;
        end
        
        function n = getN(obj)
            % Returns the corresponding source index.
            % obj - Reference to object.
            
            n = obj.N;
        end
        
    end
end
    