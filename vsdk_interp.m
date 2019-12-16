%-------------------------------------------------------------------------%
%
% File:     vsdk_interp(epoints,dsites,f,rbf,scale)
%
% Goal:     Interpolate the function via VSDK and present the results
%
% Inputs:   epoints:  array of evaluation points
%           dsites:   array of data points used as RBF centers
%           f:        function to be interpolated
%           rbf:      RBF considered in the interpolation
%           scale:    discontinuous scale function
%
% Outputs:  fvsdk:    the interpolant computed at the evaluation points
%           sv:  the singular values of the interpolation matrix
%
% Calls on: DistanceMatrix
%
%
%
% Authors:  S. De Marchi, F. Marchetti, E. Perracchione,
%           Universita' di Padova,
%           Dipartimento di Matematica "Tullio Levi-Civita".
%
% Last modified: 05/07/2018
%
%-------------------------------------------------------------------------%

function [fvsdk,sv] = vsdk_interp(epoints,dsites,f,rbf,scale)

% Test function evaluated at data sites and evaluation points
rhs = f(dsites(:,1),dsites(:,2));   
test = feval(f,epoints(:,1),epoints(:,2)); 

% Scale function evaluated at data sites and evaluation points
scale_dsites = feval(scale,dsites(:,1),dsites(:,2));
scale_epoints = feval(scale,epoints(:,1),epoints(:,2));

% New epoints and dsites with added coordinate for VSDK interpolation
dsites_vsdk = [dsites scale_dsites];
epoints_vsdk = [epoints scale_epoints];

% VSDK interpolation (analoguous to classic RBF interpolation)
DM_data = DistanceMatrix(dsites_vsdk,dsites_vsdk);
IM = rbf(1,DM_data);    % The interpolation matrix
DM_eval = DistanceMatrix(epoints_vsdk,dsites_vsdk);
EM = rbf(1,DM_eval);    % The evaluation matrix
coeffs = IM\(rhs);
fvsdk = EM*coeffs;  % VSDK interpolant at epoints

% Computation of the power function at evaluation points
invIM = pinv(IM); 
phi0 = rbf(1,0);
M = size(epoints,2);
powfun= zeros(M,1);
for j=1:M
     powfun(j) = real(sqrt(phi0-(invIM*EM(j,:)')'*EM(j,:)'));
end

% Interpolation results
disp('-------------   VSDK interpolation   -----------------')
fprintf('MAE: %.2e\n',norm(fvsdk-test,inf))
fprintf('RMSE: %.2e\n',sqrt(mean((fvsdk-test).^2)))
fprintf('MPF: %.2e\n',max(powfun))
fprintf('SSIM = %.12f\n',ssim(fvsdk,test))

% Computation of the singular values of the interpolation matrix
sv = svd(IM);




