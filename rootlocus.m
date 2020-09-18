% root locus analysis
% controller root locus
sys1 = tf(1,[1 0.01 0.2]);
rlocus(sys1)

% no energy system (x0,v0) = (0,0)
sys1 = tf([0 0 1],[1 0.01 0.2]);

% save matlab figure
% savefig('./figs/ideal_step_response.png')

