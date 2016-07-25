function gSetSourcePos(scale,vS,view)
%GSETSOURCEPOS places a virtual source box at a given position
%
% Usage:
% gSetSourcePos(scale, vS, view)
%
% Input parameters:
%   axes - Axes handle (plan or profile, depending on view)
%   
%   vS - GVS uicontrol corresponding to the interacting virtual source 
%   (in plan view)
%
%   view - String specifying 'plan' or 'profile' view
%
% See also: VSource, GVS

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

% Load global configuration structure
%global conf

% get axes bounds in plan and profile view
axes   = vS.axes;
bounds = get(axes, 'position');

% Note that 'x' and 'y' in profile view are really 'y' and 'z' coordinates.
axes_x = bounds(1); axes_y = bounds(2);
axes_w = bounds(3); axes_h = bounds(4);

% Bounds of the virtual source object
bounds = getBounds(vS);
bounds_w1 = bounds(3); bounds_h1 = bounds(4);

% Center of the virtual source
x_0 = (axes_x+axes_w/2)-bounds_w1/2;
y_0 = (axes_y+axes_h/2)-bounds_h1/2;

% Coordinates of the virtual source
coord = getCoord(vS);
p_car = gSph2Car(coord');

% axes.xy_scale is the scaling factor from coordinates to screen pixels
r_pond = scale;

% Get screen pixel coordinates
x = x_0+p_car(1)*r_pond;
y = y_0+p_car(2)*r_pond;
if strcmp(view,'profile')
    x = x_0+p_car(2)*r_pond;
    y = y_0+p_car(3)*r_pond;
end

% Move source objects to corresponding coordinates
setBounds(vS, [x, y, 20, 20]);

end