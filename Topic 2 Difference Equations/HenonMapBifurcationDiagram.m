function HenonMapBifurcationDiagram(xin, yin, B, Amin, Amax, Astep)

%**************************************************************************
% function HenonMapBifurcationDiagram(B, C)
%  
% Input:
%            x_in   : initial condition
%            y_in   : initial condition
%               B   : parameter (e.g., 0.3)
%            Amin   : min for C parameter (e.g., .5);
%            Amax   : max for C parameter (e.g., 1.3);
%            Astep  :  step size of C (e.g., .001) 
% 
% % Syntax:  
%           HenonMapBifurcationDiagram(1, 1.5, 0.3, .5, 1.3, .002);
%
% By:       Michael J. Richardson, 2009
%           Department of Psychology
%           University of Cincinnati
%           michael.richardson@uc.edu
%
%**************************************************************************
%**************************************************************************

tsteps = 2000;

figure;
hold on;
xlabel('C');
ylabel('Asymptotic x(t)');
xlim([Amin Amax]);
ylim([-2 2]);

for A=Amin:Astep:Amax
    x = zeros(tsteps, 1);
    y = zeros(tsteps, 1);

    x(1) = xin;
    y(1) = yin;

    for i=2:tsteps
        x(i) = A - x(i-1)^2 + B*y(i-1);
        y(i) = x(i-1);
    end

    asymtop_x = tabulate(x(tsteps-300:tsteps));
    plot(A,asymtop_x(:,1), 'ok', 'markersize', 1);
end
hold off;

return;