clc; clear all;
% original values
m = 1;  % 1 kg
c = 12; % 12 N-s/m
k = 20; % 20 N/m

% my values
% m = 1;        % mass (kg)
% k = 0.2;      % spring constant (N/m)
% b =  0.01;    % damper (viscious friction) (Ns/m)
% c = b;

time = 500;
% Open-Loop Response
s = tf('s');
P = 1/(m*s^2 + c*s + k) % Transfer function
% opt = stepDataOptions('InputOffset',-1,'StepAmplitude',2);
% step(P,500); ylabel('position(m)')
% C1  = pid(Kp,0,0)
% T1   = feedback(C1*P,1) % Transfer function with P-only controller

[y,t] = step(P)
p = plot(t, y);xlabel('time (s)')
p.Color = 'b';
legend('position (m)');

% legend('position (m)');
% axis([0 time 0 10]);
% saveas(gcf, './figs/ideal_step_resp2.png');



% % PID Control Values 
% Kp = 200;
% Kd = 10;
% Ki = 70;
% % Time-step 0.01 s
% t  = 0:0.01:5;
% hold on
% % Only Proportional Control
% C1  = pid(Kp,0,0)
% T1   = feedback(C1*P,1) % Transfer function with P-only controller
% step(T1,t)
% % Only Integral Control
% C2  = pid(0,Ki,0)
% T2   = feedback(C2*P,1) % Transfer function with P-only controller
% step(T2,t)
% % Only Derivative Control
% C3  = pid(0,0,Kd)
% T3   = feedback(C3*P,1) % Transfer function with P-only controller
% step(T3,t)
% % Proportional-Derivative Control
% C4  = pid(Kp,0,Kd)
% T4  = feedback(C4*P,1)
% step(T4,t)
% % Proportional-Integral Control
% C5  = pid(Kp,Ki,0)
% T5  = feedback(C5*P,1)
% step(T5,t)
% % Proportional-Integral-Derivative Control
% C6  = pid(Kp,Ki,Kd)
% T6  = feedback(C6*P,1)
% step(T6,t)
% legend('P only Control','I only Control','D only Control','PD Control','PI Control','PID Control')