function [H,I] = gCLOSEST(sph, CLOSESTdata)

sph = sph(:);
car = gSph2Car(sph);    %spherical to Cartesian coordinates

% Calculate distance to each loudspeaker
dist = sqrt((CLOSESTdata.LScar(1,:)-car(1)).^2 + (CLOSESTdata.LScar(2,:)-car(2)).^2 + (CLOSESTdata.LScar(3,:)-car(3)).^2);

% Find minimum 
[d,I] = min(dist);

% Apply distance attenuation factor
r = max(d, CLOSESTdata.rmin);
H = CLOSESTdata.rmin/r;
