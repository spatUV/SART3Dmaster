function [Triplets, iLc] = gVBAPini(LSsph)
%%GVBAPINI initializes VBAP for fast triplet selection with search grid
%
% Usage:
%   [Triplets, iLc] = gVBAPini(LSsph)
%
% Input parameters:
%   LSsph - Loudspeaker coordinate matrix in spherical coordinates
%
% Output parameters:
%   Triplets - Matrix of loudspeaker triplet extracted from current setup
%   iLc - pre-computed inverted matrix for solving the system equation that
%   calculates the loudspeaker gains.
%
% See also: VBAPstart, gVBAP

% Get groups of triangles from loudspeaker set-up
N = size(LSsph,2);

%-------------------------------------------------------
% If loudspeakers are all at the same elevation, we must
% force an additional auxiliar loudspeaker before
% triangulation
%-------------------------------------------------------
if range(LSsph(3,:))==0
    N = N+1;
    LSsph = [LSsph, [0;0;90]];
    collinear = 1;
else
    collinear = 0;
end

% Wrap loudspeakers angles to -180/180 range
Ep = wrapTo180(LSsph(3,:));               % elevation 
Ap = wrapTo180(LSsph(2,:));               % azimuth

% Create augmented vertices matrix for triangulation
% This is to deal with azimuth angle wrapping
A_aug = [(Ap-360), Ap, (Ap+360)];
E_aug = [Ep, Ep, Ep];
tri = delaunay(E_aug,A_aug);
%figure, triplot(tri,E_aug,A_aug)

% Find triangles with vertices within -180 and 180
% i.e. vertices from N+1 to 2*N
mask = (tri>2*N | tri<=N);
mask = sum(mask,2);
triaux = tri((mask~=3),:); % Get only triangles in useful range
%figure,triplot(triaux,E_aug,A_aug),axis([-90 90 -180 180]);

% Get correspondence to original vertices
finaltri = mod(triaux,N);
finaltri(finaltri==0)=N;
% Some triplets are the same
finaltri = sort(finaltri,2);

Triplets = unique(finaltri,'rows');

%-------------------------------------------------------
% Remove auxiliary loudspeaker in case of collinearity
%-------------------------------------------------------
if collinear == 1
    Triplets = Triplets(:,1:2);
    rows_to_remove = any(Triplets==N, 2);
    Triplets(rows_to_remove,:) = [];
    LSsph = LSsph(:,1:N-1);
end

% For each triangle, get inverted loudspeaker vector matrix:
Ntriang = size(Triplets,1);
dimTri  = size(Triplets,2);
iLc = zeros(dimTri,3,Ntriang);
LScar = gSph2Car(LSsph);
for n=1:Ntriang
    if collinear == 1
        iLc(:,:,n) = pinv(LScar(:,Triplets(n,:).'));
    else
        iLc(:,:,n) = inv(LScar(:,Triplets(n,:).'));
    end
end

end