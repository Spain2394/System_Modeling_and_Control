function [Xest, Pxy] = kalman(Xmes, X)
    % input: Xmes = position and velocity measurements
        
    % step 1: initialization 
    % sensor noise variance
    R = [1e-4 0; 0 1e-5];

    % state estimation variance
    Pm = [1e-2 * randn(1) 0; 0 1e-2 * randn(1)];

    % Pxy = [Pm]
    % Pxy = reshape(Pm.', 1,[])
    Pxy = Pm;

    % covariance matrix for state estimation 
    Cs = [1 0; 0 1]; 

    % process variance
    Q = [0 0; 0 0];

    % filter will be the size of the measurement
    % variable number and measurement number (mesn)
    [varn, mesn] = size(Xmes);

    % state transition matrix
    A = [0 1; -0.2 -0.01]; 

    % estimate
    s = [0, 0]

    % % construct the kalman filter
    % % all of the position data
    for i=2:mesn
    
        % step 1: combined error
        S = Cs * Pm * Cs' + R;        % 2x2     

        % % step 1: prediction
        K = Pm * Cs' * inv(S);         % 2x2     

        % % prior state covariance  
        Pp = Pm - K*Cs*Pm;           % 2x2 

        % % step 2: update
        % % steps assume no process noise
        Xest(i,:) = s' + K * (Xmes(:, i) - Cs * s');
        s = X(i,:)
        % Xest = newest estiamte 
        % s = A*x(t) + Bu(t): previous estimat 
        % % posterior state covriance
        % very little change
        Pm = A * Pp * A' + Q

        % save your covariance matrix
        Pxy = [Pxy; Pm]

    end   
    
end