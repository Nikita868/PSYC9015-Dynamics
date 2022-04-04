function [t,x] = ForcedDuffing(x0,v0,b,eps,k,beta,fw,stime,plotflag)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [t x] = ForcedDuffing(x0,v0,b,eps,w,beta,fw,stime,plotflag)
%
%  Syntax:
%  [t x] = ForcedDuffing(-.5,0,.5,1,2*pi,1,2*pi,20,1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;

m = 1; % mass equal to 1

H_INC = .02; %Sample increment (e.g., 0.02 = 50 "Hz")
t0 = H_INC; %start time

% set axis range for plots
if max(abs(x0)) > max(abs(v0))
    xrange = [-max(abs(x0))-2 max(abs(x0))+2];
    yrange = xrange;
else
    xrange = [-max(abs(v0))-2 max(abs(v0))+2];
    yrange = xrange;
end

%This sets up a time-vector--ode45 will integrate at just these times:
tspan=t0:H_INC:stime;

fprintf('processing... ... ...\n');

figure;
hold on;
xlim(xrange);
ylim(yrange);
xlabel('x(1)');
ylabel('x(2)');
title('Forced Duffing');

% calculate solutions for x0s
options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',[realmax realmax realmax]);
[t x]=ode45(@ForcedDampedMassSpring_ODE,tspan,[x0 v0 1],options,b,eps,k,beta,fw);

close all;
if (plotflag == 1)
    figure;
    grid on
    xlabel('x');
    ylabel('dxdt');
    xlim([min(x(:,1))-.5 max(x(:,1))+.5]);
    ylim([min(x(:,2))-.5 max(x(:,2))+.5]);
    hold on
    for i=2:length(x)
        plot(x(i-1:i,1), x(i-1:i,2),'b');
        pause(.01);
    end
    hold off;
    
    figure;
    ylabel('x and dxdt');
    xlabel('time');
    xlim([0 stime])
    ylim([min(x(:,1))-.5 max(x(:,1))+.5]);
    plot(t(:,1), x(:,1), '-b');
end


hold off;


return;
%//////////////////////////////////////////////////////////////////////////


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ForcedDampedMassSpring_ODE.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = ForcedDampedMassSpring_ODE(t,x,b,eps,k,beta,fw)

%One line for each state:
dxdt = [ 
        x(2)
         -b*x(2)-eps*x(1)^3-k^2*x(1)+beta*cos(x(3)*fw);
         1
    ];

return;
%//////////////////////////////////////////////////////////////////////////
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%