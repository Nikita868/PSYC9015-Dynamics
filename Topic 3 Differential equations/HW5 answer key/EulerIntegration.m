dt = 0.01

time = dt:dt:5

x(1) = 0.5

for i = 1:length(time)-1
    
    x(i+1) = x(i) + 2*x(i)*dt;
    
end

help close 
help figure
help hold


figure
plot(time,x,'.-')