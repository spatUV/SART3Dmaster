function v = gSizes
%%GSiZES - Generates data with data corresponding to graphical objects
%
% This function is used by SART3D to get information about the screen
% format and place tidily graphical componentes in the GUI figure.
%
% See also: mPlaceComp, SART3D

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

%% Background color
v.bgColor = [0.941, 0.941, 0.941];

%% Dimensions

%% 
% Get screen dimensions:
screen = get(0, 'screensize');
v.bounds = [0, 0, screen(3)-50, screen(4)-220];

%%
% Layout:
v.margin = 10; % Window margin
v.border_y = v.bounds(2)+v.bounds(4)-v.margin; % Top margin
v.h_comp = 20; % Component Height
v.separator = 2; % Component separation 

%%
% Texts with source number:
v.text_vs_number_x = v.bounds(1)+v.margin;
v.text_vs_number_y = v.border_y;
v.text_vs_number_w = 20;
v.text_vs_number_h = v.h_comp;

%%
% Texts with source name:
v.text_vs_name_x = v.text_vs_number_x+v.separator+v.text_vs_number_w;
v.text_vs_name_y = v.border_y;
v.text_vs_name_w = 80;
v.text_vs_name_h = v.h_comp;

%%
% Edits:
% Spherical coordinates edit boxes:
v.edit_vs_sph_x = v.text_vs_name_x+v.separator+v.text_vs_name_w;
v.edit_vs_sph_y = v.border_y;
v.edit_vs_sph_w = 50;
v.edit_vs_sph_h = v.h_comp;

%%
% Cartesian coordinates edit boxes:
v.edit_vs_car_x = v.edit_vs_sph_x+v.separator+v.edit_vs_sph_w*3+4*v.separator;
v.edit_vs_car_y = v.border_y;
v.edit_vs_car_w = 30;
v.edit_vs_car_h = v.h_comp;

%%
% Checkboxes:
v.checkbox_vs_x = v.edit_vs_car_x+v.separator+v.edit_vs_car_w*3+5*v.separator; % 3 edits
v.checkbox_vs_y = v.border_y;
v.checkbox_vs_w = 35;
v.checkbox_vs_h = v.h_comp;

%% Axis

%%
% Axis (floor view):
v.axes_plan_w = (v.bounds(3)-v.checkbox_vs_x-v.checkbox_vs_w-50*v.separator)/2;
v.axes_plan_h = v.axes_plan_w;

% Additional separation on the left:
v.axes_plan_x = v.checkbox_vs_x+v.checkbox_vs_w+20*v.separator;
v.axes_plan_y = v.border_y-v.axes_plan_h-20;
v.bounds_axes_plan = [v.axes_plan_x, v.axes_plan_y,...
    v.axes_plan_w, v.axes_plan_h];

%%
% Axis (profile view):
v.axes_profile_w = v.axes_plan_w;
v.axes_profile_h = v.axes_plan_h;

% Additional separation on the left:
v.axes_profile_x = v.axes_plan_x+v.axes_plan_w+25*v.separator;
v.axes_profile_y = v.border_y-v.axes_profile_h-20;
v.bounds_axes_profile = [v.axes_profile_x, v.axes_profile_y,...
    v.axes_profile_w, v.axes_profile_h];


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
v.pmDeviceBounds = [v.margin, v.margin, 60, 20]; % Audio Driver

%% Logo
%v.bounds_logo = [v.bounds(3)-170, 40, 0, 0]; % For SPAT logo
v.bounds_logo = [v.bounds(3)-275, 40, 0, 0];  % For SPAT-UV logo

end