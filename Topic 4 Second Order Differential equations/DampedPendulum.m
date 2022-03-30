function [t x] = DampedPendulum(x0,y0,% specify input parameters here %  ,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [t x] = Lotka_Volterra(x0,k,stime)
%
%  Syntax:
%  [t x] = DampedPendulum(.5,.5,% specify input parameters here %  ,10)
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
xlabel('x(1)');
ylabel('y(2)');
title('Phase diagram of Lotka Volterra Equation with vector field');

% calculate vector field
[x,y] = meshgrid(xrange(1):.1:xrange(2),yrange(1):.1:yrange(2));
u = a.*x - b.*x.*y - m.*x.^2;
v = c.*x.*y-e.*y-n.*y.^2;

quiver(x,y,u,v,1,'k','MaxHeadSize',2)

grid on

% calculate solutions for x0s
options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',[realmax realmax]);
[t x]=ode45(@Damped_Pendulum_ODE,tspan,[x0 y0],options,% specify input parameters here);
plot(x(:,1), x(:,2));
plot(x0,y0,'or')

hold off;


return;
%//////////////////////////////////////////////////////////////////////////


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dampled Pendulum_ODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = Damped_Pendulum_ODE(t,x, % specify input parameters here)

%One line for each state:
dxdt = [ 
        % Eq 1
        % eq. 2

    ];

return;
%//////////////////////////////////////////////////////////////////////////
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%