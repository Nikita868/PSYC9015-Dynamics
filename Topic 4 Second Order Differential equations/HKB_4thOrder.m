%[t,x,NOISE_FUNCS] = HKB_4thOrder_do(Pos1, Pos2, b, sigma, gamma, k1, k2, beta, alpha, q, Rseed, stoptime, samplerate, plotflag);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HKB_4thOrder_do.m
% Single Simulation of Rayliegh coupled osscilators (HKB_Ray_Sim.m)
% For testing HKB model as per Haken, Kelso Bunz (1985)
% M.J.Richardson 9/2003
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [t,x,NOISE_FUNCS] = HKB_4thOrder(Pos1, Pos2, b, sigma, gamma, k1, k2, beta, alpha, q, stoptime, samplerate, plotflag);

%   Input*******************
        % Pos1 & Pos2     :-> Beta coupling constants for oscillators 
        %                     (e.g. 1,1 =: inphase;  1,-1 =: antiphase)
        % b               :-> positve damping
        % beta            :-> Beta coupling constants for oscillators
        % alpha           :-> Aplha coupling constant for oscillators
        % k1 & k2         :-> Stiffness constants for oscillators
        % sigma           :-> nonlinear Escapement constants for oscillators
        % gamma           :-> nonlinear Escapement constants for oscillators
        % q               :-> the gain of Noise for oscillators
        % Rseed           :-> sets the seed on the noise generator
        % stoptime        :-> length of time for simulation
        % ssample rate    :-> Hz, e.g 100
        % plotflag        :-> do plot = 1, no plot = 0;

 %   Output*******************
        % t1              :-> time array
        % y1              :-> position and velocities of oscillators,  y[Osc1_pos, Osc1_vel, Osc2_pos, Osc2_vel]
        %NOISE_FUNCS      :-> noise array used during simulation
        
 %    Example****************
 %   [t1,y1,noise_array] = HKB_4thOrder(1,1,-1,0.2,2,1.2,1.2,0.2,-0.2,.1, 50, 20, 1);
 %   [t1,y1,noise_array] = HKB_4thOrder(1,-1,-1,0.2,2,1.2,1.2,0.2,-0.2,.1, 50, 20, 1);
 %   [t1,y1,noise_array] = HKB_4thOrder(1,-1,-1,0.2,2,1.2,1.2,0.2,-0.3,.1, 50, 30, 1);
 %   [t1,y1,noise_array] = HKB_4thOrder(1,1,-1,0.2,2,1.2,1.15,0.2,-0.2,.1, 50, 30, 1);
 %   [t1,y1,noise_array] = HKB_4thOrder(1,-1,-1,0.2,2,1.2,1.15,0.2,-0.2,.1, 50, 30, 1);
        
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Beta = [beta beta];
Alpha = [alpha alpha];
K = [k1^2 k2^2];

%Set up the integration parameters:
H_INC = 1/samplerate; %Sample increment (e.g., 0.01 = 100 "Hz")
t0 = H_INC; %start time
tf = stoptime;  %stop time

%This sets up a time-vector--ode45 will integrate at just these times:
tspan=t0:H_INC:tf;

%Set up the noise inputs, one for each oscillator:
%Set up the noise inputs, one for oscillator:
rng('shuffle');
NOISE_FUNCS = zeros(length(tspan),2);
NOISE_FUNCS(:,1) = sqrt(q)*randn(length(tspan),1);
NOISE_FUNCS(:,2) = sqrt(q)*randn(length(tspan),1);

%Set the initial conditions:
y0 = [Pos1 0 Pos2 0]';

fprintf('processing... ... ...\n');
%Integrate:
options = odeset('InitialStep',H_INC,'MaxStep',H_INC,'RelTol',realmax,'AbsTol',[realmax realmax realmax realmax]);
[t,x]=ode45(@HKB_Ray_Sim,tspan,y0,options,H_INC,NOISE_FUNCS,b,sigma,gamma,K,Beta,Alpha);

if (plotflag == 1)
    close all;
    
    figure;
    hold on
    xlim([-1.5 1.5]);
    ylim([-1.5 1.5]);
    xlabel('Osc/Limb 1');
    ylabel('Osc/Limb 2');
    title('HKB - 4th Order Approx ');
    for i=2:length(x)
        plot(x(i-1:i,1), x(i-1:i,3),'b');
        pause(.01);
    end
    hold off;
    
    figure;
    plot(t, x(:,1), '-b');
    hold on;
    plot(t, x(:,3), '-r');
    xlabel('Time');
    ylabel('Position');
    title('HKB - 4th Order Approx');
    hold off;
    
end

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HKB_Ray_Sim.m
% Coupled Rayleigh osccialtors (4TH order) 
% For testing HKB model as per Haken, Kelso Bunz (1985)
% M.J.Richardson 9/2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dxdt = HKB_Ray_Sim(t,y,H_INC,NOISE_FUNCS,b,sigma,gamma,K,Beta,Alpha)

%compute index for the noise term
i = floor(t/H_INC);

%One line for each state:
dxdt =[ y(2)
       -b*y(2)-sigma*y(2)^3-gamma*y(1)^2*y(2)-K(1)*y(1)+(y(2)-y(4))*(Alpha(1)+Beta(1)*(y(1)-y(3))^2) + NOISE_FUNCS(i,1)
       y(4)
       -b*y(4)-sigma*y(4)^3-gamma*y(3)^2*y(4)-K(2)*y(3)+(y(4)-y(2))*(Alpha(2)+Beta(2)*(y(3)-y(1))^2) + NOISE_FUNCS(i,2)
];

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
