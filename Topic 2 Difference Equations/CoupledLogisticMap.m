function [xt1 xt2] = CoupledLogisticMap(X_in, R, a, iterations, animation_speed)

%**************************************************************************
% function [xt1 xt2] = CoupledLogisticMap(X_in, R, a, iterations, animation_speed)
%  
% Input:
%            X_in   : 2 element array initial conditions (between 0 and 1) for x1 and x2
%               R   : 2 element array logistic parameter (number between .1 and 4) for for x1 and x2
%               a   : aplha or coupling strength (0 to .5 works best);
%      iterations   : number of iterations (e.g., 50)
% animation_speed   : speed of plot animation. 0 = no animation. 
% 
% 
% % Examples Syntax:  
%
%   For synchonized 'more similar' indviduals (i.e., needs lower alpha):
%           [xt1 xt2] = CoupledLogisticMap([.6 .5], [3.65 3.68], .22, 100, .1);
%
%   For synchonized 'more different' indviduals (i.e., needs larger alpha):
%           [xt1 xt2] = CoupledLogisticMap([.6 .5], [3.65 3.78], .31, 100, .1);       
%           
%
% Code By:  Michael J. Richardson, 2009
%           Department of Psychology
%           University of Cincinnati
%           michael.richardson@uc.edu
%
%   Model by Vallacher & Nowak, et al., (1998; 2002; 2005)
%   for Synchonized Social Interaction
%   Model described in Vallacher, R. R., Nowak, A., & Zochowski, M. (2005). Dynamics of social coordination: The synchronization of internal states in close relationships. Interaction Studies, 6(1), 35-52.
%**************************************************************************
%**************************************************************************

close all; % Close any open figures (graphs)

% Initialize array of possible x values for function (x = 0 to 1);
x = 0:.001:1;
x = transpose(x);

% Initialize data array for initial value numerical solution (xt)
xt1 = zeros(iterations, 1);
xt2 = zeros(iterations, 1);
xt1(1) = X_in(1);
xt1(1) = X_in(1);

% Calculate numeric solution specific R value and initial condition (X_in)
for i=2:iterations
    xt1(i) = (R(1)*xt1(i-1)*(1-xt1(i-1)) + a*R(2)*xt2(i-1)*(1-xt2(i-1)))/(1+a);
    xt2(i) = (R(2)*xt2(i-1)*(1-xt2(i-1)) + a*R(1)*xt1(i-1)*(1-xt1(i-1)))/(1+a);
end

% Do plots
figure;
for i=1:length(xt1)
    %Plot xt1 and xt2 over iterations (time)
    subplot(1,2,1);
    hold on;
    plot(xt1(1:i), '-or');
    plot(xt2(1:i), '-ob');
    hold off;
    xlabel('t');
    ylabel('x');

    %Plot xt1 vs xt2
    subplot(1,2,2);
    plot(xt1(1:i), xt2(1:i), '-ok');
    xlabel('X1');
    ylabel('X2');

    pause(animation_speed);
end

return;