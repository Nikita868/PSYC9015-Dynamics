function [x y] = HenonMap(xin, yin, A, B, iterations, animation_speed)

%**************************************************************************
% function [x y] = HenonMap(X_in, A, B, iterations, animation_speed)
%  
% Input:
%            x_in   : initial condition
%            y_in   : initial condition
%               A   : parameter (e.g., 1.4)
%               B   : parameter (e.g., 0.3);
%      iterations   : number of iterations
% animation_speed   : speed of plot animation. 0 = no animation. 
% 
% 
% % Syntax:  
%           [x y] = HenonMap(.5, .5, 1.4, 0.3, 500, 1);
%
% By:       Michael J. Richardson, 2009
%           Department of Psychology
%           University of Cincinnati
%           michael.richardson@uc.edu
%
%**************************************************************************
%**************************************************************************

close all;

%% Setup
x = zeros(iterations, 1);
y = zeros(iterations, 1);
x(1) = xin;
y(1) = yin;


%% Iterate equation
for i=2:iterations
    x(i) = A - x(i-1)^2 + B*y(i-1);
    y(i) = x(i-1);
end

%% juts gest last 200 points
x = x(end-39:end);
y = y(end-39:end);

%% Plot Data
figure;
hold on;
%plot x(t) vs. y(t)
subplot(2,2,[1 3]);
plot(x, y, 'ob', 'markersize', 2);
xlabel('x(t)');
ylabel('y(t)');
xlim([-2 2]);
ylim([-2 2]);

%plot x(t)
subplot(2,2,2);
plot(x, 'o-b', 'markersize', 2);
xlabel('Iteration (t)');
ylabel('x(t)');
xlim([0 length(x)]);
ylim([-2 2]);

%plot y(t)
subplot(2,2,4);
plot(y, 'o-b', 'markersize', 2);
xlabel('Iteration (t)');
ylabel('y(t)');
xlim([0 length(y)]);
ylim([-2 2]);

return;