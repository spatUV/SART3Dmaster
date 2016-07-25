function v = gSizes()
%%GSiZES - Generates data with data corresponding to graphical objects
%
% This function is used by SART3D to get information about the screen
% format and place tidily graphical componentes in the GUI figure.
%
% See also: mPlaceComp, SART3D

%% Background color
v.bgColor = [0.941, 0.941, 0.941];

%% Dimensions

%% 
% Get screen dimensions:

mon_pos = get(0,'MonitorPositions');
sz = size(mon_pos);
if (sz(1) > 1)
    %screen = mon_pos(sz(1),:);
    v.screen = mon_pos(2,:);
else
    v.screen = get(0, 'screensize');
end

v.bounds = [10, 0.05*v.screen(3), 0.5*v.screen(3), 0.85*v.screen(4)];

%%
% Layout:
v.margin = 10; % Window margin (bottom)
v.border_y = v.bounds(2)+v.bounds(4)-10*v.margin; % Top margin
v.h_comp = 20; % Component Height
v.separator = 2; % Component separation 

%%
% Texts with source number:
v.text_vs_number_x = v.bounds(1)+v.margin;
v.text_vs_number_y = v.border_y-2*v.margin;
v.text_vs_number_w = 20;
v.text_vs_number_h = v.h_comp;

%%
% Texts with source name:
v.text_vs_name_x = v.text_vs_number_x+v.separator+v.text_vs_number_w;
v.text_vs_name_y = v.border_y-2*v.margin;
v.text_vs_name_w = 80;
v.text_vs_name_h = v.h_comp;

%%
% Edits:
% Spherical coordinates edit boxes:
v.edit_vs_sph_x = v.text_vs_name_x+v.separator+v.text_vs_name_w;
v.edit_vs_sph_y = v.border_y-2*v.margin;
v.edit_vs_sph_w = 50;
v.edit_vs_sph_h = v.h_comp;

%%
% Cartesian coordinates edit boxes:
v.edit_vs_car_x = v.edit_vs_sph_x+v.separator+v.edit_vs_sph_w*3+4*v.separator;
v.edit_vs_car_y = v.border_y-2*v.margin;
v.edit_vs_car_w = 30;
v.edit_vs_car_h = v.h_comp;

%%
% Checkboxes:
v.checkbox_vs_x = v.edit_vs_car_x+v.separator+v.edit_vs_car_w*3+5*v.separator; % 3 edits
v.checkbox_vs_y = v.border_y-2*v.margin;
v.checkbox_vs_w = 35;
v.checkbox_vs_h = v.h_comp;


%%
% Axis (floor view):

v.fig_plan_w  = v.screen(3)*0.45;
v.fig_plan_h  = v.fig_plan_w;
v.fig_plan_x  = v.bounds(1)+v.bounds(3);
v.fig_plan_y  = v.bounds(2);
v.bounds_fig_plan =  [v.fig_plan_x, v.fig_plan_y, v.fig_plan_w, v.fig_plan_h];

v.axes_plan_x = 45;
v.axes_plan_y = 45;
v.axes_plan_w = v.fig_plan_w - 2*v.axes_plan_x;
v.axes_plan_h = v.fig_plan_h - 2*v.axes_plan_y;
v.bounds_axes_plan = [v.axes_plan_x, v.axes_plan_y, v.axes_plan_w, v.axes_plan_h];


%%
% Axis (profile view):

v.fig_profile_w  = v.screen(3)*0.45;
v.fig_profile_h  = v.fig_plan_w;
v.fig_profile_x  = v.fig_plan_x + 0.5*v.fig_plan_w;
v.fig_profile_y  = v.bounds(2);
v.bounds_fig_profile =  [v.fig_profile_x, v.fig_profile_y, v.fig_profile_w, v.fig_profile_h];

v.axes_profile_x = 45;
v.axes_profile_y = 45;
v.axes_profile_w = v.fig_profile_w - 2*v.axes_profile_x;
v.axes_profile_h = v.fig_profile_h - 2*v.axes_profile_y;
v.bounds_axes_profile = [v.axes_profile_x, v.axes_profile_y, v.axes_profile_w, v.axes_profile_h];


%% Virtual Source texts


%% 
% Position x, y in gSetSourcePos():
v.text_vs_x = 0;
v.text_vs_y = 0;
v.text_vs_w = 20;
v.text_vs_h = 20;
v.bounds_text_vs = [v.text_vs_x, v.text_vs_y, v.text_vs_w, v.text_vs_h];

%% Loudspeaker texts

%%
% Texts with loudspeaker numbers:
v.text_ls_number_w = 19;
v.text_ls_number_h = 15;
v.text_ls_number_x = 5; % Positioned from the beginning
v.text_ls_number_y = v.axes_plan_y-3*v.text_ls_number_h; % A bit lower

%%
% Texts with loudspeaker dimensions:
v.text_ls_dimens_x = v.text_ls_number_x;
v.text_ls_dimens_y = v.text_ls_number_y-v.text_ls_number_h-v.separator;
v.text_ls_dimens_w = v.text_ls_number_w;
v.text_ls_dimens_h = 20;

%%
% Texts with gains applied to loudspeakers:
v.text_ls_gain_x = v.text_ls_dimens_x;
v.text_ls_gain_y = v.text_ls_dimens_y-v.text_ls_dimens_h-v.separator;
v.text_ls_gain_w = v.text_ls_number_w;
v.text_ls_gain_h = v.text_ls_number_h;

%% Font Sizes

v.legendFontSize = 7;
v.dimensionsFontSize = 7;
v.textsLSNumberFontSize = 7;
v.textsLSDimensFontSize = 7;
v.textsLSGainFontSize = 7;

%% Pop-Up Menus
v.pmDeviceBounds = [v.margin, 80, 60, 20]; % Audio Driver

%% Logo
%v.bounds_logo = [v.bounds(3)-170, 40, 0, 0]; % For SPAT logo
v.bounds_logo = [v.bounds(3)-275, 40,0, 0];  % For SPAT-UV logo
v.bounds_logo = [v.margin+275, 40,0, 0];  % For SPAT-UV logo


end