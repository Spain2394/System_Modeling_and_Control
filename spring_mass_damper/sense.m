function Xmes = sense(t, xgt, vgt)

    % variance = sigma^2 
    % randn returns a random scalar drawn from the standard normal distribution

    a = 1
    b = 1
    xsig = 0.01 * a                     % 0.01 m for position and m/s for velocity
    vsig = 0.01/1000 * b                % 0.1 mm/s
    mu = 1/1000 * randn(1)          % 1 mm/s velocity drift normal dist
    fprintf("drift =  %d", mu)
    C = [1 0; 0 1]; % sensor mapping properties
    
    M = ones(length(t),2);
    fprintf("size before:")
    M(1,1)=0; M(1,2)=0;
    for i=2:length(t) - 1
        M(i,1) = xgt(i) + xsig * randn(1);
        M(i,2) = vgt(i) + mu + vsig * randn(1);
    end    
    % Xmes = C * [xgt vgt]';
    Xmes = M'
    
end