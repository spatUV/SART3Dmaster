function [H, I] = gWFS_new(sph, WFSdata)
%GWFS Wave-Fiels Synthesis Rendering using SFS Toolbox.
%
% Usage:
%   [H, I] = gWFS(sph)
%
% Input parameters:
%   sph - Spherical coordinates of virtual source
%
% Output paratmers:
%   H - WFS Rendering filters
%   I - Selected loudspeakers corresponding to the rendering
%
% See also: WFSstart, driving_function_imp_wfs

sph = sph(:);

% Postion of virtual source
xs = gSph2Car(sph).';

if sph(1)< WFSdata.rmin
    WFSdata.src = 'fs';
    xs(4:6) = -xs./norm(xs);
else
    WFSdata.src = 'ps';
end

% Secondary source selection
[x0,I] = secondary_source_selection(WFSdata.x0,xs,WFSdata.src);
I = find(I==1);

% Secondary source tapering
x0 = secondary_source_tapering(x0,WFSdata);


% % Get driving signals
H = driving_function_imp_wfs(x0,xs,WFSdata.src,WFSdata);




