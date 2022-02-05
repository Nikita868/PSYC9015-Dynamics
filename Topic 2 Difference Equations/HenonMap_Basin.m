function HenonMap_Basin(A, B)
%**************************************************************************
% function HenonMap_Basin(A, B)
%  
% Input:
%           A   : parameter (e.g., .5, 1.1, 2,... depends on B);
%           B   : parameter (e.g., -0.3, 0.3)
% 
% % Syntax:  
%           HenonMap_Basin(1.4, 0.3);
%
% By:       Michael J. Richardson, 2009
%           Department of Psychology
%           University of Cincinnati
%           michael.richardson@uc.edu
%
%**************************************************************************
%**************************************************************************

close all;

xmin = -2.5;
xmax = 2.5;
ymin = -2.5;
ymax = 2.5;

XYstep = .025;
tsteps = 2000;

figure;
hold on;
xlabel('X');
ylabel('Y');
xlim([xmin xmax]);
ylim([ymin ymax]);

for xstep=xmin:XYstep:xmax
    for ystep=ymin:XYstep:ymax
        x = zeros(tsteps, 1);
        y = zeros(tsteps, 1);
        
        x(1) = xstep;
        y(1) = ystep;

        for i=2:tsteps
            x(i) = A - x(i-1)^2 + B*y(i-1);
            y(i) = x(i-1);
        end

       if abs(x(tsteps)) > 0 
           if abs(x(tsteps)) < inf 
               plot(xstep,ystep, 'ok', 'markersize', 2); 
           end
       end
       plot(x(tsteps-200:tsteps),y(tsteps-200:tsteps), 'ob', 'markersize', 2);
    end
end
hold off;

return;