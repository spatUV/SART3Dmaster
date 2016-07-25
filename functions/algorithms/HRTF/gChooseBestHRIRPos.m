function [bestPos, rotate] = gChooseBestHRIRPos(theta, phi, posmatrix)
%GCHOOSEBESTHRIRPOS chooses the closest impulse responses to the input
%direction
%
% Usage:
%   [bestPos, rotate] = gChooseBestHRIRPos(theta,phi,posmatrix)
%
% Input paramters:
%   theta - Azimuth angle ([º])
%   phi - Elevation angle ([º])
%   posmatrix - Matrix of direction vectors of available responses.
%
% Output parameters:
%   bestPos - Index of best matching position
%   rotate - '1' if direction requires interchanging left and right
%   responses
%
% See also: gHRTF, HRTFstart

posSph = [1; theta; phi];

% Binaural symmetry.
% Rotate if azimuth is greater than 180
% if (posSph(2) > 180)
%     posSph(2) = 360-posSph(2);
%     rotate = 1;
% else
%     rotate = 0;
% end

if (posSph(2) <0)
    posSph(2) = abs(posSph(2));
    rotate = 1;
else
    rotate = 0;
end

posCar = gSph2Car(posSph); % Cartesian

% Closest position:
cx = lsqnonneg(posmatrix, posCar);
bestPos = find(cx == max(cx));
end