function IntMyODE_HKB(x0,a,b,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function IntMyODE_HKB(x0,a,b, stime)
%
%  Inputs:
%      x0 : initial condition of x
%      a: a parameter for the sine amplitude
%      stime : time of simulation 
%
%  Syntax:
%  IntMyODE_HKB(1,1,0.5,,5);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%This sets up a time-vector--ode45 will integrate at just these times:
H_INC = .02; %Sample increment (e.g., 0.02 = 50 "Hz")
tspan=H_INC:H_INC:stime; % time-vector

%Integrate:
options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',realmax);
[t, x] = ode45(@MyODE_Function,tspan,x0,options,a,b);

% close all;

% Plot intergration time-series
% figure;
plot(t, x(:,1), '-b'); % plot x vs. time
xlabel('time');
ylabel('x');
ylim([-5 5]);

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MyODE_Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = MyODE_Function(t, x, a,b)

dxdt = -a*sin(x) - 2*b*sin(2*x);

return;
%//////////////////////////////////////////////////////////////////////////
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%