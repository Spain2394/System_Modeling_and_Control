% spring-mass-damper root locus from transfer function sys
% controller root locus

% no energy system @ (x0,v0) = (0,0)
sys = tf(1,[1 0.01 0.2]);
rlocus(sys)
savefig('./figs/ideal_step_response.png')

