Pm = P0;
for i = 1:1000
 % measurement step
 S = C*Pm*C' + R;
 K = Pm*C'*inv(S);
 Pp = Pm - K*C*Pm;
 % prediction step
 Pm = A*Pp*A' + Q;
end