%=====================
% VBAP Initialization
%=====================

% Number of coefficients (just a gain)
conf.nCoeffs = 1;   

% Initialization routine
[conf.VBAP.Triplets, conf.VBAP.iLc] = gVBAPini(conf.LS.sph);
