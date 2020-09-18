function Xdot=get_states(t, X, tdelay, F);
    k=0.2;b=0.01;m=1;
    td = tdelay; 
    u = F;    
    % u=sin(w*t);
    Xdot(1,1)=X(2);
    Xdot(2,1)=-(k/m)*X(1)-(b/m)*X(2)+(1/m)*u;
end