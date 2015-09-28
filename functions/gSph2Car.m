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

r = sph(1, :);
theta = sph(2,:);
phi = sph(3, :);

car(1, :) = -r.*cosd(phi).*sind(theta); % x
car(2, :) = r.*cosd(phi).*cosd(theta);  % y
car(3, :) = r.*sind(phi);               % z
