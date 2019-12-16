%-------------------------------------------------------------------------%
%
% File:     DistanceMatrix(dsites,ctrs)
%
% Goal:     Compute the distance matrix between data sites and centers
%
% Inputs:   dsites: Mxs matrix representing a set of M data sites in R^s
%                   (i.e., each row contains one s-dimensional point)
%           ctrs:   Nxs matrix representing a set of N centers in R^s
%                   (one center per row)
%
% Outputs:  DM:     MxN matrix whose i,j position contains the Euclidean
%                   distance between the i-th data site and j-th center
%
%-------------------------------------------------------------------------%

function DM = DistanceMatrix(dsites,ctrs)

[M,s] = size(dsites); [N,s] = size(ctrs);
DM = zeros(M,N);

% Accumulate sum of squares of coordinate differences
% The ndgrid command produces two MxN matrices:
%   dr, consisting of N identical columns (each containing
%       the d-th coordinate of the M data sites)
%   cc, consisting of M identical rows (each containing
%       the d-th coordinate of the N centers)

for d=1:s
 [dr,cc] = ndgrid(dsites(:,d),ctrs(:,d));
 DM = DM + (dr-cc).^2;
end
DM = sqrt(DM);
