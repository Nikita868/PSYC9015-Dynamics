function BZ_Simulation(alpha, beta, gamma, gridsize, itime)
%**************************************************************************  
% Description: The Balazova-Zhabotinsky reaction can be reduced to three autocatalytic 
% equations (reactions), where A, B and C represent the three reactants. 
% 
%        A + B = 2A,    B + C = 2B,    C + A = 2C
% 
% Such that the quantity of A, B and C as time progresses can be written
% as:
%   at+1 = at + at(alpha*bt - gamma*ct)
%   bt+1 = bt + bt(gamma*ct - beta*at)
%   ct+1 = ct + ct(beta*at - alpha*bt)
% 
% where the parameters alpha, beta, gamma determine the rate of reaction.
%
% Input:
%            alpha   : paramter
%             beta   : paramter
%            gamma   : paramter
%         gridsize   : size of image grid (number of cells)
%            itime   : number of iterations (e.g., 2000)
% 
% % Syntax:  
%           BZ_Simulation(1.2, 1, 1, 200, 200);
%
% By:       Michael J. Richardson, 2009
%           Department of Psychology
%           University of Cincinnati
%           michael.richardson@uc.edu
%
%**************************************************************************
%**************************************************************************

%% Setup grid and simulation variables
p = 1;
q = 2;

grid_width = gridsize;
grid_height = gridsize;

a = zeros(grid_width,grid_height,2);
b = zeros(grid_width,grid_height,2);
c = zeros(grid_width,grid_height,2);

%% Populate grid with random concentrations
for x=1:grid_width
    for y=1:grid_height
        a(x,y,p) = rand();
        b(x,y,p) = rand();
        c(x,y,p) = rand();
    end;
end;

%% Iterate and Plot
figure;
for t=1:itime
    grid = zeros(grid_width, grid_height);
    
    for x=0:grid_width-1
        for y=0:grid_height-1
            
            c_a = 0;
            c_b = 0;
            c_c = 0;

            for i=x-1:x+1
                for j=y-1:y+1
                    c_a = c_a+a(mod(i+grid_width, grid_width)+1, mod(j+grid_height,grid_height)+1, p);
                    c_b = c_b+b(mod(i+grid_width, grid_width)+1, mod(j+grid_height,grid_height)+1, p);
                    c_c = c_c+c(mod(i+grid_width, grid_width)+1, mod(j+grid_height,grid_height)+1, p);
                end
            end

            c_a = c_a/9.0;
            c_b = c_b/9.0;
            c_c = c_c/9.0;

            a(x+1,y+1,q) = (c_a + (c_a*(alpha*c_b - gamma*c_c)));
            b(x+1,y+1,q) = (c_b + (c_b*(gamma*c_c - beta*c_a)));
            c(x+1,y+1,q) = (c_c + (c_c*(beta*c_a - alpha*c_b)));
            
            if a(x+1,y+1,q) < .001 
                a(x+1,y+1,q) = .001; 
            end
            if (a(x+1,y+1,q) > 255)
                a(x+1,y+1,q) = 255;
            end
            
             if b(x+1,y+1,q) < .001 
                b(x+1,y+1,q) = .001; 
            end
            if b(x+1,y+1,q) > 255
                b(x+1,y+1,q) = 255;
            end
          
            if c(x+1,y+1,q) < .001 
                c(x+1,y+1,q) = .001; 
            end
            
            if c(x+1,y+1,q) > 255
                c(x+1,y+1,q) = 255;
            end
            

            grid(x+1,y+1) = round(a(x+1,y+1,q));
        end
    end

    image(grid);
    drawnow;
    
    if p == 1
        p = 2; 
        q = 1;
    else
        p = 1;
        q = 2;
    end
    
end;
