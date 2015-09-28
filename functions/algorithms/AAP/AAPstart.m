%=====================
% AAP Initialization
%=====================

% Note: Please, be sure to use a circular reproduction setup.
h = msgbox('Be sure that you are using a circular loudspeaker array.' ...
            ,'WFS Rendering','custom',imread('spaticon.png'));

% Number of coefficients (just a gain)
conf.nCoeffs = 1; 

% Initialize order (default taken from the number of loudspeakers)
if rem(conf.nLS,2)==1
    conf.AAP.Order = (conf.nLS-1)/2;
else
    conf.AAP.Order = conf.nLS/2;
end
