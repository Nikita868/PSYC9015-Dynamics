function LogisticBifurcationDiagram(Rmin, Rmax, Rstep)

%**************************************************************************
% function LogisticBifurcationDiagram(Rmin, Rmax, Rstep, speed)
%  
% Input:
%            Rmin   : min R value (Min possible = 0)
%            Rmax   : max R value (Max possible = 4)
%           Rstep   : step size of R (e.g., .01) 
% 
% % Syntax:  
%           LogisticBifurcationDiagram(2, 4, .005);
%
% By:       Michael J. Richardson, 2009
%           Department of Psychology
%           University of Cincinnati
%           michael.richardson@uc.edu
%
%**************************************************************************
%**************************************************************************

close all; % Close any open figures (graphs)

%Calculate and plot bifrication diagram
figure;         % new figure
hold on;        % hold figure
xlabel('R');    % set axis label
ylabel('Asymptotic x(t)');  % set axis label
xlim([Rmin 4]); % set axis limits
ylim([0 1]);    % set axis limits

% For loop for r paramter iterations
for R=Rmin:Rstep:Rmax
    xt = zeros(2000, 1); % initialize xt array
    xt(1) = .1; % set initial condition

    % for loop for iterations a each value of r
    for i=2:2000
        xt(i) = R*xt(i-1)*(1-xt(i-1));
    end

    % get last 400 values to plt
    x_asym = tabulate(xt(1601:2000));
    
    % pplot last 400 values
    plot(R,x_asym(:,1), 'ok', 'markersize', 1);
    
    % pause for animation
    pause(.01);
end
hold off;

return;

