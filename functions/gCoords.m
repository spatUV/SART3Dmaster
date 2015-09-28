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