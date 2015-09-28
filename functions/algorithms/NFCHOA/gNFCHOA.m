function [H, I] = gNFCHOA(sph)
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

global conf

% Warning:
% There is a 90º offset that might come from SFS Toolbo
sph(2) = wrapTo180(sph(2)-90);

% Postion of virtual source
xs = gSph2Car(sph).';

% All loudspeakers contribute to the rendering
I = 1:conf.nLS;

% Get driving signals
H = driving_function_imp_nfchoa(conf.sfs.x0,xs,conf.sfs.src,conf.sfs);


if max(abs(H(:)))>1
    H = H./max(abs(H(:)));
end








