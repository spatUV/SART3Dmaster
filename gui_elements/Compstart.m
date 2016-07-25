function [] = Compstart(f,conf,setup,guidim, method, VS)
%%COMPSTART Places components in GUI main figure
%
% Usage:
%   [] = Compstart(f,conf,setup,guidim, method, VS)
%
% Input parameters:
%   f       - Main GUI figure handle
%   conf    - SART3D configuration structure
%   setup   - SART3D setup structure
%   guidim  - SART3D GUI dimensions structure as obtained by *gSizes*.
%   method  - handles to rendering method objects
%   VS      - cell array of Virtual Source objects
%
% See also: SART3D, gSizes, gConfig, VSource, RMethod.

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

%=====================================================================
% PLACE COMPONENTS
%=====================================================================

% Number of virtual sources
NVS = size(VS,1);

% --- Initialize component arrays ----------:
textsVSNumber = cell(NVS,1);
textsVSName   = cell(NVS,1);
editsVSCar    = cell(NVS,3);
checkboxesVS  = cell(NVS,1);
textsLSGain   = cell(setup.NLS,1);


% === Legends  Line =======================================================
% Texts

legendTextsVSNumber = GSimpleText(f, '#', '',...
   [guidim.text_vs_number_x,...
    guidim.text_vs_number_y,...
    guidim.text_vs_number_w, guidim.text_vs_number_h]);
    
legendTextsVSName = GSimpleText(f, 'Sources', '', ...
   [guidim.text_vs_name_x,...
    guidim.text_vs_name_y,...
    guidim.text_vs_name_w, guidim.text_vs_name_h]);


legendEditsVSRadius = GSimpleText(f, 'Radius', '',...
   [guidim.edit_vs_sph_x+guidim.separator,...
    guidim.edit_vs_sph_y,...
    guidim.edit_vs_sph_w, guidim.edit_vs_sph_h]);
    

legendEditsVSAzimuth = GSimpleText(f, 'Azimuth', '',...
   [guidim.edit_vs_sph_x+guidim.edit_vs_sph_w+2*guidim.separator,...
    guidim.edit_vs_sph_y,...
    guidim.edit_vs_sph_w, guidim.edit_vs_sph_h]);

    
legendEditsVSElevation = GSimpleText(f, 'Elevation', '',...
   [guidim.edit_vs_sph_x+2*guidim.edit_vs_sph_w+3*guidim.separator,...
    guidim.edit_vs_sph_y,...
    guidim.edit_vs_sph_w, guidim.edit_vs_sph_h]);


legendEditsVSX = GSimpleText(f, 'x', '',...
   [guidim.edit_vs_car_x+guidim.separator,...
    guidim.edit_vs_car_y,...
    guidim.edit_vs_car_w, guidim.edit_vs_car_h]);


legendEditsVSY = GSimpleText(f, 'y', '',...
   [guidim.edit_vs_car_x+guidim.edit_vs_car_w+2*guidim.separator,...
    guidim.edit_vs_car_y,...
    guidim.edit_vs_car_w, guidim.edit_vs_car_h]);
    

legendEditsVSZ = GSimpleText(f, 'z', '',...
   [guidim.edit_vs_car_x+2*guidim.edit_vs_car_w+3*guidim.separator,...
    guidim.edit_vs_car_y,...
    guidim.edit_vs_car_w, guidim.edit_vs_car_h]);
        

legendCheckboxesVS = GSimpleText(f, 'check', '',...
   [guidim.checkbox_vs_x+2*guidim.separator,...
    guidim.checkbox_vs_y,...
    guidim.checkbox_vs_w, guidim.checkbox_vs_h]);


% Modify fonts:
setFontSize(legendTextsVSNumber, guidim.legendFontSize);
setFontSize(legendTextsVSName, guidim.legendFontSize);
setFontSize(legendEditsVSRadius, guidim.legendFontSize);
setFontSize(legendEditsVSAzimuth, guidim.legendFontSize);
setFontSize(legendEditsVSElevation, guidim.legendFontSize);
setFontSize(legendEditsVSX, guidim.legendFontSize);
setFontSize(legendEditsVSY, guidim.legendFontSize);
setFontSize(legendEditsVSZ, guidim.legendFontSize);
setFontSize(legendCheckboxesVS, guidim.legendFontSize);
setFontWeight(legendTextsVSName, 'bold');
setFontWeight(legendEditsVSRadius, 'bold');
setFontWeight(legendEditsVSAzimuth, 'bold');
setFontWeight(legendEditsVSElevation, 'bold');
setFontWeight(legendEditsVSX, 'bold');
setFontWeight(legendEditsVSY, 'bold');
setFontWeight(legendEditsVSZ, 'bold');
setFontWeight(legendCheckboxesVS, 'bold');

% == Units Info Line =====================================================

% Set dimensions:
dimensionsTextsVSNumber = GSimpleText(f, '[#]', '',...
   [guidim.text_vs_number_x,...
    guidim.text_vs_number_y-1*guidim.text_vs_number_h-guidim.separator,...
    guidim.text_vs_number_w, guidim.text_vs_number_h]);
    
