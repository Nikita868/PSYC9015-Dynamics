function [t, x] = SwingingPendulum(x0,L,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LogisticGrowth.m
%
%   [t, x] = SwingingPendulum([1 1],.5,25);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;

g = 9.80665; %Gravitational acceleration in m/s^2

H_INC = .01; %Sample increment (e.g., 0.01 = 100 "Hz")
t0 = H_INC; %start time

%This sets up a time-vector--ode45 will integrate at just these times:
tspan=t0:H_INC:stime;

fprintf('processing... ... ...\n');

%Integrate:
options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',[realmax realmax]);
[t, x]=ode45(@SwingingPendulum_ODE,tspan,x0,options,g,L);

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

% subplot(2,2,[2,4]);
% syms f(y)
% f(y) = -(g/L)*sin(y);
% f(y) = subs(f(y), {'g','L'}, {g, L}); 
% fplot(f(y),[min(x(:,1)) max(x(:,1))]);

hold on;
plot([-2*pi() 2*pi()], [0 0], '--k');
hold off;
grid on
xlabel('$\ x$','interpreter','latex')
ylabel('$\dot x$','interpreter','latex')
xlim([min(x(:,1)), max(x(:,1))])
return;
%//////////////////////////////////////////////////////////////////////////


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SwingingPendulum_ODE.m
% x'' = -(g/L)*sin(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = SwingingPendulum_ODE(t,x,g,L)

%One line for each state:
dxdt = [ 
        x(2)
         -(g/L)*sin(x(1));
    ];

return;
%//////////////////////////////////////////////////////////////////////////
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%