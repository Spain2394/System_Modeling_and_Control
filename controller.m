% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% % Controller for spring-mass-damper
% % Allen Spain
% % 09/16/2020
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

clc; clear all;
m = 1;        % mass (kg)
k = 0.2;      % spring constant (N/m)
b =  0.01;    % damper (viscious friction) (Ns/m)
F = 1;        % force applied (N)
time = 500;  % simulation time (s) 
% x = 0         % initial conditions
% x_dot = 0     % initial velocity

% % system variable
% % state space representation X' = AX + Bu, y = CX
% % X = [x, x_dot]
% % X' = [x_dot, x_ddot]
% % A (plant), B(actuators), C(sensors)
% % A - laws of phyics
% % B - how the input affects the state
% % C - encodes sensor information

% model parameters  
A = [0 1; -k/m -b/m]; 
X = [0 0]'
B = [0 1/m]';
C = [1 0; 0 1];

% time... 
time = 500;
dt = 1;
ti = 0:dt:time;

% defined within the time window

u = zeros(time,1);              % control command
y = zeros(time,2);              % output variable 

% estimated variables
xe = zeros(time,1);             % pose estimate
xe_dot = zeros(time,1);         % velocity estimate
xe_ddot = zeros(time,1);

% ground truth variables
x = zeros(time,1);              % pose ground truth
x_dot = zeros(time,1);          % velocity ground truth
x_ddot = zeros(time,1);          % velocity ground truth

% simulation and display settings
simu = true;

% mass estimated state and true state 

% time step = 1 default
for t=2:dt:time
    % step function
    if t > 10
        u(t+1) = F*1;
    else
        u(t+1) = 0
    end

    % X = [x(t), x_dot(t)]';
    % X_dot = [x_dot(t), x_ddot(t)]';

    % if t == 1
    x(1) = 0 
    x_dot(1) = 0
    x_ddot(1) = 0
    % end
    % X_dot = A*[x(t-1), x_dot(t-1)]' + B * u(t); % x(1) = 0, x_dot(2) = Ax(1) + Bu(2)
    y(i) = k*y(i) + (y(i)-y(i-1))/(d*delta_t) +((y(i)-y(i-1))-(y(i-2)-y(i-3)))/delta_t 
    % x_dot(t) = x(t-1)
    % x(t) = x(t-1) + X_dot(1)*dt + (1/2 * (X_dot(2) * dt));
    % x_dot(t) = X_dot(2)
    % x(t) = x(1) + x_dot(t)*dt
    
end 

if simu == true
    clf('reset')
    fprintf('Plotting...\n');
    % subplot(2,1,1);
    plot(x);
    % hold on % don't append a figure object

    % plot(ti, x_dot), ylabel('velocity');

    % subplot(2,1,2);
    % plot(ti, u), ylabel('control input')

    legend('position (m)', 'velocity (m/s)', 'control input (N)')
    axis([0 time 0 10])
    saveas(gcf, './figs/position_control.png')    
else
    fprintf('Done...\n');
end




