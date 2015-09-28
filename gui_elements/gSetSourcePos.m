function gSetSourcePos(axes, axes_profile, vS, vS_profile)
%GSETSOURCEPOS places a virtual source at a given position within the axes
%
% Usage:
% gSetSourcePos(axes, axes_profile, vS, vS_profile)
%
% Input parameters:
%   axes - Plan view axes handle
%   
%   axes_profile - Profile view axes handle
%
%   vS - Text uicontrol corresponding to the interacting virtual source 
%   (in plan view)
%
%   vS_profile - Text uicontrol corresponding to the interacting virtual
%   source (in profile view)
%
% See also: GEdit

% Load global configuration structure
global conf

% get axes bounds in plan and profile view
bounds = get(axes, 'position');
bounds_profile = get(axes_profile, 'position');

% Note that 'x' and 'y' in profile view are really 'y' and 'z' coordinates.
axes_x = bounds(1); axes_y = bounds(2);
axes_w = bounds(3); axes_h = bounds(4);
axes_x_profile = bounds_profile(1); axes_y_profile = bounds_profile(2);
axes_w_profile = bounds_profile(3); axes_h_profile = bounds_profile(4);

% Bounds of the virtual source object
bounds = getBounds(vS);
bounds_profile = getBounds(vS_profile);
bounds_w1 = bounds(3); bounds_h1 = bounds(4);
bounds_w1_profile = bounds_profile(3); bounds_h1_profile = bounds_profile(4);

% Center of the virtual source
x_0 = (axes_x+axes_w/2)-bounds_w1/2;
y_0 = (axes_y+axes_h/2)-bounds_h1/2;
x_0_profile = (axes_x_profile+axes_w_profile/2)-bounds_w1_profile/2;
y_0_profile = (axes_y_profile+axes_h_profile/2)-bounds_h1_profile/2;

% Coordinates of the virtual source
coord = getCoord(vS);
p_car = gSph2Car(coord');

% axes.xy_scale is the scaling factor from coordinates to screen pixels
r_pond = conf.axes.xy_scale;

% Get screen pixel coordinates
x = x_0+p_car(1)*r_pond;
y = y_0+p_car(2)*r_pond;
x_profile = x_0_profile+p_car(2)*r_pond;
y_profile = y_0_profile+p_car(3)*r_pond;

% Move source objects to corresponding coordinates
setBounds(vS, [x, y, 20, 20]);
setBounds(vS_profile, [x_profile, y_profile, 20, 20]);
end