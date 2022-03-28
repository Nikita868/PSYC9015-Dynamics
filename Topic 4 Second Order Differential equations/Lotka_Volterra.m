function [t x] = Lotka_Volterra(x0,y0,a,b,m,c,e,n,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [t x] = Lotka_Volterra(x0,k,stime)
%
%  Syntax:
%  [t x] = Lotka_Volterra([2],[1],1,1,0,1,1,0,10);
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H_INC = .02; %Sample increment (e.g., 0.02 = 50 "Hz")
t0 = H_INC; %start time

% set axis range for plots
if max(abs(x0)) > max(abs(y0))
    xrange = [0 max(x0)+2];
    yrange = xrange;
else
    xrange = [0 max(y0)+2];
    yrange = xrange;
end

%This sets up a time-vector--ode45 will integrate at just these times:
tspan=t0:H_INC:stime;

fprintf('processing... ... ...\n');

% figure;
hold on;
xlim(xrange);
ylim(yrange);
xlabel('x - Rabbit');
ylabel('y - Fox');
title('Phase diagram of Lotka Volterra Equation with vector field');

% calculate vector field
[x,y] = meshgrid(xrange(1):.1:xrange(2),yrange(1):.1:yrange(2));
u = a.*x - b.*x.*y - m.*x.^2;
v = c.*x.*y-e.*y-n.*y.^2;

quiver(x,y,u,v,1,'k','MaxHeadSize',2)

grid on

% calculate solutions for x0s
options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',[realmax realmax]);
[t x]=ode45(@Lotka_Volterra_ODE,tspan,[x0 y0],options,a,b,m,c,e,n);
plot(x(:,1), x(:,2));
plot(x0,y0,'or')

hold off;


return;
%//////////////////////////////////////////////////////////////////////////


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lotka_Volterra_ODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = Lotka_Volterra_ODE(t,x,a,b,m,c,e,n)

%One line for each state:
dxdt = [ 
        a*x(1) - b*x(1)*x(2) - m*x(1)^2
        c*x(1)*x(2) - e*x(2) - n*x(2)^2
    ];

return;
%//////////////////////////////////////////////////////////////////////////
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%