function [H, I] = gWFS(sph)
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

global conf

% Postion of virtual source
xs = gSph2Car(sph).';

if sph(1)< conf.rMin
    conf.sfs.src = 'fs';
    xs(4:6) = -xs./norm(xs);
else
    conf.sfs.src = 'ps';
end

% Secondary source selection
[x0,I] = secondary_source_selection(conf.sfs.x0,xs,conf.sfs.src);
I = find(I==1);

% Secondary source tapering
x0 = secondary_source_tapering(x0,conf.sfs);


% % Get driving signals
H = driving_function_imp_wfs(x0,xs,conf.sfs.src,conf.sfs);




