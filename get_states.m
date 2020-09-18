function Xdot=get_states(t, X, tdelay, F);
    % k - spring constant (Nm), b - damper (viscious friction) (Ns/m), m - mass (kg)
    k=0.2;b=0.01;m=1;

    % step response
    u = F;

    Xdot(1,1)=X(2);

    % compute spring mass using Ax + Bu
    Xdot(2,1)=-(k/m)*X(1)-(b/m)*X(2)+(1/m)*u;
end