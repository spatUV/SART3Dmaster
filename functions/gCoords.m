function [dim1,dim2] = gCoords(mouse_x, mouse_y, bounds_axes, xy_scale, view)
%GCOORDS Calculates coordinates in axes from figure inputs.
%   Returns both spherical and Cartesian coordinates (depending on view).
%
% Usage:
%   [dim1, dim2] = gCoords(mouse_x, mouse_y, bounds_axes, xy_scale, view)
%
% Input parameters:
%   mouse_x - horizontal position of mouse pointer in figure (corresponding 
%   to the selected virtual source).
%
%   mouse_y - vertical position of mouse pointer in figure (corresponding to 
%   the selected virtual source).
%
%   bounds_axes - Axes bounds [x, y, w, h].
%
%   xy_scale - Scaling factor mapping axes limits to axes size.
%
%   view - Related view ('plan' or 'profile').
%
% Output parameters:
%   dim1 - x [m] if view is 'plan' or y [m] is view is 'profile'.
%   dim2 - y [m] if view is 'plan' or z [m] is view is 'profile'.
%
%   See also: gDnD

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

if strcmp(view, 'plan')
    x = mouse_x - bounds_axes(1) - bounds_axes(3)/2;
    y = mouse_y - bounds_axes(2) - bounds_axes(4)/2;
    x = (1/xy_scale)*x;
    y = (1/xy_scale)*y;
    dim1 = x;
    dim2 = y;
elseif strcmp(view, 'profile')
    y = mouse_x - bounds_axes(1) - bounds_axes(3)/2;
    z = mouse_y - bounds_axes(2) - bounds_axes(4)/2;
    y = (1/xy_scale)*y;
    z = (1/xy_scale)*z;
    dim1 = y;
    dim2 = z;
end