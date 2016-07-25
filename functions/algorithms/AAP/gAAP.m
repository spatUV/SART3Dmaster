function [d, I] = gAAP_new(alphas, AAPdata)
%GAAP Ambisonics Amplitude Panning Rendering
%
% Usage:
% [d, I] = gAAP(alphas)
%
% Input parameters:
%   alphas - azimuth angles of the source
%
% Output parameters:
%   d - gains for the selected loudspeakers
%   I - indices of the selected loudspeakers
%
% See also: AAPstart


NLS = size(AAPdata.LSsph,2);

M = AAPdata.Order;           % Order

I = (1:NLS).';               % Contributing loudspeakers (all)
alpha0 = AAPdata.LSsph(2,:); % Loudspeaker azimuth angles

d = sind(0.5*(2*M +1)*(alpha0-alphas))./((2*M + 1)*sind(0.5*(alpha0-alphas)));

end


