clc; clear all


% input 
F = 1
% time... 
time = 500;
dt = 1;

t = 1:dt:time;
tdelay = 3;

% display variables
sim = true;

% estimated covariance 
Pxy = [1e-4 0; 0 1e-6];

% state: inital conditions x= 0, x_dot = 0
X(1)=0; X(2)=0;

% measurement values
Xmes(1)=0; Xmes(2)=0;

% Initialize X estimation matrix
Xest(1)=0; Xest(2)=0;

% spring-mass damper system output
[t,X]=ode45('get_states', t, X, tdelay, F);

% measured velocity, and position
Xmes = sense(t, X(:,1), X(:,2));

% kalman filter state estimate
[Xest, Pxy] = kalman(Xmes, X);

% Xest
% plot(Xest)

%  plot setup 
%  COLORS:
% 'red'	'r'	[1 0 0]	'#FF0000'	
% 'green'	'g'	[0 1 0]	'#00FF00'	
% 'blue'	'b'	[0 0 1]	'#0000FF'	
% 'cyan'	'c'	[0 1 1]	'#00FFFF'	
% 'magenta'	'm'	[1 0 1]	'#FF00FF'	
% 'yellow'	'y'	[1 1 0]	'#FFFF00'	
% 'black'	'k'	[0 0 0]	'#000000'	
% 'white'	'w'	[1 1 1]	'#FFFFFF'	
% 'none'

if sim == true
    clf(gcf);

    % plot true state
    % subplot(2,1,1);
    px = plot(t,X(:,1));
    hold on
    pv = plot(t,X(:,2));
    px.Color = 'magenta'
    pv.Color = 'magenta'
    legend('postion (m)', 'velocity ')
    
    % plot measurements
    pMx = plot(t,Xmes(1,:)); 
    pMv = plot(t,Xmes(2,:)); 
    pMx.Color = 'r'
    pMv.Color = 'r'
    
    % plot kalman estimate
    pEx = plot(t,Xest(:,1)); 
    pEv = plot(t,Xest(:,2)); 
    pEx.Color = 'black'
    pEv.Color = 'black'
    pEx.LineStyle = '--';
    pEv.LineStyle = '--';

    ylabel('Amplitude');
    xlabel('time(s)'); 
    legend('position (m)', 'velocity (m/s)', 'position measured (m/s)', 'vel measured (m/s)', 'kalman pose estimate (m)', 'kalman vel estimate (m)');
    title('Velocity drift');

    % subplot(2,1,2);
    % pErrx = plot(abs(Xest(:,1) - X(1,:))); 
    % hold on
    % A = Xest(:,1) - X(1,:)

    % plot(A);
    % pErrx.Color = 'black'
    % pErrv.Color = 'red'
    % ylabel('Amplitude')
    % xlabel('time(s)'); 
    % legend('abs position error (m)', 'abs vel error (m/s)');
    % title('Error')
    % axis([0 time -2 10]);
    
    saveas(gcf, './figs/demo.png');
end
