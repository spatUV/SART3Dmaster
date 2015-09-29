%% Component Placement Script
%
% This script places different elements in the GUI by using the information
% from gSizes and the initial configuration structure.
%
% See also: gSizes, SART3D, gConfig

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

%% === Initialize Component Arrays ========================================

% --- Initialize component arrays ----------:
textsVSNumber = {conf.nVS};
textsVSName = {conf.nVS};
editsVSCar = {conf.nVS, 3};
checkboxesVS = {conf.nVS};
textsVS = {conf.nVS};
textsVSProfile = {conf.nVS};
textsLSGain = {conf.nLS};

% If spherical coordinates edits are active:
if strcmp(conf.viewSphEdits, 'on')
    editsVSSph = {conf.nVS, 3};
end

%% === Legends  Line =======================================================
% Texts
legendTextsVSNumber = GSimpleText(f, '#', '',...
    [v.text_vs_number_x,...
    v.text_vs_number_y-v.text_vs_number_h-v.separator,...
    v.text_vs_number_w, v.text_vs_number_h]);
    
legendTextsVSName = GSimpleText(f, 'Sources', '', ...
    [v.text_vs_name_x,...
    v.text_vs_name_y-v.text_vs_name_h-v.separator,...
    v.text_vs_name_w, v.text_vs_name_h]);

if strcmp(conf.viewSphEdits, 'on')
    legendEditsVSRadius = GSimpleText(f, 'Radius', '',...
        [v.edit_vs_sph_x+v.separator,...
        v.edit_vs_sph_y-v.edit_vs_sph_h-v.separator,...
        v.edit_vs_sph_w, v.edit_vs_sph_h]);

    legendEditsVSAzimuth = GSimpleText(f, 'Azimuth', '',...
        [v.edit_vs_sph_x+v.edit_vs_sph_w+2*v.separator,...
        v.edit_vs_sph_y-v.edit_vs_sph_h-v.separator,...
        v.edit_vs_sph_w, v.edit_vs_sph_h]);

    legendEditsVSElevation = GSimpleText(f, 'Elevation', '',...
        [v.edit_vs_sph_x+2*v.edit_vs_sph_w+3*v.separator,...
        v.edit_vs_sph_y-v.edit_vs_sph_h-v.separator,...
        v.edit_vs_sph_w, v.edit_vs_sph_h]);
end

legendEditsVSX = GSimpleText(f, 'x', '',...
    [v.edit_vs_car_x+v.separator,...
    v.edit_vs_car_y-v.edit_vs_car_h-v.separator,...
    v.edit_vs_car_w, v.edit_vs_car_h]);
    
legendEditsVSY = GSimpleText(f, 'y', '',...
    [v.edit_vs_car_x+v.edit_vs_car_w+2*v.separator,...
    v.edit_vs_car_y-v.edit_vs_car_h-v.separator,...
    v.edit_vs_car_w, v.edit_vs_car_h]);
    
legendEditsVSZ = GSimpleText(f, 'z', '',...
    [v.edit_vs_car_x+2*v.edit_vs_car_w+3*v.separator,...
    v.edit_vs_car_y-v.edit_vs_car_h-v.separator,...
    v.edit_vs_car_w, v.edit_vs_car_h]);
        
legendCheckboxesVS = GSimpleText(f, 'check', '',...
    [v.checkbox_vs_x+2*v.separator,...
    v.checkbox_vs_y-v.checkbox_vs_h-v.separator,...
    v.checkbox_vs_w, v.checkbox_vs_h]);

% Modify fonts:
setFontSize(legendTextsVSNumber, v.legendFontSize);
setFontSize(legendTextsVSName, v.legendFontSize);

if strcmp(conf.viewSphEdits, 'on')
    setFontSize(legendEditsVSRadius, v.legendFontSize);
    setFontSize(legendEditsVSAzimuth, v.legendFontSize);
    setFontSize(legendEditsVSElevation, v.legendFontSize);
end

