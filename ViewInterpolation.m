% parameters
interp = 0.5;   % interpolation factor of 0.5 should give a virtual view exactly at the center of line connecting both the cameras. can vary from 0 (left view) to 1 (right view)

% read in images and disparity maps
i1 = imread('Data\view1.png');           % left view
i2 = imread('Data\view5.png');           % right view
d1 = abs(double(imread('Data\disp1.png')));   % left disparity map, 0-255
d2 = abs(double(imread('Data\disp5.png')));   % right disparity map, 0-255

%i1=rgb2gray(i1);
%i2=rgb2gray(i2);
%d1=cell2mat(d1);
%d2=cell2mat(d2);
% tag bad depth values with NaNs
%d1(d1==0) = NaN;
%d2(d2==0) = NaN;

i3=uint8(zeros(size(i1)));

i4=uint8(zeros(size(i1)));

i5=uint8(zeros(size(i1)));
[a,b]=size(d1);

for i=1:a
    for j=1:b
        d1(i,j)=ceil(d1(i,j)/2);
    end
end
% for i=1:a
%     for j=1:b
%         d2(i,j)=ceil(d2(i,j)/2);
%     end
% end
for i=1:a
    for j=1:b
       if((j-d1(i,j))<1)
             i3(i,1,:)=i1(i,j,:);
             
        %i3(i,y,:)=i1(i,j,:);
        %i3(i,j,:)=i2(i,j,:);
        else
           i3(i,j-d1(i,j),:)=i1(i,j,:);
        end
    end
end
i3(isnan(i3))=0;
i4=i2;
for i=1:a
    for j=1:b
       
             
        if((j-d1(i,j))<1)
         i4(i,1,:)=NaN;
         %i3(i,j,:)=i2(i,j,:);
         else
            i4(i,j-d1(i,j),:)=NaN;
        % i3(i,j,:)=i2(i,j,:);
       end
    end
end
% 
 i4(isnan(i4))=0;
i5=(i3+i4);
 %figure,imshow(i3);
 %figure,imshow(i4(Q));
% temp(i4(Q));
% i4=double(i4);
%  %i3(i3==i3(Q))=i4(Q);
% i3=i3+i4(Q);
 %disp(Q);
% for i=1:a
%     for j=1:b
%    
%           
%     end
% end
%i2=circshift(i2,[4 5]);
%i5=double(i5);
%figure,imshow(i3);
%figure,imshow(i4);
figure,imshow(i5);


%MSE

Disp1 = imread('Data/view3.png');
i5=double(i5);
Disp1=double(Disp1);

Disp2=double(Disp2);
[m,n]=size(Disp1);
% A=(D1-Disp1);
% A=A.^2;
a1=sum(sum((i5-Disp1).^2));
a1=a1/(m*n);
disp(a1);

















