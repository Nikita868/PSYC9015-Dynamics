function [t,x] = VanDerPol_v2(x0,v0,b,gamma,w,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [t x] = VanDerPol_v3(x0,v0,b,gamma,w,stime)
%
%  EXAMPLE Syntax:
%   [t,x] = VanDerPol_v2(.5,.5,-1,1,2*pi,15);
%   [t,x] = VanDerPol_v2(2,20,-1,1,2*pi,15);
%   [t,x] = VanDerPol_v2(.5,.5,-1,2,pi,15);
%   [t,x] = VanDerPol_v2(2,20,-1,2,pi,15);
%   [t,x] = VanDerPol_v2(2,10,1,2,pi,15);
%   [t,x] = VanDerPol_v2(.1,10,-1,1,1,40);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;

%% This sets up a time-vector--ode45 will integrate at just these times:
H_INC = .02; %Sample increment (e.g., 0.02 = 50 "Hz")
t0 = H_INC; %start time
tspan=t0:H_INC:stime;

%% Integrate:
fprintf('processing... ... ...\n');
options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',[realmax realmax]);
[t x]=ode45(@VanDerPol_System,tspan,[x0 v0],options,b,gamma,w);

%% set axis range for plots
xrange = [-max(abs(x(:,1)))-1 max(abs(x(:,1)))+1];
yrange = [-max(abs(x(:,2)))-5 max(abs(x(:,2)))+5];

%% Create Plot
figure;
hold on;
xlim(xrange);
ylim(yrange);
xlabel('x');
ylabel('y');
title('Van der Pol');

% calculate vector field
[xi,yi] = meshgrid(xrange(1):.5:xrange(2),yrange(1):2:yrange(2));
u = yi;
v = - b.*yi - gamma.*(xi.^2).*yi - (w.^2).*xi;  
quiver(xi,yi,u,v,1,'k','MaxHeadSize',2)
grid on


% %% Calculate slope field
% for i=xrange(1):.5:xrange(2)
%     for j=yrange(1):2:yrange(2)
%         dxdt = j;
%         dydt = -b*j -gamma*i^2*j -w^2*i ;
%     
%         xpsf = [i-.01*dxdt i+.01*dxdt];
%         ypsf = [j-.01*dydt j+.01*dydt];
%         
%         plot(xpsf, ypsf,'-k'); 
%     end
% end

%% Do Animation
for i=2:length(x)
    pause(.01);
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
title('Van der Pol Time Series');

return;
%//////////////////////////////////////////////////////////////////////////


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VanDerPol_System Version 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = VanDerPol_System(t,x,b,gamma,w)

%One line for each state:
dxdt = [ 
        x(2)
        - b*x(2) - gamma*x(1)^2*x(2) - w^2*x(1)
    ];

return;
%//////////////////////////////////////////////////////////////////////////
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%