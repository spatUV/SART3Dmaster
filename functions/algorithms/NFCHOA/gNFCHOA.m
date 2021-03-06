function [H, I] = gNFCHOA_new(sph, NFCHOAdata)
%GNFCHOA Near-Field Compensated Higher Order Ambisonics Rendering using SFS Toolbox.
%
% Usage:
%   [H, I] = gNFCHOA(sph)
%
% Input parameters:
%   sph - Spherical coordinates of virtual source
%
% Output paratmers:
%   H - NFCHOA Rendering filters
%   I - Selected loudspeakers corresponding to the rendering (all)
%
% See also: NFCHOAstart, driving_function_imp_nfchoa

sph = sph(:);

% Warning:
% There is a 90� offset that might come from SFS Toolbo
sph(2) = wrapTo180(sph(2)-90);

% Postion of virtual source
xs = gSph2Car(sph).';

NLS = size(NFCHOAdata.x0,1);

% All loudspeakers contribute to the rendering
I = (1:NLS).';

% Get driving signals
H = driving_function_imp_nfchoa(NFCHOAdata.x0,xs,NFCHOAdata.src,NFCHOAdata);

if max(abs(H(:)))>1
    H = H./max(abs(H(:)));
end








