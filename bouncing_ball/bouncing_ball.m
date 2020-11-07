clc; close all; clear all
fprintf('Hello');
% define your parameters 
g = 9.816; % m/s^2 the acceleration due to gravity

% % Define our system matrices
A = [0 1; 0 0]; B = [0;-g]
Y = [1 0];

% simulation parameters
dt = 0.2;
tf = 50; 
t = 0:dt:tf;
dtsim=t(2) - t(1); % any two intervals
Nsteps = length(t)

% predictor ICs 
% x - [height, vertical velocity]
% x = zeros(tf/dt, 2)

x=[1000; 0];
xp=[1000 0];
ICs = xp(1,:);
horizontal_line = zeros(length(t))
% 5 second simulation
% X=[]; Yp=[];
% for every time step there is computation
integral.breaktime = 100000000;
euler.breaktime = 100000000;
euler.landed = 0;
integral.landed = 0;
for ii=1:Nsteps - 1
    %  x1_0 x1_1 ... x1_N
    %  x2_0 x1_1 ...x2_N
    x(:, ii+1) = x(:,ii)+dt.*A*x(:,ii) + B
% %     % X = [X,x]; T = [T;t];
% %     % compute your state: (which is usuallu done by the sensor)
% %     % using eulers method
% %     % integrate over the 
    tspan = [t(ii), t(ii+1)];
%     % integrate over the time step
    [Tp, Yp] = ode45(@(t,y) mode1(t, xp(ii,:)), tspan, ICs, []);

%     % update our ICs
    ICs = Yp(end,:)
    % size(ICs);
    
%   % store your state
    xp(ii+1,:) = ICs';

    if x(1,ii)<=0 && euler.landed==0
        euler.breaktime = ii;
        euler.landed = 1;
        % break
    end

    if xp(ii,1)<=0 && integral.landed==0
        integral.breaktime = ii;
        integral.landed = 1;
        % break
    end
     
end;

% euler
plot(t,x(1,:))
fprintf(" EULER -- WHEN YOU HIT THE GROUND %04.d seconds ",t(euler.breaktime))
hold on
% numerical integral
plot(t,xp(:,1))
fprintf(" INTEGRAL -- WHEN YOU HIT THE GROUND %04.d seconds ",t(72))
% format short

% hold on
% plot(t,x(2,:))
axis([0 50 -1 1000]);

legend('vel (m/s) -- euler', 'vel (m/s) height (m)--numerical integration')
% saveas(gcf,'./figs/together_now.png')



