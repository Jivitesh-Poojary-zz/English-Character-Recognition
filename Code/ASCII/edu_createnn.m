function net = edu_createnn(P,T)

alphabet = P;
targets = T;

[R,Q] = size(alphabet);
[S2,Q] = size(targets);
S1 = 10;
%net = newff(minmax(alphabet),[S1 S2],{'logsig' 'logsig'},'traingdx');%%best
%net = newelm(minmax(alphabet),[S1 S2],{'logsig' 'logsig'},'traingdx');%%best
net= newfit(minmax(alphabet),[S1 S2],{'logsig' 'logsig'},'traingdx');%%best

%net = newfftd(minmax(alphabet),[0 1],[S1 S2],{'logsig' 'logsig'},'traingdx');%%poor
%net = newcf(minmax(alphabet),[S1 S2],{'logsig' 'logsig'},'traingdx');%%poor
%net = newdtdnn(minmax(alphabet),[S1 S2],{[0 1]},{'logsig' 'logsig'},'traingdx');%%error
%net = newlrn(minmax(alphabet),[S1 S2],{'logsig' 'logsig'},'traingdx');%%long time
%net = newnarx(minmax(alphabet),[0 1],[1 2],[S1 S2],{'logsig' 'logsig'},'traingdx');%%long time
%net = newp(alphabet,targets,'hardlim','learnp');%%error
%net = newpr(minmax(alphabet),[S1 S2],{'logsig' 'logsig'},'traingdx');%%poor
%%net = newff(alphabet,targets,[S1 S2],{'logsig' 'logsig'},'traingdx');
net.LW{2,1} = net.LW{2,1}*0.01;
net.b{2} = net.b{2}*0.01;
net.performFcn = 'sse';         
%% This property defines the parameters and values of the current training function.
net.trainParam.goal = 0.1;    
net.trainParam.show = 20;      
net.trainParam.epochs = 5000;  
net.trainParam.mc = 0.95;      
P = alphabet;
T = targets;
for i=1:3
    [net,tr] = train(net,P,T);
end