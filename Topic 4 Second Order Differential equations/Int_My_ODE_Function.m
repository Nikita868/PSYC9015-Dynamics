function [t x] = Int_My_ODE_Function(x0,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function Int_My_ODE_Function(x0)
%
%  Syntax:
%  [t x] = Int_My_ODE_Function([1 -1],50);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%This sets up a time-vector--ode45 will integrate at just these times:
H_INC = .02; %Sample increment (e.g., 0.02 = 50 "Hz")
tspan=H_INC:H_INC:stime; % time-vector

%Integrate:
options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',[realmax realmax]);
[t x] = ode45(@My_ODE_Function,tspan,x0,options);

close all;

figure;
subplot(2,2,[1,3]);
plot(x(:,1), x(:,2),'.-');
xlabel('x');
ylabel('y');
grid on
axis square

subplot(2,2,2);
plot(t, x(:,1));
xlabel('time');
ylabel('x');
grid on

subplot(2,2,4)
plot(t, x(:,2));
xlabel('time');
ylabel('y');
grid on

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% My_ODE_Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = My_ODE_Function(t, x)

% Set parameter values
a = 1;
b = -1.8;
c = 1.5;
d = .5;

%One line for each state:
dxdt = [ 
        a*x(1) + b*x(2)
        c*x(1) + d*x(2)
    ];

return;
%//////////////////////////////////////////////////////////////////////////
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%