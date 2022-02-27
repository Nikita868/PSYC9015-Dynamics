function [t x] = LogisticGrowth(x0,a,b,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LogisticGrowth.m
%
%   [t x] = LogisticGrowth([0 .1 .8 2 4],2,1.1,5);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;

H_INC = .01; %Sample increment (e.g., 0.01 = 100 "Hz")
t0 = H_INC; %start time
xrange = [min(x0)-1 max(x0)+1]; % set range of x0s for plots

%This sets up a time-vector--ode45 will integrate at just these times:
tspan=t0:H_INC:stime;

% set output array for x
x = zeros(length(tspan),length(x0));

fprintf('processing... ... ...\n');

figure;
subplot(2,1,1);
hold on;
for i=1:length(x0)
    options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',realmax);
    [t x(:,i)]=ode45(@LogisticGrowth_ODE,tspan,x0(i),options,a,b);
    
    plot(t, x, 'b-');
end
xlabel('time');
ylabel('x');
ylim(xrange);
hold off;
grid on

subplot(2,1,2);
syms f(y)
f(y) = a*y-b*y^2;
f(y) = subs(f(y), {'a','b'}, {a, b}); 
fplot(f(y), xrange);
hold on;
plot(xrange, [0 0], '--k');
plot([0 0],[-20 10], '--k');
hold off;
grid on
xlabel('$\ x$','interpreter','latex')
ylabel('$\dot x$','interpreter','latex')

return;
%//////////////////////////////////////////////////////////////////////////


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LogisticGrowth_ODE.m
% x' = ax - bx^2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = LogisticGrowth_ODE(t,x,a,b)

%One line for each state:
dxdt = a*x-b*x^2;

return;
%//////////////////////////////////////////////////////////////////////////
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%