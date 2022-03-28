function [t x] = DampedMassSpring_Animation(x0,b,k,stime,vl)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [t x] = DampedMassSpring_Animation(x0,v0,b,k,stime,vl)
%
%  Syntax:
%  [t x] = DampedMassSpring_Animation([-2 0],.5,pi^2,20,.01);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;

m = 1; % mass equal to 1

H_INC = .04; %Sample increment (e.g., 0.02 = 25 "Hz")
t0 = H_INC; %start time



%This sets up a time-vector--ode45 will integrate at just these times:
tspan=t0:H_INC:stime;

fprintf('processing... ... ...\n');

% Integrate solution for x0:
options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',[realmax realmax]);
[t x]=ode45(@DampedMassSpring_ODE,tspan,x0,options,m,b,k);

% set axis range for plots
xrange = [-max(abs(x(:,1)))-1 max(abs(x(:,1)))+1];
yrange = [-max(abs(x(:,2)))-1 max(abs(x(:,2)))+1];


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
    
        xpsf = [i-vl*xs i+vl*xs];
        vpsf = [j-vl*vs j+vl*vs];
        
        plot(xpsf, vpsf,'-k'); 
    end
end

% plot ODE simulation
for pk=2:length(x)
    plot(x(pk-1:pk,1), x(pk-1:pk,2), '-r');
    pause(.02);
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