function [t x] = SimpleSine_sf(x0,a,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LogisticGrowth_sf.m
%
%   ODE : x' = a*sin(x)
%
%   [t x] = SimpleSine_sf([0 .1 .8 2 4],2.1,5);
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
hold on;

% calculate solutions for x0s
for i=1:length(x0)
    options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',realmax);
    [t x(:,i)]=ode45(@SimpleSine_ODE,tspan,x0(i),options,a);
    
    plot(t, x(:,i), '-b');
end

% calculate slope field
t_step = stime/20;
x_step = (max(xrange)-min(xrange))/20; 
for i=min(xrange):x_step:max(xrange)
    xs = a*sin(i);
    for k = 0:t_step:stime    
        xpsf = [i-.03*xs i+.03*xs];
        tpsf = [k-.03 k+.03];
        plot(tpsf, xpsf,'-k'); 
    end
end

xlabel('time');
ylabel('x');
xlim([0 stime]);
ylim(xrange);
hold off;

figure;
syms f(x)
f(x) = a*sin(x);
f(x) = subs(f(x), 'a', a); 
fplot(f(x), xrange);
hold on;
plot(xrange, [0 0], '--k');
plot([0 0],[-20 10], '--k');
hold off;
grid on

return;
%//////////////////////////////////////////////////////////////////////////


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LogisticGrowth_ODE.m
% x' = ax - bx^2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = SimpleSine_ODE(t,x,a)

%One line for each state:
dxdt = a*sin(x);

return;
%//////////////////////////////////////////////////////////////////////////
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%