function [d, I] = gAAP(alphas)
%GAAP Ambisonics Amplitude Panning Rendering
%
% Usage:
% [d, I] = gAAP(alphas)
%
% Input parameters:
%   alphas - azimuth angles of the loudspeakers
%
% Output parameters:
%   d - gains for the selected loudspeakers
%   I - indices of the selected loudspeakers
%
% See also: AAPstart

global conf

M = conf.AAP.Order;             % Order

I = 1:conf.nLS;                 % Contributing loudspeakers (all)
alpha0 = conf.LS.sph(2,:);      % Loudspeaker azimuth angles

d = sind(0.5*(2*M +1)*(alpha0-alphas))./((2*M + 1)*sind(0.5*(alpha0-alphas)));

end


