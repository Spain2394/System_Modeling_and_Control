function [Xest, Pxy] = kalman(Xmes, X)
    % input: state measurements Xmes = [x, x_dot]
    % output: estimated state Xest = [x,x_dot], and estimation covariance
    
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

    % varn = num states
    [varn, mesn] = size(Xmes);

    % state transition matrix
    A = [0 1; -0.2 -0.01]; 

    % estimate
    s = [0, 0]

    % @TODO select process noise
    % construct the kalman filter
    for i=2:mesn
    
        % error term
        S = Cs * Pm * Cs' + R;          % 2x2     

        % step 2: prediction
        K = Pm * Cs' * inv(S);          % 2x2     

        % prior state covariance  
        Pp = Pm - K*Cs*Pm;              % 2x2 

        % step 3: update
        % steps assume no process noise
        Xest(i,:) = s' + K * (Xmes(:, i) - Cs * s');

        % s = A*x(t) + Bu(t): or using real values
        s = X(i,:)

        % very little change
        Pm = A * Pp * A' + Q

        % store covariance matrix
        Pxy = [Pxy; Pm]

    end   
    
end