function sph = gCar2Sph(car)
%%GCAR2SPH Converts Cartesian coordinates to spherical coordinates.
%   Uses the particular coordinate system used in this toolbox.
%
% Usage:
%   sph = gCar2Sph(car)
%
% Input parameters:
%   car - Cartesian coordinate vector. Dimensions: [x [m]; y [m]; z [m]].
%   Example: [0.7071, 0.7071, 0].
%
% Output parameters:
%   sph - Spherical coordinate vector. Dimensions: [Radius [m]; Azimuth [º]; Elevation [º]].
%   Example: [1; 45; 90].
%
% See also: gSph2Car.

x = car(1);
y = car(2);
z = car(3);

r = sqrt(x^2 + y^2 + z^2);
azimuth = atan2d(-x,y);
elevation = asind(z/r);
sph = [r; azimuth; elevation];