function [xt] = HW3_eq2(x0, C, iterations, animation_speed)

%**************************************************************************
% function [xt] = HW3_eq2(X_in, C, iterations, animation_speed)
%  
% Input:
%              x0   : initial condition (between 0 and 1)
%               C   : logistic parameter (number between .1 and 4)
%      iterations   : number of iterations (e.g., 50)
% animation_speed   : speed in seconds of plot animation . 0 = no animation. 
% 
% 
% % Syntax:  
%           [xt] = HW3_eq2(30, .5, 15, .25);
%
% By:       Michael J. Richardson, 2009
%           Department of Psychology
%           University of Cincinnati
%           michael.richardson@uc.edu
%
%**************************************************************************
%**************************************************************************

close all; % Close any open figures (graphs)

%% Initialize data array for initial value numerical solution (xt)
xt = zeros(iterations, 1);
xt(1) = x0;

%% Calculate numeric solution specific R value and initial condition (X_in)
for i=2:iterations
    xt(i) = C*(xt(i-1)^2)*(2-xt(i-1));
end

%% Initialize array of possible x values for function (x = 0 to 1);
% x = -(max(abs(xt))):.001:max(abs(xt));
x = -(max(abs(xt))):.001:2;
x = transpose(x);

%% Initialize function array (fx)
fx = zeros(length(x),1);

%% Calculate function for specific R value
for i=1:length(x)
    fx(i) = C*(x(i)^2)*(2-x(i));
end

%% Plot function and cobweb solution
figure; %new figure

%plot xt over iterations (time) - subplot 1
subplot(2,1,1);
plot(xt, '-ok');
xlim([0 iterations]);
ylim([min(xt) max(xt)]);
xlabel('t');
ylabel('x');

%setup cobweb subplot 2
subplot(2,1,2);  hold on;
xlabel('x(t)');
ylabel('x(t+1)');
plot(x,x, '-b'); %plot x vs. x
plot(x,fx, '-k'); %plot function for specific R
plot([-(max(abs(xt))) max(abs(xt))], [0 0], ':k'); %plot center lines
plot([0 0], [-(max(abs(xt))) max(abs(xt))], ':k'); %plot center lines

%animate cobweb plot
for i=1:iterations-1
    %plot solution using cobweb method - subplot 2
    if i==1
        plot([xt(i),xt(i)],[0, xt(i+1)], '-r');
    else
        plot([xt(i-1),xt(i)],[xt(i),xt(i)], '-r');
        plot([xt(i),xt(i)],[xt(i),xt(i+1)], '-r');
    end   
    % animation speed
    pause(animation_speed);
end

hold off;

return;