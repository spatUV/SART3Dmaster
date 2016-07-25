function [CLOSESTdata, enabled] = CLOSESTstart(LSsph)

%=========================================
% CLOSEST Initialization
%=========================================

CLOSESTdata.rNLS = [];	% There is not a required number of loudspeakers

CLOSESTdata.L = 1;

enabled = 1;

% We save loudspeaker locations as accesible data to the method.
CLOSESTdata.LScar = gSph2Car(LSsph);

% The minimum loudspeaker distance will be used to normalize the gain of the 
% rendering coefficients (to avoid saturation when the sources are very close 
% to the listener)
CLOSESTdata.rmin = min(LSsph(1,:));