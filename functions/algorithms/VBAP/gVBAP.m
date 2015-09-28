function [gs, I] = gVBAP(pc, rs)
%GVBAP computes VBAP gains for a source location
%
% Usage:
%   [gs, I] = gVBAP(pc, rs)
%
% Input paramteres:
%   gs - loudspeaker gains
%   I - selected loudspeakers
%
% Output paramters:
%   pc - desired virtual source location in Cartesian coordinates
%   rs - minimum source distance in the set-up
%
% See also: gVBAPini, VBAPstart

global conf

Ntriang = size(conf.VBAP.Triplets,1);
TriDim = size(conf.VBAP.Triplets,2);

GS = zeros(TriDim,Ntriang);

for n=1:Ntriang
    GS(:,n) = conf.VBAP.iLc(:,:,n)*pc;
end

% candidate_tri = find(sum(GS>=0)==3);
% min_gains = min(GS(:,candidate_tri));

candidate_tri = find(sum(GS>=0)==TriDim);
min_gains = min(GS(:,candidate_tri));
[~, select] = max(min_gains);

if isempty(select)
    gs = zeros(TriDim,1);
    %I  = 1:TriDim;
    I = [];
    warning('Non-reachable source location');
else
gs = GS(:,candidate_tri(select));
I  = conf.VBAP.Triplets(candidate_tri(select),:).';

% Normalized gains
gs = gs./sqrt(sum(gs.^2));

% Attenuation factor (normalized with respect to closest loudspeaker):
r = max(rs, conf.rMin);
att = conf.rMin/r;

% Apply distance correction
gs = gs*att;
end

end


