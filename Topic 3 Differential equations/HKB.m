function [t, x] = HKB(x0,a,b,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HKB.m
%
%   ODE: -a*sin(x) - 2*b*sin(2*x);
%
%   [t, x] = HKB([-4 -2 0 2 4],1,.5,5);
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
    [t, x(:,i)]=ode45(@HKB_ODE,tspan,x0(i),options,a,b);

    plot(t, x, '-b');
end
xlabel('time');
ylabel('x');
ylim(xrange);
hold off;


subplot(2,1,2);
syms f(y)
f(y) = a*sin(y)-2*b*sin(2*y);
f(y) = subs(f(y), {'a','b'}, {a, b}); 
fplot(f(y), xrange);
hold on;
plot(xrange, [0 0], '--k');
plot([0 0],[-5 5], '--k');
xlabel('$\ x$','interpreter','latex')
ylabel('$\dot x$','interpreter','latex')
hold off;
grid on
return;
%//////////////////////////////////////////////////////////////////////////


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ExponentialGrowth_ODE.m
% x' = b - ax
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = HKB_ODE(t,x,a,b)

%One line for each state:
dxdt = -a*sin(x) - 2*b*sin(2*x);

return;
%//////////////////////////////////////////////////////////////////////////
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%