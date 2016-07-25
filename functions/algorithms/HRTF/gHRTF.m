function [H, I] = gHRTF_new(sph, HRTFdata)
%GHRTF - Head-Related Impulse Response Rendering
%
% Usage:
% [H, I] = hHRTF(sph)
%
% Input paramters:
%   sph - Spherical coordinates of the source
%
% Output paramters:
%   H - Rendering filters for each channel (left and right)
%   I - Selected channels (always 1 and 2)
%
% See also: HRTFstart

r = sph(1);     %radius
theta = sph(2); %azimuth
phi = sph(3);   %elevation

% Choose closest available position from dataset
% Checks if it is needed to rotate L-R
[bestPos, rotate] = gChooseBestHRIRPos(theta, phi, HRTFdata.dirc);

H = zeros(HRTFdata.L,2);

if rotate
    H(:,1) = HRTFdata.IR{bestPos}(:,1);
    H(:,2) = HRTFdata.IR{bestPos}(:,2);
else
    H(:,1) = HRTFdata.IR{bestPos}(:,2);
    H(:,2) = HRTFdata.IR{bestPos}(:,1);
end

% Normalize distance
rmin = HRTFdata.rmin;
r = max([r, rmin]);

% Attenuation factor:
att = rmin/r;

H = att*H;

I = [1; 2]; % Always L and R channels

end