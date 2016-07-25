function [VBAPdata, enabled] = VBAPstart(LSsph)


%=====================
% VBAP Initialization
%=====================

VBAPdata.rNLS = [];

% Number of coefficients (just a gain)
VBAPdata.L = 1;   

% Initialization routine
[VBAPdata.Triplets, VBAPdata.iLc] = gVBAPini(LSsph);

% Minimum loudspeaker distance
VBAPdata.rmin = min(LSsph(1,:));

enabled = 1;
