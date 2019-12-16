%-------------------------------------------------------------------------%
%
% Usage:    run Demo.m
%           uncomment 'PLOT' section for images and singular values plot
%
% Goal:     script that gives an example for the computation of the 
%           VSDK interpolant
%
% Calls on: piecewise.m (function useful for piecewise definition of f
%           vsdk_interp.m (function which performs the VSDK interpolation
%
% Authors:  S. De Marchi, F. Marchetti, E. Perracchione,
%           Universita' di Padova,
%           Dipartimento di Matematica "Tullio Levi-Civita".
%
% Last modified: 05/07/2018
%
%-------------------------------------------------------------------------%

clear all
close all
clc
warning off
addpath('Functions') % Folder with needed functions

s = 0.01;   % Step of the mesh
[X,Y] = meshgrid(-1:s:1);   % Meshgrid in [-1,1]^2
epoints =[X(:),Y(:)];   % Evaluation points

H = haltonseq(1089,2);  % Halton points
dsites = (H.*2-1);  % Data sites: Halton points mapped in [-1,1]^2

f = piecewise(@(x,y) x.^2+y.^2<=0.6,@(x,y) exp(-(x.^2+y.^2)),@(x,y)...
              x.^2+y.^2>0.6,@(x,y) x+y);    % Discontinuous test function

rbf = @(e,r) exp(-(e*r).^2);    % Gaussian RBF

scale = piecewise(@(x,y) x.^2+y.^2<=0.6,@(x,y) 1,@(x,y) x.^2+y.^2>0.6,...
                  @(x,y) 2);    % Discontinuous scale function

[fvsdk,sv] = vsdk_interp(epoints,dsites,f,rbf,scale);  % VSDK interpolation


%% PLOT 

% test = feval(f,epoints(:,1),epoints(:,2));  % Test function at epoints
% 
% figure(1)
% imshow(reshape(test,sqrt(size(epoints,1)),sqrt(size(epoints,1))));
% title('Test function')
% 
% figure(2)
% imshow(reshape(fvsdk,sqrt(size(epoints,1)),sqrt(size(epoints,1))));
% title('VSDK reconstruction')
% 
% figure(3)
% semilogy(1:size(sv),sv,'b-','LineWidth',2)
% title('Singular values')





