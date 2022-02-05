% Linear difference equation with an impulse input

x(1) = .6; % initial condition
R = .5; % R parameter
N = 50; % number of iterations

g = zeros(N,1);
g(25) = 0.4;

for i = 1:N
    x(i+1) = R*x(i)+g(i);
end

figure
hold on
plot(x,'o-')
plot(g,'.-')
xlabel('t')
ylabel('x')
grid on
set(gca,'FontSize',20)
legend('x_t','g(t)')