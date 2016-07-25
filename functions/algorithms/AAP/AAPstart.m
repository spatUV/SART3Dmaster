function [AAPdata, enabled] = AAPstart(LSsph)

%=====================
% AAP Initialization
%=====================

% Note: Please, be sure to use a circular reproduction setup.
% h = msgbox('Be sure that you are using a circular loudspeaker array.' ...
%             ,'WFS Rendering','custom',imread('spaticon.png'));

AAPdata.rNLS = [];

% Number of coefficients (just a gain)
AAPdata.L = 1; 


% Check that setup corresponds to a circular array
if range(LSsph(1,:))~=0 || range(LSsph(3,:))~=0 || range(diff(sort(wrapTo360(LSsph(2,:)))))
    warning('AAP: The loudspeaker configuration does not match a circular array')
    enabled = 0;
    return;
end

% Initialize order (default taken from the number of loudspeakers)
NLS = size(LSsph,2);
if rem(NLS,2)==1
    AAPdata.Order = (NLS-1)/2;
else
    AAPdata.Order = NLS/2;
end

AAPdata.LSsph = LSsph;

enabled = 1;



