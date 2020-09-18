% root locus analysis

% controller root locus
% sys1 = tf(1,[1 0.01 0.2]);
% % rlocus(sys1)
% % step response
% a = step(sys1)

% % % no energy system (x0,v0) = (0,0)
% % sys1 = tf([0 0 1],[1 0.01 0.2]);
% % rlocus(sys1)

% % save matlab figure
% % savefig('./figs/ideal_step_response.png')

m = 1;        % mass (kg)
k = 0.2;      % spring constant (N/m)
b =  0.01;    % damper (viscious friction) (Ns/m)

wn = sqrt(k/m);
dam = b/(2*sqrt(k*m));

hold on;
for d=0:0.5:1
    sys = tf(1,[1 2*d*wn wn^2]);
    step(sys,100);
    % set(get(gca, 'XLabel', 'String', '');
end 
saveas(gcf, './figs/damping_step_response.png')    

clf(gcf)
sys2 = tf(1,[m b k]);
step(sys2,100);

% xlabel('time(s)');
saveas(gcf, './figs/current_step_response.png')    
