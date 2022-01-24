% Model 1
x(1) = .6; % initial condition
R = -1; % R parameter
N = 50; % number of iterations

for i = 1:N
    x(i+1) = R*x(i);
end
% figure
hold on
plot(x,'o-')
xlabel('t')
ylabel('x')
grid on
set(gca,'FontSize',20)


% Model 2: Logistic map
x(1) = .6;
R = 1

for i = 1:40
    x(i+1) = R*x(i)*(1-x(i));
end

figure
hold on
plot(x,'o-')
xlabel('t')
ylabel('x')
grid on
set(gca,'FontSize',20)

