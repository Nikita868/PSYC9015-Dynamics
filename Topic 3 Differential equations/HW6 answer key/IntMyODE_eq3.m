function IntMyODE_eq3(x0,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function IntMyODE(x0, stime)
%
%  Inputs:
%      x0 : initial condition of x
%      stime : time of simulation 
%
%  Syntax:
%  IntMyODE_eq1(1 ,5);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%This sets up a time-vector--ode45 will integrate at just these times:
H_INC = .02; %Sample increment (e.g., 0.02 = 50 "Hz")
tspan=H_INC:H_INC:stime; % time-vector

%Integrate:
[t, x] = ode45(@MyODE_Function,tspan,x0);

% close all;

% Plot intergration time-series
% figure;
plot(t, x(:,1), '-b'); % plot x vs. time
xlabel('time');
ylabel('x');
ylim([-5 5]);
grid on

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MyODE_Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = MyODE_Function(t, x)

dxdt = 1+0.5*cos(x);

return;
%//////////////////////////////////////////////////////////////////////////
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%