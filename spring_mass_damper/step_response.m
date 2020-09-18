% Take a look at the affect of the damping ratios

m = 1;        % mass (kg)
k = 0.2;      % spring constant (N/m)
b =  0.01;    % damper (viscious friction) (Ns/m)

wn = sqrt(k/m);
dam = b/(2*sqrt(k*m));

% vary damping 
for d=0:0.5:1
    sys = tf(1,[1 2*d*wn wn^2]);
    step(sys,100);
end 

saveas(gcf, './figs/damping_step_response.png')    