dimensionsTextsVSName = GSimpleText(f, '[name]', '',...
   [guidim.text_vs_name_x,...
    guidim.text_vs_name_y-1*guidim.text_vs_name_h-guidim.separator,...
    guidim.text_vs_name_w, guidim.text_vs_name_h]);
 
dimensionsEditsVSRadius = GSimpleText(f, '[m]', '',...
   [guidim.edit_vs_sph_x+guidim.separator,...
    guidim.edit_vs_sph_y-1*guidim.edit_vs_sph_h-guidim.separator,...
    guidim.edit_vs_sph_w, guidim.edit_vs_sph_h]);

dimensionsEditsVSAzimuth = GSimpleText(f, '[º]', '',...
   [guidim.edit_vs_sph_x+guidim.edit_vs_sph_w+2*guidim.separator,...
    guidim.edit_vs_sph_y-1*guidim.edit_vs_sph_h-guidim.separator,...
    guidim.edit_vs_sph_w, guidim.edit_vs_sph_h]);

dimensionsEditsVSElevation = GSimpleText(f, '[º]', '',...
   [guidim.edit_vs_sph_x+2*guidim.edit_vs_sph_w+3*guidim.separator,...
    guidim.edit_vs_sph_y-1*guidim.edit_vs_sph_h-guidim.separator,...
    guidim.edit_vs_sph_w, guidim.edit_vs_sph_h]);

dimensionsEditsVSX = GSimpleText(f, '[m]', '',...
   [guidim.edit_vs_car_x+guidim.separator,...
    guidim.edit_vs_car_y-1*guidim.edit_vs_car_h-guidim.separator,...
    guidim.edit_vs_car_w, guidim.edit_vs_car_h]);
    
dimensionsEditsVSY = GSimpleText(f, '[m]', '',...
   [guidim.edit_vs_car_x+guidim.edit_vs_car_w+2*guidim.separator,...
    guidim.edit_vs_car_y-1*guidim.edit_vs_car_h-guidim.separator,...
    guidim.edit_vs_car_w, guidim.edit_vs_car_h]);
    
dimensionsEditsVSZ = GSimpleText(f, '[m]', '',...
   [guidim.edit_vs_car_x+2*guidim.edit_vs_car_w+3*guidim.separator,...
    guidim.edit_vs_car_y-1*guidim.edit_vs_car_h-guidim.separator,...
    guidim.edit_vs_car_w, guidim.edit_vs_car_h]);
    
dimensionsCheckboxesVS = GSimpleText(f, 'Sound', '',...
   [guidim.checkbox_vs_x+2*guidim.separator,...
    guidim.checkbox_vs_y-1*guidim.checkbox_vs_h-guidim.separator,...
    guidim.checkbox_vs_w, guidim.checkbox_vs_h]);

% Modify fonts:
setFontSize(dimensionsTextsVSNumber, guidim.dimensionsFontSize);
setFontSize(dimensionsTextsVSName, guidim.dimensionsFontSize);
setFontSize(dimensionsEditsVSRadius, guidim.dimensionsFontSize);
setFontSize(dimensionsEditsVSAzimuth, guidim.dimensionsFontSize);
setFontSize(dimensionsEditsVSElevation, guidim.dimensionsFontSize);
setFontSize(dimensionsEditsVSX, guidim.dimensionsFontSize);
setFontSize(dimensionsEditsVSY, guidim.dimensionsFontSize);
setFontSize(dimensionsEditsVSZ, guidim.dimensionsFontSize);
setFontSize(dimensionsCheckboxesVS, guidim.dimensionsFontSize);

setFontWeight(dimensionsTextsVSNumber, 'bold');
setFontWeight(dimensionsTextsVSName, 'bold');
setFontWeight(dimensionsEditsVSRadius, 'bold');
setFontWeight(dimensionsEditsVSAzimuth, 'bold');
setFontWeight(dimensionsEditsVSElevation, 'bold');
setFontWeight(dimensionsEditsVSX, 'bold');
setFontWeight(dimensionsEditsVSY, 'bold');
setFontWeight(dimensionsEditsVSZ, 'bold');
setFontWeight(dimensionsCheckboxesVS, 'bold');

% === Virtual Sources Info ===============================================

vSSph = getVScoords(VS);

% Cartesian coordinates of the sources
VSCar = gSph2Car(vSSph);

