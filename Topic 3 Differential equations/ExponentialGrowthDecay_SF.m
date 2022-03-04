function [t x] = ExponentialGrowthDecay_SF(x0,b,a,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ExponentialGrowthDecay_SF.m
%
%   ODE: x' = b - ax
%
%   [t x] = ExponentialGrowthDecay_SF([-4 -2 0 2 4],3,2,3.5);
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
    [t x(:,i)]=ode45(@ExponentialGrowthDecay_ODE,tspan,x0(i),options,b,a);

    plot(t, x(:,i), '-b');
end

% calculate slope field
t_step = stime/20;
x_step = (max(xrange)-min(xrange))/20; 
for i=min(xrange):x_step:max(xrange)
    xs = b-a*i;
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
f(x) = b - a*x;
f(x) = subs(f(x), 'b', b);
f(x) = subs(f(x), 'a', a); 
fplot(f(x), xrange);
hold on;
plot(xrange, [0 0], '--k');
plot([0 0],[(b-a*xrange(1)) (b-a*xrange(2))], '--k');
xlabel('x');
ylabel('dx/dt');
hold off;
grid on

return;
%//////////////////////////////////////////////////////////////////////////


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ExponentialGrowth_ODE.m
% x' = b - ax
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = ExponentialGrowthDecay_ODE(t,x,b,a)

%One line for each state:
dxdt = b - a*x;

return;
%//////////////////////////////////////////////////////////////////////////
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%