function [xt] = LinearSocialMobilization(x0, g, f, L, iterations, animation_speed)

%**************************************************************************
% function [xt] = LinearSocialMobilization(x0, g, f, L, iterations, animation_speed)
%  
% Linear difference equation model of social mobilization described in
% chapter 2 of Dynamic Modeling: An Introduction (Quantitative Applications
% in the Social Sciences) by Huckfeldt, Kohfeld, & Likens.
% 
% Input:
%              x0   : initial condition - proporiton of population already mobilized at the start of the modeled period(between 0 and 1)
%               g   : gain in members (probability of being recruited (number between 0 and 1)
%               f   : loss of members (probability of dropping out, [0,1] )
%               L   : "mobilizable proportion of population [0,1]
%      iterations   : number of iterations (e.g., 50)
% animation_speed   : speed in seconds of plot animation . 0 = no animation. 
% 
% 
% % Syntax:  
%           [xt] = LinearSocialMobilization(0.1, 0.07, 0.04, 0.75, 50, .25);
%
% By:       Nikita Kuznetsov, 2022
%
%           Adapted from:
%           Michael J. Richardson, 2009
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
    xt(i) = (1-g-f)*xt(i-1)+g*L;
end

%% Initialize array of possible x values for function (x = 0 to 1);
x = 0:.001:1;
x = transpose(x);

%% Initialize function array (fx)
fx = zeros(length(x),1);

%% Calculate function for specific R value
for i=1:length(x)
    fx(i) = (1-g-f)*x(i)+g*L;
end

%% Plot function and cobweb solution
figure; %new figure

%plot xt over iterations (time) - subplot 1
subplot(2,1,1);
plot(xt, '-ok');
xlim([0 iterations]);
ylim([0 1]);
xlabel('t');
ylabel('x');
grid minor

%setup cobweb subplot 2
subplot(2,1,2);  hold on;
xlabel('x(t)');
ylabel('x(t+1)');
plot(x,x, '-b'); %plot x vs. x
plot(x,fx, '-k'); %plot function for specific R
plot([-(max(abs(xt))) max(abs(xt))], [0 0], ':k'); %plot center lines
plot([0 0], [-(max(abs(xt))) max(abs(xt))], ':k'); %plot center lines
xlim([0 1]);
ylim([0 1]);

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