function [xt] = MayModel(X_in, R, K, iterations, animation_speed)
% This model describes population dynamics model specified by equation 1 in May (1975)
% May, R. M. (1975). Biological populations obeying difference equations: stable points, stable cycles, and chaos. Journal of Theoretical Biology, 51(2), 511-524.
%**************************************************************************
% function [xt] = MayModel(X_in, R, K, iterations, animation_speed)
%  
% 
% Input:
%            X_in   : initial condition (between 0 and K)
%               R   : Reproductive rate (between 0 and 4)
%               K   : Carrying capacity
%      iterations   : number of iterations (e.g., 50)
% animation_speed   : speed of plot animation in s. 0 = no animation. 
% 
% 
% Syntax:  
%           [xt] = MayModel(.5, 1.6,5, 100,0.1);
%
% Adapted by: Nikita Kuznetsov from:
% 
% By:       Michael J. Richardson, 2009
%           Department of Psychology
%           University of Cincinnati
%           michael.richardson@uc.edu
%
%
%**************************************************************************
%**************************************************************************

%% Initialize variables are parameters
close all; % Close any open figures (graphs)

% Initialize array of possible x values for function (x = 0 to 1);
x = 0:.001:10;
x = x'; % transpose x

% Initialize function array (fx)
fx = zeros(length(x),1);

% Initialize data array for initial value numerical solution (xt)
xt = zeros(iterations, 1);
xt(1) = X_in;


%% Calculate function for specific R value
for i=1:length(x)
    fx(i) = x(i)*exp(1)^(R*(1-(x(i)/K)));  
end

%% Calculate numeric solution specific R value and initial condition (X_in)
for i=2:iterations
    xt(i) = xt(i-1)*exp(1)^( R*(1-(xt(i-1)/K))); 
end

%% PLot Results
figure; %new figure

% Plot xt over iterations (time)
subplot(2,1,1);     % 2 x 1 subplots in figure; 1 = top
plot(xt, '-ok');    % plot interations time-series
xlabel('t');        % set axis label
ylabel('x');        % set axis label

% Plot function and cobweb solution
subplot(2,1,2);     % 2 x 1 subplots in figure; 2 = bottom
hold on;            % hold plot
plot(x,x, 'b-');    % plot x vs. x
plot(x,fx, '-k');   % plot function for specific R
xlabel('x(t)');     % set axis label
ylabel('x(t+1)');   % set axis label

% Plot solution using cobweb method
for i=1:iterations-1
    if i==1
        plot([xt(i),xt(i)],[0, xt(i+1)], '-r');
    else
        plot([xt(i-1),xt(i)],[xt(i),xt(i)], '-r');
        plot([xt(i),xt(i)],[xt(i),xt(i+1)], '-r');
    end
    pause(animation_speed); % animation speed
end

hold off;           % release plot

%% End of function
return;