setFontSize(legendEditsVSX, v.legendFontSize);
setFontSize(legendEditsVSY, v.legendFontSize);
setFontSize(legendEditsVSZ, v.legendFontSize);
setFontSize(legendCheckboxesVS, v.legendFontSize);

setFontWeight(legendTextsVSName, 'bold');

if strcmp(conf.viewSphEdits, 'on')
    setFontWeight(legendEditsVSRadius, 'bold');
    setFontWeight(legendEditsVSAzimuth, 'bold');
    setFontWeight(legendEditsVSElevation, 'bold');
end

setFontWeight(legendEditsVSX, 'bold');
setFontWeight(legendEditsVSY, 'bold');
setFontWeight(legendEditsVSZ, 'bold');
setFontWeight(legendCheckboxesVS, 'bold');

%% == Units Info Line =====================================================

% Set dimensions:
dimensionsTextsVSNumber = GSimpleText(f, '[#]', '',...
    [v.text_vs_number_x,...
    v.text_vs_number_y-2*v.text_vs_number_h-v.separator,...
    v.text_vs_number_w, v.text_vs_number_h]);
    
dimensionsTextsVSName = GSimpleText(f, '[name]', '',...
    [v.text_vs_name_x,...
    v.text_vs_name_y-2*v.text_vs_name_h-v.separator,...
    v.text_vs_name_w, v.text_vs_name_h]);
 
if strcmp(conf.viewSphEdits, 'on')
    dimensionsEditsVSRadius = GSimpleText(f, '[m]', '',...
        [v.edit_vs_sph_x+v.separator,...
        v.edit_vs_sph_y-2*v.edit_vs_sph_h-v.separator,...
        v.edit_vs_sph_w, v.edit_vs_sph_h]);

    dimensionsEditsVSAzimuth = GSimpleText(f, '[º]', '',...
        [v.edit_vs_sph_x+v.edit_vs_sph_w+2*v.separator,...
        v.edit_vs_sph_y-2*v.edit_vs_sph_h-v.separator,...
        v.edit_vs_sph_w, v.edit_vs_sph_h]);

    dimensionsEditsVSElevation = GSimpleText(f, '[º]', '',...
        [v.edit_vs_sph_x+2*v.edit_vs_sph_w+3*v.separator,...
        v.edit_vs_sph_y-2*v.edit_vs_sph_h-v.separator,...
        v.edit_vs_sph_w, v.edit_vs_sph_h]);
end

dimensionsEditsVSX = GSimpleText(f, '[m]', '',...
    [v.edit_vs_car_x+v.separator,...
    v.edit_vs_car_y-2*v.edit_vs_car_h-v.separator,...
    v.edit_vs_car_w, v.edit_vs_car_h]);
    
dimensionsEditsVSY = GSimpleText(f, '[m]', '',...
    [v.edit_vs_car_x+v.edit_vs_car_w+2*v.separator,...
    v.edit_vs_car_y-2*v.edit_vs_car_h-v.separator,...
    v.edit_vs_car_w, v.edit_vs_car_h]);
    
dimensionsEditsVSZ = GSimpleText(f, '[m]', '',...
    [v.edit_vs_car_x+2*v.edit_vs_car_w+3*v.separator,...
    v.edit_vs_car_y-2*v.edit_vs_car_h-v.separator,...
    v.edit_vs_car_w, v.edit_vs_car_h]);
    
dimensionsCheckboxesVS = GSimpleText(f, 'Sound', '',...
    [v.checkbox_vs_x+2*v.separator,...
    v.checkbox_vs_y-2*v.checkbox_vs_h-v.separator,...
    v.checkbox_vs_w, v.checkbox_vs_h]);

% Modify fonts:
setFontSize(dimensionsTextsVSNumber, v.dimensionsFontSize);
setFontSize(dimensionsTextsVSName, v.dimensionsFontSize);

if strcmp(conf.viewSphEdits, 'on')
    setFontSize(dimensionsEditsVSRadius, v.dimensionsFontSize);
    setFontSize(dimensionsEditsVSAzimuth, v.dimensionsFontSize);
    setFontSize(dimensionsEditsVSElevation, v.dimensionsFontSize);
