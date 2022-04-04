function [t,x] = Rayleigh_Noise(x0,v0,u,q,stime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [t x] = Rayleigh_Noise(x0,u,q,stime)
%
%  Syntax:
%  [t,x] = Rayleigh_Noise(-.1,0,.6,.6,30);
%  [t,x] = Rayleigh_Noise(-.1,0,.6,.1,30);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;

H_INC = .04; %Sample increment (e.g., 0.02 = 50 "Hz")
t0 = H_INC; %start time

%This sets up a time-vector--ode45 will integrate at just these times:
tspan=t0:H_INC:stime;

%Set up the noise inputs, one for oscillator:
rng('shuffle');
NOISE_FUNCS = zeros(length(tspan),1);
NOISE_FUNCS(:,1) = sqrt(q)*randn(length(tspan),1);

%Integrate:
%options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',[realmax realmax]);
%[t x]=ode45(@Rayleigh_ODE,tspan,[x0 v0],options,u);
options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',[realmax realmax]);
[t x]=ode45(@Rayleigh_ODE,tspan,[x0 v0],options,H_INC, NOISE_FUNCS,u);

% set axis range for plots
xrange = [-max(abs(x(:,1)))-1 max(abs(x(:,1)))+1];
yrange = [-max(abs(x(:,2)))-1 max(abs(x(:,2)))+1];

figure;
hold on;
xlim(xrange);
ylim(yrange);
xlabel('x');
ylabel('y');
title('Reyleigh');

% calculate slope field
for i=xrange(1):.2:xrange(2)
    for j=yrange(1):.2:yrange(2)
        dxdt = j;
        dydt = -i-u*((j^2-1)*j);
    
        xpsf = [i-.015*dxdt i+.015*dxdt];
        ypsf = [j-.015*dydt j+.015*dydt];
        
        plot(xpsf, ypsf,'-k'); 
    end
end

pause(1);
for i=2:length(x)
    pause(.001);
    plot(x(i-1:i,1), x(i-1:i,2), '-r');
end

hold off;


return;
%//////////////////////////////////////////////////////////////////////////


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rayleigh_ODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = Rayleigh_ODE(t,x,H_INC,NOISE_FUNCS,u)

%compute index for the noise term
i = floor(t/H_INC);

%One line for each state:
dxdt = [ x(2)
       -x(1)-u*((x(2)^2-1)*x(2)) + NOISE_FUNCS(i,1)
];

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%