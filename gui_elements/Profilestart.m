function [fprofile] = Profilestart(conf,setup,guidim)
%%PROFILESTART starts profile view GUI
%
% Input paramteres:
%   conf     -   SART3D configuration structure.
%   setup    -   SART3D setup structure.
%   guidim   -   SART3D GUI dimensions structure as obtained by *gSizes*.
%
% Output parameter:
%   fprofile -   Handle to profile view figure.
%
% See also: gSizes, SART3D, Planstart, GUIstart.

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


%=====================================================================
% PROFILE VIEW AXES
%=====================================================================

bounds_profile_f = guidim.bounds_fig_profile;
bounds_profile_ax = guidim.bounds_axes_profile;

fprofile = figure('Visible','on','Position',bounds_profile_f,...
    'Name','Profile View', 'NumberTitle', 'off', 'MenuBar','none');
ha = axes('Units', 'Pixels', 'Position',bounds_profile_ax);

% Draw dot line around closest loudspeaker
angle = 0:0.1:2*pi;
rmin = min(setup.LSsph(1,:));
xp = rmin*cos(angle);
yp = rmin*sin(angle);
plot(xp, yp, 'b.', 'MarkerSize', 5, 'HitTest', 'off');

% Rotate axes accordingly (y, z):
set(ha, 'View', [90 0]);

set(ha,'XGrid','on', 'YGrid', 'on', 'ZGrid','on');
% Set axis labels.
set(get(ha, 'XLabel'), 'String', 'x', 'FontWeight', 'bold');
set(get(ha, 'YLabel'), 'String', 'y', 'FontWeight', 'bold');
set(get(ha, 'ZLabel'), 'String', 'z', 'FontWeight', 'bold');

% Manual limits:set(ha, 'XLimMode', 'manual');
set(ha, 'YLimMode', 'manual');
set(ha, 'ZLimMode', 'manual');

% Limits set from max loudspeaker distance
set(ha, 'XLim', [-conf.rmax, conf.rmax]);
set(ha, 'YLim', [-conf.rmax, conf.rmax]);
set(ha, 'ZLim', [-conf.rmax, conf.rmax]);

% Set grid and labels
set(ha,'XGrid','on', 'YGrid', 'on', 'ZGrid','on');
set(get(ha, 'XLabel'), 'String', 'x', 'FontWeight', 'bold');
set(get(ha, 'YLabel'), 'String', 'y', 'FontWeight', 'bold');
set(get(ha, 'ZLabel'), 'String', 'z', 'FontWeight', 'bold');


% Change background color and set tag to manage with guihandles
color = [1 1 1]; % white
set(ha, 'color', color, 'tag', (['axes_profile']));

% Draw listener in the center
GImage(fprofile,'', bounds_profile_ax, (['guy_profile.png']));


% Manual limits:set(ha, 'XLimMode', 'manual');
set(ha, 'YLimMode', 'manual');
set(ha, 'ZLimMode', 'manual');

% Limits set from max loudspeaker distance
set(ha, 'XLim', [-conf.rmax, conf.rmax]);
set(ha, 'YLim', [-conf.rmax, conf.rmax]);
set(ha, 'ZLim', [-conf.rmax, conf.rmax]);

zy_scale = bounds_profile_ax(3)/(2*conf.rmax);

% Draw loudspeakers.
% We go from last to first to have them all ordered in guihandles
for ii = setup.NLS:-1:1
    horizontal = zy_scale*setup.LScar(2,ii);
    vertical   = zy_scale*setup.LScar(3,ii);

    gImagesLS{ii} = GImage(gcf, (['ls_profile_' num2str(ii)]), bounds_profile_ax, 'ls.png');
    boundsLS = getBounds(gImagesLS{ii});
    
    setBounds(gImagesLS{ii},[bounds_profile_ax(1)-boundsLS(3)/2+horizontal+bounds_profile_ax(3)/2,bounds_profile_ax(2)-boundsLS(4)/2+vertical+bounds_profile_ax(4)/2,boundsLS(3),boundsLS(4)]);
        
    % Set loudspeaker number:
    setString(gImagesLS{ii}, ii);
    setForegroundColor(gImagesLS{ii}, 'w');
    setFontSize(gImagesLS{ii}, 5);
    
    % Delete tag to speed up
    setTag(gImagesLS{ii}, '');
   
end