end
setFontSize(dimensionsEditsVSX, v.dimensionsFontSize);
setFontSize(dimensionsEditsVSY, v.dimensionsFontSize);
setFontSize(dimensionsEditsVSZ, v.dimensionsFontSize);
setFontSize(dimensionsCheckboxesVS, v.dimensionsFontSize);

setFontWeight(dimensionsTextsVSNumber, 'bold');
setFontWeight(dimensionsTextsVSName, 'bold');

if strcmp(conf.viewSphEdits, 'on')
    setFontWeight(dimensionsEditsVSRadius, 'bold');
    setFontWeight(dimensionsEditsVSAzimuth, 'bold');
    setFontWeight(dimensionsEditsVSElevation, 'bold');
end

setFontWeight(dimensionsEditsVSX, 'bold');
setFontWeight(dimensionsEditsVSY, 'bold');
setFontWeight(dimensionsEditsVSZ, 'bold');
setFontWeight(dimensionsCheckboxesVS, 'bold');

%% === Virtual Sources Info ===============================================

% Source after source we place components 
% (from last to first to have them ordered in handles)
for ii = conf.nVS:-1:1
    % Text indicating source number:
    textsVSNumber{ii} = GSimpleText(f, num2str(ii),...
        'textsVSNumber',...
        [v.text_vs_number_x,...
        v.text_vs_number_y-(ii+2)*v.text_vs_number_h-ii*v.separator,...
        v.text_vs_number_w, v.text_vs_number_h]);
    
    % Text indicating font name:
    textsVSName{ii} = GSimpleText(f, conf.VS.names{ii},...
        '',...
        [v.text_vs_name_x,...
        v.text_vs_name_y-(ii+2)*v.text_vs_name_h-ii*v.separator,...
        v.text_vs_name_w, v.text_vs_name_h]);
    
    % CheckBox indicating reproduction.
    checkboxesVS{ii} = GCheckbox(f,...
        'checkboxesVS',...
        [v.checkbox_vs_x+5*v.separator,...
        v.checkbox_vs_y-(ii+2)*v.checkbox_vs_h-ii*v.separator,...
        v.checkbox_vs_w, v.checkbox_vs_h]);
    
    % Text-box indicating the virtual source to interact with user:
    textsVS{ii} = GVS(f, num2str(ii),...
        'textsVS',...
        v.bounds_text_vs, ii, data.vSSph(:, ii)');
    
    textsVSProfile{ii} = GVS(f, num2str(ii),...
        'textsVSProfile',...
        v.bounds_text_vs, ii, data.vSSph(:, ii)');
    
    % Set virtual source to position specified by initial configuration:
    gSetSourcePos(handles.axes_plan, handles.axes_profile,...
        textsVS{ii}, textsVSProfile{ii});
    
    VSCar = gSph2Car(data.vSSph);
    % Edits to indicate source locations.
    % We explore 3 fields, either "radius, azimuth, elevation" or "x, y, z"
    % We load them in the last place, since they are dependent on the
    % reference object corresponding to the virtual source.
    % (from last to first, to get them ordered in handles):
    for jj = 3:-1:1
        % If spherical edits are active:
        if strcmp(conf.viewSphEdits, 'on')
            editsVSSph{ii, jj} = GEdit(f, data.vSSph(jj, ii),...
            (['editsVSSph_', num2str(jj)]),...
            [v.edit_vs_sph_x+(jj-1)*v.edit_vs_sph_w+jj*v.separator,...
            v.edit_vs_sph_y-(ii+2)*v.edit_vs_sph_h-ii*v.separator,...
            v.edit_vs_sph_w, v.edit_vs_sph_h],...
            ii, jj, textsVS{ii}, textsVSProfile{ii});
        end
        
        % Ony 2 digits what we include in GEdit:
        editsVSCar{ii, jj} = GEdit(f, roundn(VSCar(jj, ii), -2),...
        (['editsVSCar_', num2str(jj)]),...
        [v.edit_vs_car_x+(jj-1)*v.edit_vs_car_w+jj*v.separator,...
        v.edit_vs_car_y-(ii+2)*v.edit_vs_car_h-ii*v.separator,...
        v.edit_vs_car_w, v.edit_vs_car_h],...
        ii, jj+3, textsVS{ii}, textsVSProfile{ii}); % Magnitude 4,5,6 --> x,y,z
    end
end



%% === PopupMenus =========================================================
% To select audio device.
% Place it to left bottom
pmDevice = GPopupmenu(f, conf.driver.deviceNames,...
    1, 'pmDevice', v.pmDeviceBounds);

% Text:
textPmDeviceBounds = [v.pmDeviceBounds(1), v.pmDeviceBounds(2)+v.h_comp,...
    v.pmDeviceBounds(3), v.pmDeviceBounds(4)]; % Texto descriptivo
textPmDevice = GSimpleText(f, 'Driver', '', textPmDeviceBounds);
setFontSize(textPmDevice, v.dimensionsFontSize);
setFontWeight(textPmDevice, 'bold');

% BufferSize:
bounds_pmBufferSize = getBounds(pmDevice);
bounds_pmBufferSize(1) = bounds_pmBufferSize(1)+...
    bounds_pmBufferSize(3)+v.margin;
pmBufferSize = GPopupmenu(f, conf.bufferSize.items,...
    conf.bufferSize.selected, 'pmBufferSize', bounds_pmBufferSize);

% Text:
textPmBufferSize = [bounds_pmBufferSize(1), bounds_pmBufferSize(2)+v.h_comp,...
    bounds_pmBufferSize(3), bounds_pmBufferSize(4)];
textPmBufferSize = GSimpleText(f, 'Buffer Size', '', textPmBufferSize);
setFontSize(textPmBufferSize, v.dimensionsFontSize);
setFontWeight(textPmBufferSize, 'bold');


% Rendering method.
bounds_pmMethod = getBounds(pmBufferSize);
bounds_pmMethod(1) = bounds_pmMethod(1)+...
    bounds_pmMethod(3)+v.margin;
% GPopupmenu(f, conf.methods.names,...
%     conf.methods.selected, 'pmMethod', bounds_pmMethod);

for ii = 1:length(conf.methods.names)
    if strcmp(conf.methods.names(ii),conf.methods.selected)
        valuesel = ii;
    end
end
pmMethod = GPopupmenu(f, conf.methods.names,...
    valuesel, 'pmMethod', bounds_pmMethod);


% Text:
textPmMethod = [bounds_pmMethod(1), bounds_pmMethod(2)+v.h_comp,...
    bounds_pmMethod(3), bounds_pmMethod(4)];
textPmMethod = GSimpleText(f, 'Render', '', textPmMethod);
setFontSize(textPmMethod, v.dimensionsFontSize);
setFontWeight(textPmMethod, 'bold');

% Active Loudspeakers
bounds_CheckActive = getBounds(pmMethod);
bounds_CheckActive(1) = bounds_CheckActive(1)+...
    bounds_CheckActive(3)+3*v.margin;
checkActive = uicontrol(f,'Style', 'checkbox','Tag','checkBoxActive','Position',bounds_CheckActive);
set(checkActive,'Value',conf.plot.activels);


% Text:
textCheckActive = [bounds_CheckActive(1)-2*v.margin,bounds_CheckActive(2)+v.h_comp,...
    bounds_CheckActive(3), bounds_CheckActive(4)];
textCheckActive = GSimpleText(f, 'Active Speakers', '', textCheckActive);
setFontSize(textCheckActive, v.dimensionsFontSize);
setFontWeight(textCheckActive, 'bold');


%% === Toolbar ============================================================
toolBar = uitoolbar(f); 
%-- ToggleButton - play -------------------------------------------------
uitoggletool('Parent', toolBar,...
    'CData', imread('play.png'),...
    'OnCallback', @tbPlayOnCallback,...
    'OffCallback', @tbPlayOffCallback,...
    'TooltipString', 'Pulse para iniciar/detener la reproducción');



