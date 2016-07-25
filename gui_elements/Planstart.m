function [fplan] = Planstart(conf,setup,guidim)
%%PLANSTART starts plan view GUI
%
% Input paramteres:
%   conf    -   SART3D configuration structure.
%   setup   -   SART3D setup structure.
%   guidim  -   SART3D GUI dimensions structure as obtained by *gSizes*.
%
% Output parameter:
%   fplan   -   Handle to plan view figure.
%
% See also: gSizes, SART3D, Profilestart, GUIstart.

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
% PLAN VIEW AXES
%=====================================================================

% Plan View Figure and Axes 
bounds_plan_f = guidim.bounds_fig_plan;
bounds_plan_ax = guidim.bounds_axes_plan;

fplan = figure('Visible','on','Position',bounds_plan_f, ...
    'Name','Plan View', 'NumberTitle', 'off', 'MenuBar','none');
ha = axes('Units', 'Pixels', 'Position',bounds_plan_ax);

% Draw dot line around closest loudspeaker
rmin = min(setup.LSsph(1,:));  
angle = 0:0.1:2*pi;
xp = rmin*cos(angle);
yp = rmin*sin(angle);
plot(xp, yp, 'b.', 'MarkerSize', 5, 'HitTest', 'off');

% Set axis grid and labels.
set(ha,'XGrid','on', 'YGrid', 'on', 'ZGrid','on');
set(get(ha, 'XLabel'), 'String', 'x', 'FontWeight', 'bold');
set(get(ha, 'YLabel'), 'String', 'y', 'FontWeight', 'bold');
set(get(ha, 'ZLabel'), 'String', 'z', 'FontWeight', 'bold');

% Change background color and set tag to manage with guihandles
color = [1 1 1]; % white
set(ha, 'color', color, 'tag', (['axes_plan']));

% Draw listener in the center
GImage(fplan,'', bounds_plan_ax, (['guy_plan.png']));

% Manual limits:set(ha, 'XLimMode', 'manual');
set(ha, 'YLimMode', 'manual');
set(ha, 'ZLimMode', 'manual');

% Limits set from max loudspeaker distance
set(ha, 'XLim', [-conf.rmax, conf.rmax]);
set(ha, 'YLim', [-conf.rmax, conf.rmax]);
set(ha, 'ZLim', [-conf.rmax, conf.rmax]);

% We take the loudspeaker angles:
angles_az = cellfun(@(x)x(2), setup.LScoord); % Azimuth
angles_el = cellfun(@(x)x(3), setup.LScoord); % Elevación


% Scale from figure dimensions to meters (important for mapping pixels to
% actual distance)
xy_scale = bounds_plan_ax(3)/(2*conf.rmax);

% We initialize cell array with total number of loudspeakers
gImagesLS = {setup.NLS};

% Draw loudspeakers.
% We go from last to first to have them all ordered in guihandles

for ii = setup.NLS:-1:1
    horizontal = xy_scale*setup.LScar(1,ii);
    vertical   = xy_scale*setup.LScar(2,ii);

    gImagesLS{ii} = GImage(gcf, (['ls_plan_' num2str(ii)]), bounds_plan_ax, 'ls.png');
    boundsLS = getBounds(gImagesLS{ii});
    
    setBounds(gImagesLS{ii},[bounds_plan_ax(1)-boundsLS(3)/2+horizontal+bounds_plan_ax(3)/2,bounds_plan_ax(2)-boundsLS(4)/2+vertical+bounds_plan_ax(4)/2,boundsLS(3),boundsLS(4)]);
        
    % Set loudspeaker number:
    setString(gImagesLS{ii}, ii);
    setForegroundColor(gImagesLS{ii}, 'w');
    setFontSize(gImagesLS{ii}, 5);
    
    % Delete tag to speed up
    setTag(gImagesLS{ii}, '');   
end



