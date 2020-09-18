clc; clear all


% spring mass damper parameters
m = 1;          % mass (kg)
k = 20;        % spring constant (N/m)
b =  12;      % damper (viscious friction) (Ns/m)
F = 1;          % force applied (N)

% time... 
time = 500;
dt = 1;

t = 1:dt:time;
tdelay = 3;

% display variables
sim = true;

% State: inital conditions x= 0, x_dot = 0
X(1)=0; X(2)=0;

% estimated states 
Xmes(1)=0; Xmes(2)=0;

% srping-mass damper system output
[t,X]=ode45('get_states', t, X, tdelay, F);

% estimated velocity 
Xmes = sense(t, X(:,1), X(:,2));

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
    % plot ground truth values
    px = plot(t,X(:,1));
    hold on
    pv = plot(t,X(:,2));
    px.Color = 'b'
    pv.Color = 'k'
    
    % plot measurements
    pMx = plot(t,Xmes(1,:)); 
    pMv = plot(t,Xmes(2,:)); 
    % r = plot(t,Xest(:,1));
    pMx.Color = 'm'
    pMv.Color = 'r'
    % r.Color = 'r'
    % r.LineStyle = '--'
    xlabel('time(s)'); 
    legend('position (m)','velocity (m/s)','position measured (m/s)','vel measured (m/s)');
    axis([0 time -2 10]);
    title('Velocity drift')
    saveas(gcf, './figs/sensing_3s.png');
end
