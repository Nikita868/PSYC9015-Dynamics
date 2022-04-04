%[t,x] = Forced_Ray_do(Pos, K, sigma, beta, fw, stoptime, plotflag);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% M.J.Richardson 1/2007
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [t,x] = Forced_Rayleigh(Pos, K, sigma, beta, fw, stoptime, plotflag)

%    Examples
%   [t,x] = Forced_Rayleigh(.2, 1.8*pi, 1, 1, 2*pi, 30, 1);
%   [t,x] = Forced_Rayleigh(.2, 2*pi, 1, 1, 2*pi, 30, 1);
%   [t,x] = Forced_Rayleigh(.2, 1.5*pi, 1, 1, 2*pi, 30, 1);
        
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Set up the integration parameters:
H_INC = 1/25; %Sample increment (e.g., 0.04 = 25 "Hz")
t0 = H_INC; %start time
tf = stoptime;  %stop time

%This sets up a time-vector--ode45 will integrate at just these times:
tspan=t0:H_INC:tf;

%Set the initial conditions:
y0 = [Pos 0 1]';

fprintf('processing... ... ...\n');
%Integrate:
options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',[realmax realmax realmax]);
[t,x]=ode45(@Forced_Ray_Sim,tspan,y0,options,K,sigma,beta,fw);

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
    hold on;
    ylabel('time');
    xlabel('x and dxdt');
    xlim([0 stoptime])
    ylim([min(x(:,1))-.5 max(x(:,1))+.5]);
    plot(t, x(:,1), '-b');

end

beep();
return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Forced_Ray_Sim.m
% Coupled Rayleigh and linear osccialtors
% M.J.Richardson 9/2007
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dxdt = Forced_Ray_Sim(t,y,k,sigma,beta,fw)

%One line for each state:
dxdt =[ 
       y(2)
       -k^2*y(1)-sigma*(((y(2)^2)-1)*y(2))+ beta*cos(y(3)*fw)
       1
];

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
