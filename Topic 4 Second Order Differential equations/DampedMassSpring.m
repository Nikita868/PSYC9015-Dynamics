function [t x] = DampedMassSpring(x0,v0,b,k,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [t x] = DampedMassSpring(x0,v0,b,k,stime)
%
%  Syntax:
%  [t x] = DampedMassSpring([-4 -1.5 1.5 4],[0],.5,1,20);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;

m = 1; % mass equal to 1

H_INC = .02; %Sample increment (e.g., 0.02 = 50 "Hz")
t0 = H_INC; %start time

% set axis range for plots
if max(abs(x0)) > max(abs(v0))
    xrange = [-max(abs(x0))-1 max(abs(x0))+1];
    yrange = xrange;
else
    xrange = [-max(abs(v0))-1 max(abs(v0))+1];
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
title(['Damped Mass Spring [m=1, b=', sprintf('%.2f', b), ';  k=',  sprintf('%.2f', k),']']);

% calculate slope field
for i=xrange(1):.5:xrange(2)
    for j=yrange(1):.5:yrange(2)
        xs = j;
        vs = -((b/m)*j)-((k/m)*i);
    
        xpsf = [i-.03*xs i+.03*xs];
        vpsf = [j-.03*vs j+.03*vs];
        
        plot(xpsf, vpsf,'-k'); 
    end
end

% calculate solutions for x0s
for i=1:length(x0)
    for j=1:length(v0)
        %Integrate:
        options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',[realmax realmax]);
        [t x]=ode45(@DampedMassSpring_ODE,tspan,[x0(i) v0(j)],options,m,b,k);

        plot(x(:,1), x(:,2));
    end
end

hold off;


return;
%//////////////////////////////////////////////////////////////////////////


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DampedMassSpring_ODE.m
% x'' = 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = DampedMassSpring_ODE(t,x,m,b,k)

%One line for each state:
dxdt = [ 
        x(2)
         -(b/m)*x(2)-((k/m)*x(1));
    ];

return;
%//////////////////////////////////////////////////////////////////////////
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%