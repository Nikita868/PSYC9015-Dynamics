function [t,x] = Rayleigh_v2(x0,v0,b,sigma,w,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [t x] = Rayleigh_v2(x0,v0,b,sigma,w,stime)
%
%  Syntax:
%  [t,x] = Rayleigh_v2(-.1,0,-1,1.3,pi,15);
%  [t,x] = Rayleigh_v2(.9,0,-1,1.3,pi,15);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;

H_INC = .04; %Sample increment (e.g., 0.02 = 50 "Hz")
t0 = H_INC; %start time

%This sets up a time-vector--ode45 will integrate at just these times:
tspan=t0:H_INC:stime;

%Integrate:
%options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',[realmax realmax]);
%[t x]=ode45(@Rayleigh_ODE,tspan,[x0 v0],options,eps);
options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',[realmax realmax]);
[t x]=ode45(@Rayleigh_ODE,tspan,[x0 v0],options,b,sigma,w);

% set axis range for plots
xrange = [-max(abs(x(:,1)))-.5 max(abs(x(:,1)))+.5];
yrange = [-max(abs(x(:,2)))-1 max(abs(x(:,2)))+1];

figure;
hold on;
xlim(xrange);
ylim(yrange);
xlabel('x');
ylabel('y');
title('Rayleigh');

% calculate vector field
[xi,yi] = meshgrid(xrange(1):.2:xrange(2),yrange(1):.5:yrange(2));
ui = yi;
vi = -b*yi - sigma.*(yi.^3) - (w.^2)*xi;  
quiver(xi,yi,ui,vi,1,'k','MaxHeadSize',2)
grid on

% % calculate slope field
% for i=xrange(1):.2:xrange(2)
%     for j=yrange(1):.5:yrange(2)
%         dxdt = j;
%         dydt = -b*j-sigma*j^3-w^2*i;
%     
%         xpsf = [i-.015*dxdt i+.015*dxdt];
%         ypsf = [j-.015*dydt j+.015*dydt];
%         
%         plot(xpsf, ypsf,'-k'); 
%     end
% end

pause(1);
for i=2:length(x)
    pause(.001);
    plot(x(i-1:i,1), x(i-1:i,2), '-r');
end

hold off;

figure;
subplot(211)
plot(t,x(:,1));
xlabel('t');
ylabel('x');

subplot(212)
plot(t,x(:,2));
xlabel('t');
ylabel('y');
title('Rayleigh Time Series');

return;
%//////////////////////////////////////////////////////////////////////////


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rayleigh_ODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = Rayleigh_ODE(t,x,b,sigma,w)

%One line for each state:
dxdt = [ x(2)
        -b*x(2)-sigma*x(2)^3-w^2*x(1)
];

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%