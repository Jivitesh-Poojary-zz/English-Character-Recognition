I = imread('Hand_test.png');
%I = imread('Machine_test.png');
figure,imshow(I)

Igray = rgb2gray(I);

Ibw = im2bw(Igray,graythresh(Igray));

Iedge = edge(uint8(Ibw));

se = strel('square',3);

Iedge2 = imdilate(Iedge, se); 

Ifill = imfill(Iedge2,'holes');

[Ilabel num] = bwlabel(Ifill);

Iprops = regionprops(Ilabel);

Ibox = [Iprops.BoundingBox];
Ibox = reshape(Ibox,[4 num]);

Ic = [Iprops.Centroid];
Ic = reshape(Ic,[2 num]);
%Ic = Ic';
%Ic(:,3) = (mean(Ic.^2,2)).^(1/2);
%Ic(:,4) = 1:num;
[m ,n]=size(Ilabel);
cntB=1;
j=1;
flag=0;
fid=fopen('abc.txt','wt');
while 1
    mat=' ';
while (sum(Ilabel(cntB,:))==0)
    cntB=cntB+1;
    if(cntB==m)
       flag=1;
       break;
    end
end
if flag==1
   break; 
end
y1=cntB;
while (sum(Ilabel(cntB,:))~=0)
    cntB=cntB+1;
end
y2=cntB;

% % Extra lines compare to example2 to extract all the components into an
% % cell array
%Ic2 = sortrows(Ic,2);
% 
% for cnt = 1:10
%     Ic2((cnt-1)*(num/10)+1:cnt*(num/10),:) = sortrows(Ic2((cnt-1)*(num/10)+1:cnt*(num/10),:),4);
% end
%
j=1;
z=0;
for i=1:num
if Ic(2,i)>=y1 && Ic(2,i)<=y2
    z(1,j)=i;
    j=j+1;
end
end

% Ic3 = Ic2(:,1:2);
%ind = Ic2(:,4);

for cnt = 1:j-1
    img{cnt} = imcrop(Ibw,Ibox(:,z(cnt))); %Ibw OR Ifill
end

for cnt = 1:j-1
    bw2 = edu_imgcrop(img{cnt});
    charvec = edu_imgresize(bw2);
    
    a=sim(net,charvec);
    a = im2bw(a,0.5);
    a=a';
    b = bi2de(a,'left-msb');
    b=char(b);
    mat(1,cnt)=b;
%     switch(b)
%         case 1
%           mat(1,cnt)='0';
%         case 2
%           mat(1,cnt)='1';
%         case 3
%           mat(1,cnt)='2';
%         case 4
%           mat(1,cnt)='3';
%         case 5
%           mat(1,cnt)='4';
%         case 6
%           mat(1,cnt)='5';
%         case 7
%           mat(1,cnt)='6';
%         case 8
%           mat(1,cnt)='7';
%         case 9
%           mat(1,cnt)='8';
%         case 10
%           mat(1,cnt)='9';
%         case 11
%           mat(1,cnt)='A';
%         case 12
%           mat(1,cnt)='B';
%         case 13
%           mat(1,cnt)='C';
%         case 14
%           mat(1,cnt)='D';
%         case 15
%           mat(1,cnt)='E';
%         case 16
%           mat(1,cnt)='F';
%         case 17
%           mat(1,cnt)='G';
%         case 18
%           mat(1,cnt)='H';
%         case 19
%           mat(1,cnt)='I';
%         case 20
%           mat(1,cnt)='J';
%         case 21
%           mat(1,cnt)='K';
%         case 22
%           mat(1,cnt)='L';
%         case 23
%           mat(1,cnt)='M';
%         case 24
%           mat(1,cnt)='N';
%         case 25
%           mat(1,cnt)='O';
%         case 26
%           mat(1,cnt)='P';
%         case 27
%           mat(1,cnt)='Q';
%         case 28
%           mat(1,cnt)='R';
%         case 29
%           mat(1,cnt)='S';
%         case 30
%           mat(1,cnt)='T';
%         case 31
%           mat(1,cnt)='U';
%         case 32
%           mat(1,cnt)='V';
%         case 33
%           mat(1,cnt)='W';
%         case 34
%           mat(1,cnt)='X';
%         case 35
%           mat(1,cnt)='Y';
%         case 36
%           mat(1,cnt)='Z';
%         case 37
%           mat(1,cnt)='a';
%         case 38
%           mat(1,cnt)='b';
%         case 39
%           mat(1,cnt)='c';
%         case 40
%           mat(1,cnt)='d';
%         case 41
%           mat(1,cnt)='e';
%         case 42
%           mat(1,cnt)='f';
%         case 43
%           mat(1,cnt)='g';
%         case 44
%           mat(1,cnt)='h';
%         case 45
%           mat(1,cnt)='i';
%         case 46
%           mat(1,cnt)='j';
%         case 47
%           mat(1,cnt)='k';
%         case 48
%           mat(1,cnt)='l';
%         case 49
%           mat(1,cnt)='m';
%         case 50
%           mat(1,cnt)='n';
%         case 51
%           mat(1,cnt)='o';
%         case 52
%           mat(1,cnt)='p';
%         case 53
%           mat(1,cnt)='q';
%         case 54
%           mat(1,cnt)='r';
%         case 55
%           mat(1,cnt)='s';
%         case 56
%           mat(1,cnt)='t';
%         case 57
%           mat(1,cnt)='u';
%         case 58
%           mat(1,cnt)='v';
%         case 59
%           mat(1,cnt)='w';
%         case 60
%           mat(1,cnt)='x';
%         case 61
%           mat(1,cnt)='y';
%         case 62
%           mat(1,cnt)='z';
%     end
    
    fprintf(fid,mat(1,cnt));
    if cnt<(j-1) && Ic(1,z(1,cnt+1))-Ic(1,z(1,cnt))>(space*1.5) %Hand
    %if cnt<(j-1) && Ic(1,z(1,cnt+1))-Ic(1,z(1,cnt))>(space*2.5) %Machine
        fprintf(fid,char(32));
        fprintf(fid,char(32));
    end
end

%fprintf(fid,mat);
fprintf(fid,char(10));
end
winopen('abc.txt');
fclose(fid);
%disp(mat);