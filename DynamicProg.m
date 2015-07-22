
%Write a script that processes stereo image pair to generate disparity map
%using dynamic programming
tic;

I1 = imread('Data/view1.png');
I2 = imread('Data/view5.png');

I1=mean(I1,3);
I2=mean(I2,3);
[m,n]=size(I2);

A=zeros(n,n);
DP_Matrix=zeros(n,n,m);
% for i=1:n
%     for j=1:n
%         A(i,j)=0;
%     end
% end

Minimum=0;
for y=1:m 
for i=1:n
    for j=1:n
        a1=DP_Matrix(max(1,i-1),j,y);
        a2=DP_Matrix(i,max(1,j-1),y);
        a3=DP_Matrix(max(1,i-1),max(1,j-1),y);
        Minimum=min([a1,a2,a3]);
        
            cl=I1(y,i);
            cr=I2(y,j);
            DP_Matrix(i,j,y)=Minimum+abs(cr-cl);
        end
end
 %figure,imagesc(A);  

end
%disp(DP_Matrix);

D1=zeros(m,n);
D2=zeros(m,n);

for y=1:m
    i=n;j=n;

  while (i~=1&&j~=1)
            
           %
             c1=DP_Matrix(max(1,i-1),j,y);
             c2=DP_Matrix(i,max(1,j-1),y);
            c3=DP_Matrix(max(1,i-1),max(1,j-1),y);
          
        m=min([c1,c2,c3]);
            
            if(m==c1)
                i=i-1;
 
            else if(m==c2)
                   j=j-1;
                else if (m==c3)
                        i=i-1;
                         j=j-1;
                    else 
                         i=i-1;
                j=j-1;
                    end
                end
            end
            D1(y,i)=i-j;
             D2(y,j)=abs(i-j);
end
end
  figure,imshow(D1,[0,70]);
  figure,imshow(D2,[0,70]);
 
  
 %MSE 

Disp1 = imread('Data/disp1.png');
Disp2 = imread('Data/disp5.png');
D1=double(D1);
D2=double(D2);
Disp1=double(Disp1);

Disp2=double(Disp2);
[m,n]=size(Disp1);
% A=(D1-Disp1);
% A=A.^2;
a1=sum(sum((D1-Disp1).^2));
a1=a1/(m*n);
disp(a1);

a2=sum(sum((D2-Disp2).^2));
a2=a2/(m*n);
disp(a2);

toc;

