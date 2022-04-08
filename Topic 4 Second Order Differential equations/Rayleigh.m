function [t,x] = Rayleigh(x0,y0,u,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [t,x] = Rayleigh(x0,y0,u,stime)
%
%  Syntax:
%  [t,x] = Rayleigh([-2 -.1 .1 1],[-2 0 2],.5,15);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% close all;

H_INC = .02; %Sample increment (e.g., 0.02 = 50 "Hz")
t0 = H_INC; %start time

% set axis range for plots
if max(abs(x0)) > max(abs(y0))
    xrange = [min(x0)-1 max(x0)+1];
    yrange = xrange;
else
    xrange = [min(y0)-1 max(y0)+1];
    yrange = xrange;
end

%This sets up a time-vector--ode45 will integrate at just these times:
tspan=t0:H_INC:stime;

figure;
hold on;
xlim(xrange);
ylim(yrange);
xlabel('x');
ylabel('y');
title('Rayleigh');

% calculate vector field
[xi,yi] = meshgrid(xrange(1):.2:xrange(2),yrange(1):.2:yrange(2));
ui = yi;
vi = -xi + u.*(1-yi.^2).*yi;  
quiver(xi,yi,ui,vi,1,'k','MaxHeadSize',2)
grid on

% calculate solutions for x0s
for i=1:length(x0)
    for j=1:length(y0)
        %Integrate:
        options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',[realmax realmax]);
        [t x]=ode45(@Rayleigh_ODE,tspan,[x0(i) y0(j)],options,u);

        plot(x(:,1), x(:,2));
    end
end

hold off;


return;
%//////////////////////////////////////////////////////////////////////////


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rayleigh_ODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = Rayleigh_ODE(t,x,u)

%One line for each state:
dxdt = [ 
        x(2)
        -x(1)-u*(1-x(2)^2)*x(2)
];

return;
%//////////////////////////////////////////////////////////////////////////
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%