% Source after source we place components 
% (from last to first to have them ordered in handles)
for ii = NVS:-1:1
    % Text indicating source number:
    textsVSNumber{ii} = GSimpleText(f, num2str(ii),...
        'textsVSNumber',...
       [guidim.text_vs_number_x,...
        guidim.text_vs_number_y-(ii+1)*guidim.text_vs_number_h-ii*guidim.separator,...
        guidim.text_vs_number_w, guidim.text_vs_number_h]);
    
    % Text indicating font name:
    textsVSName{ii} = GSimpleText(f, VS{ii}.name,...
        '',...
       [guidim.text_vs_name_x,...
        guidim.text_vs_name_y-(ii+1)*guidim.text_vs_name_h-ii*guidim.separator,...
        guidim.text_vs_name_w, guidim.text_vs_name_h]);
    
    % CheckBox indicating reproduction.
    checkboxesVS{ii} = GCheckbox(f,...
        'checkboxesVS',...
       [guidim.checkbox_vs_x+5*guidim.separator,...
        guidim.checkbox_vs_y-(ii+1)*guidim.checkbox_vs_h-ii*guidim.separator,...
        guidim.checkbox_vs_w, guidim.checkbox_vs_h]);
    
   
    % Edits to indicate source locations.
    % We explore 3 fields, either "radius, azimuth, elevation" or "x, y, z"
    % We load them in the last place, since they are dependent on the
    % reference object corresponding to the virtual source.
    % (from last to first, to get them ordered in handles):
    for jj = 3:-1:1
        
        editsVSSph{ii, jj} = GEdit(f, vSSph(jj, ii),...
            (['editsVSSph_', num2str(jj)]),...
           [guidim.edit_vs_sph_x+(jj-1)*guidim.edit_vs_sph_w+jj*guidim.separator,...
            guidim.edit_vs_sph_y-(ii+1)*guidim.edit_vs_sph_h-ii*guidim.separator,...
            guidim.edit_vs_sph_w, guidim.edit_vs_sph_h],...
            ii, jj, VS{ii}, conf.rmax);
     
        % Ony 2 digits what we include in GEdit:
        editsVSCar{ii, jj} = GEdit(f, roundn(VSCar(jj, ii), -2),...
        (['editsVSCar_', num2str(jj)]),...
       [guidim.edit_vs_car_x+(jj-1)*guidim.edit_vs_car_w+jj*guidim.separator,...
        guidim.edit_vs_car_y-(ii+1)*guidim.edit_vs_car_h-ii*guidim.separator,...
        guidim.edit_vs_car_w, guidim.edit_vs_car_h],...
        ii, jj+3, VS{ii}, conf.rmax); % Magnitude 4,5,6 --> x,y,z
    end
end

for ii = 1:NVS
    for jj = 1:3
        saveHandles(editsVSSph{ii,jj},f);
        saveHandles(editsVSCar{ii,jj},f);
    end
end

for ii = 1:NVS
    coordEdits(VS{ii}, editsVSSph{ii,1}, 'sph');
    coordEdits(VS{ii}, editsVSCar{ii,1}, 'car');
end

% === Popup Menus ========================================================
% To select audio device.
% Place it to left bottom

pmDevice = GPopupmenu(f, conf.devices,...
    1, 'pmDevice', guidim.pmDeviceBounds);

% Text:
textPmDeviceBounds = [guidim.pmDeviceBounds(1), guidim.pmDeviceBounds(2)+guidim.h_comp,...
    guidim.pmDeviceBounds(3), guidim.pmDeviceBounds(4)]; % Texto descriptivo
textPmDevice = GSimpleText(f, 'Driver', '', textPmDeviceBounds);
setFontSize(textPmDevice, guidim.dimensionsFontSize);
setFontWeight(textPmDevice, 'bold');

% Rendering method.
bounds_pmMethod = getBounds(pmDevice);
bounds_pmMethod(1) = bounds_pmMethod(1)+bounds_pmMethod(3)+guidim.margin;

valuesel = find(strcmp(conf.methods,setup.Renderer));
pmMethod = GPopupmenu(f, conf.methods,valuesel, 'pmMethod', bounds_pmMethod);

popupdata.method = method;
popupdata.SamplesPerFrame = conf.SamplesPerFrame; 
popupdata.NLS = setup.NLS;
handles = guihandles(f);
set(handles.pmMethod, 'Callback', @(hObject,eventdata) methodpopupcallback(hObject, eventdata, popupdata, VS));


% Text:
textPmMethod = [bounds_pmMethod(1), bounds_pmMethod(2)+guidim.h_comp,...
    bounds_pmMethod(3), bounds_pmMethod(4)];
textPmMethod = GSimpleText(f, 'Render', '', textPmMethod);
setFontSize(textPmMethod, guidim.dimensionsFontSize);
setFontWeight(textPmMethod, 'bold');

% Active Loudspeakers
bounds_CheckActive = getBounds(pmMethod);
bounds_CheckActive(1) = bounds_CheckActive(1)+bounds_CheckActive(3)+3*guidim.margin;
checkActive = uicontrol(f,'Style', 'checkbox','Tag','checkBoxActive','Position',bounds_CheckActive);
if strcmp(conf.plot.activels,'on')
    set(checkActive,'Value',1);
end

% Text:
textCheckActive = [bounds_CheckActive(1)-2*guidim.margin,bounds_CheckActive(2)+guidim.h_comp,...
    bounds_CheckActive(3), bounds_CheckActive(4)];
textCheckActive = GSimpleText(f, 'Active Speakers', '', textCheckActive);
setFontSize(textCheckActive, guidim.dimensionsFontSize);
setFontWeight(textCheckActive, 'bold');


