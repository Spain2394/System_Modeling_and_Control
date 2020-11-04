clc; clear all;

% System matrices
A = 2; B = 1;

% Quasi gain scheduling 
k = 5; K = [1,2,3,5];

% setup ICs
x=[1,1,1,1]'; t=0; tf = 1; dt = 0.1;
X=[]; T=[];

% compute your state
while(t<tf)
    X=[X,x]; T = [T;t];
    x=x+dt.*(A-K').*x
    t=t+dt;
end

% % plot data
% lgnd = createLegend(K)
% % [x1,x2,x3]
% % X(1,:) -- [x1_0.....x1_n]
% % X(2,:) -- [x1_0.....x1_n]
% % X(3,:) -- [x1_0.....x1_n]
lgnd = createLegend('k=', [1;2;3;5])
plot(T, X);  
hold on;

title("Simple system!")
legend(lgnd)
xlabel('time(s)')
ylabel('State')
saveas(gcf, './figs/state-feedback2.png')