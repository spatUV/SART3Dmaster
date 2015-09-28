%=========================================
% StSL (Stereo Sine Law) Initialization
%=========================================

if conf.nLS > 2
    error('There should be only 2 loudspeakers for stereo reproduction.');
end  

conf.nCoeffs = 1;
conf.StSL.Base = abs(conf.LS.sph(2,1)); % Loudspeaker Base Angle
