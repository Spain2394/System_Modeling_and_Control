function Xmes = sense(t, xgt, vgt)

    % sliders
    a = 1                       
    b = 1

    xsig = 0.01 * a                    % 0.01 m for position and m/s for velocity
    vsig = 0.01/1000 * b               % 0.1 mm/s
    mu = 1/1000 * randn(1)             % 1 mm/s velocity drift normal dist
    C = [1 0; 0 1];                    % sensor mapping

    % store position and velocity measurements
    M = ones(length(t),2);
    
    % generate random noise with std and drift
    M(1,1)=0; M(1,2)=0;
    for i=2:length(t) - 1
        M(i,1) = xgt(i) + xsig * randn(1);
        M(i,2) = vgt(i) + mu + vsig * randn(1);
    end    
    Xmes = M'
    
end