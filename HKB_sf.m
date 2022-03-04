function [t x] = HKB_sf(x0,dw,a,b,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HKB_sf.m
%
%   ODE: x' = dw-a*sin(x)-2*b*sin(2*x)
%
%   [t x] = HKB_sf([-1/3*pi+1 pi-1 5/3*pi-1],0,2,1,5);
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
    [t x(:,i)]=ode45(@HKB_ODE,tspan,x0(i),options,dw,a,b);

    plot(t, x(:,i), '-b');
end

% calculate slope field
t_step = stime/30;
x_step = (max(xrange)-min(xrange))/30; 
for i=min(xrange):x_step:max(xrange)
    xs = dw-a*sin(i)-2*b*sin(2*i);
    for k = 0:t_step:stime    
        xpsf = [i-.05*xs i+.05*xs];
        tpsf = [k-.05 k+.05];
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
f(x) = dw-a*sin(x)-2*b*sin(2*x);
f(x) = subs(f(x),{a,b,dw},{a,b,dw})
fplot(f(x), xrange);
hold on;
plot(xrange, [0 0], '--k');
plot([0 0],[-5 5], '--k');
xlabel('x');
ylabel('dx/dt');
hold off;
grid on

return;
%//////////////////////////////////////////////////////////////////////////


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HKB_ODE.m
%   ODE: x' = -a*sin(x)-2*b*sin(2*x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = HKB_ODE(t,x,dw,a,b)

%One line for each state:
dxdt = dw-a*sin(x) - 2*b*sin(2*x);

return;
%//////////////////////////////////////////////////////////////////////////
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%