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

classdef GImage < GUicontrol
    %GImage is a customized pushbutton uicontrol.
    %   It places a given image in the GUI on a given location
    
    properties
        Image; % Image to show
    end
    
    methods
        function obj = GImage(parent, tag, bounds, res)
            % Constructor.
            % parent - Parent figure.
            % tag - Tag (to be used with guihandles).
            % bounds - Uicontrol dimensions.
            % res - Resource (image) to include.
                       
            % Get height and width of image:
            image = imread(res); %
            [h, w, ~] = size(image); % height, width ()

            x = bounds(1)+bounds(3)/2-w/2; % Calculate x
            y = bounds(2)+bounds(4)/2-h/2; % Calculate y

            % Set bounds to place the image in the center:
            bounds = [x, y, w, h];
            
            % SuperClass constructor:
            obj = obj@GUicontrol(parent, 'pushbutton', '', tag, bounds, []);

            % Place image:
            setImage(obj, image);
            
            % Avoid that it could be selected:
            setHitTest(obj, 'off');
            
            % Set inactive:
            setEnabled(obj, 'inactive');
            
            % Load property:
            obj.Image = image;
        end
    end 
end