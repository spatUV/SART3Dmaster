function car = gSph2Car(sph)
%%GSPH2CAR Converts spherical coordinates to Cartesian coordinates.
%   Uses the particular coordinate system used in this toolbox.
%
% Usage:
%   car = gSph2Car(sph)
%
% Input parameters:
%   sph - Spherical coordinate vector. Dimensions: [Radius [m]; Azimuth [º]; Elevation [º]].
%   Example: [1; 45; 90].
%
% Output parameters:
%   car - Cartesian coordinate vector. Dimensions: [x [m]; y [m]; z [m]].
%   Example: [0.7071, 0.7071, 0].
%
% See also: gCar2Sph.


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

r = sph(1, :);
theta = sph(2,:);
phi = sph(3, :);

car(1, :) = -r.*cosd(phi).*sind(theta); % x
car(2, :) = r.*cosd(phi).*cosd(theta);  % y
car(3, :) = r.*sind(phi);               % z
