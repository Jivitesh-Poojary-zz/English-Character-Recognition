%% Character Recognition Example (III):Training a Simple NN for
%% classification

%% Read the image
I = imread('Machine_train.png');
%I=imread('Hand_train.png');

%% Image Preprocessing
[img ,num,space]= edu_imgpreprocess(I);
for cnt = 1:num
    bw2 = edu_imgcrop(img{cnt});
    charvec = edu_imgresize(bw2);
    out(:,cnt) = charvec;
end

%% Create Vectors for the components (objects) 
%% The front 4 rows will be used to train the network, 
%% while the last row will be used to evaluate the performance of the network
P = out(:,1:(num/10)*9); 
T = [eye(62) eye(62) eye(62) eye(62)  eye(62) eye(62) eye(62) eye(62) eye(62)];
%T='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
%T=[T T T T T T T T T];
% T='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
% T=double(T);
% T=T';
% T=de2bi(T,'left-msb');
% X = zeros(52,3);
% T=[X T];
% T=T';
% T=[T eye(10)];
% T=[T T T T];
Ptest = out(:,(num/10)*9+1:num);

%% Creating and training of the Neural Network
net = edu_createnn(P,T);
%load net.mat;
% for i=1:3
%     [net,tr] = train(net,P,T);
% end
%save net net;
%% Testing the Neural Network
[a,b]=max(sim(net,Ptest));
% switch(b)
%         case 1
%           mat(1,cnt)='A';
%         case 2
%           mat(1,cnt)='B';
%         case 3
%           mat(1,cnt)='C';
%         case 4
%           mat(1,cnt)='D';
%         case 5
%           mat(1,cnt)='E';
%         case 6
%           mat(1,cnt)='F';
%         case 7
%           mat(1,cnt)='G';
%         case 8
%           mat(1,cnt)='H';
%         case 9
%           mat(1,cnt)='I';
%         case 10
%           mat(1,cnt)='J';
%         case 11
%           mat(1,cnt)='K';
%         case 12
%           mat(1,cnt)='L';
%         case 13
%           mat(1,cnt)='M';
%         case 14
%           mat(1,cnt)='N';
%         case 15
%           mat(1,cnt)='O';
%         case 16
%           mat(1,cnt)='P';
%         case 17
%           mat(1,cnt)='Q';
%         case 18
%           mat(1,cnt)='R';
%         case 19
%           mat(1,cnt)='S';
%         case 20
%           mat(1,cnt)='T';
%         case 21
%           mat(1,cnt)='U';
%         case 22
%           mat(1,cnt)='V';
%         case 23
%           mat(1,cnt)='W';
%         case 24
%           mat(1,cnt)='X';
%         case 25
%           mat(1,cnt)='Y';
%         case 26
%           mat(1,cnt)='Z';
%     end
% a=sim(net,Ptest);
% a = im2bw(a,0.5);
% a=a';
% b = bi2de(a,'left-msb');
% b=char(b);
% b=b';
disp(b);


