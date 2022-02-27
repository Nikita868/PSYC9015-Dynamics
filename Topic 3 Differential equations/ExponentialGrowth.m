function [t, x] = ExponentialGrowth(x0,a,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ExponentialGrowth.m
%
%   [t, x] = ExponentialGrowth(1,1.3,10);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;

H_INC = .01; %Sample increment (e.g., 0.01 = 100 "Hz")
t0 = H_INC; %start time

%This sets up a time-vector--ode45 will integrate at just these times:
tspan=t0:H_INC:stime;

fprintf('processing... ... ...\n');
%Integrate:
options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',realmax);
[t, x]=ode45(@ExponentialGrowth_ODE,tspan,x0,options,a);

figure;
subplot(2,1,1);
plot(t, x, '-b');
xlabel('time (s)');
ylabel('x');
grid on

subplot(2,1,2);
syms f(y)
f(y) = a*y;
f(y) = subs(f(y), 'a', a); 
fplot(f(y), [-5 5]);
hold on;
plot([-5 5], [0 0], '--k');
plot([0 0],[-(a*5) (a*5)], '--k');
hold off;
grid on
xlabel('$\ x$','interpreter','latex')
ylabel('$\dot x$','interpreter','latex')

return;
%//////////////////////////////////////////////////////////////////////////


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ExponentialGrowth_ODE.m
% x' = rx
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = ExponentialGrowth_ODE(t,x,a)

%One line for each state:
dxdt = a*x;

return;
%//////////////////////////////////////////////////////////////////////////
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%