function [H, I] = gWFS(sph)
%GWFS Wave-Fiels Synthesis Rendering using SFS Toolbox.
%
% Usage:
%   [H, I] = gWFS(sph)
%
% Input parameters:
%   sph - Spherical coordinates of virtual source
%
% Output paratmers:
%   H - WFS Rendering filters
%   I - Selected loudspeakers corresponding to the rendering
%
% See also: WFSstart, driving_function_imp_wfs

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

global conf

% Postion of virtual source
xs = gSph2Car(sph).';

if sph(1)< conf.rMin
    conf.sfs.src = 'fs';
    xs(4:6) = -xs./norm(xs);
else
    conf.sfs.src = 'ps';
end

% Secondary source selection
[x0,I] = secondary_source_selection(conf.sfs.x0,xs,conf.sfs.src);
I = find(I==1);

% Secondary source tapering
x0 = secondary_source_tapering(x0,conf.sfs);


% % Get driving signals
H = driving_function_imp_wfs(x0,xs,conf.sfs.src,conf.sfs);




