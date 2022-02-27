function [t, x] = DampedMassSpring(x0,b,k,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [t, x] = DampedMassSpring(x0,b,k,stime)
%
%  Syntax:
%  [t, x] = DampedMassSpring([1 1],.5,1,25);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;

m = 1; % mass equal to 1

H_INC = .01; %Sample increment (e.g., 0.01 = 100 "Hz")
t0 = H_INC; %start time

%This sets up a time-vector--ode45 will integrate at just these times:
tspan=t0:H_INC:stime;

fprintf('processing... ... ...\n');

%Integrate:
options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',[realmax realmax]);
[t, x]=ode45(@DampedMassSpring_ODE,tspan,x0,options,m,b,k);

figure;
subplot(2,1,1);
plot(t, x);
xlabel('time');
legend('x(1)', 'x(2)');
ylim([-3 3]);

subplot(2,1,2);
plot(x(:,1), x(:,2));
xlabel('x(1)');
ylabel('x(2)');
grid on

return;
%//////////////////////////////////////////////////////////////////////////


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DampedMassSpring_ODE.m
% x'' = -(g/L)*sin(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = DampedMassSpring_ODE(t,x,m,b,k)

%One line for each state:
dxdt = [ 
        x(2)
         -((b/m)*x(2)) - ((k/m)*x(1));
    ];

return;
%//////////////////////////////////////////////////////////////////////////
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%