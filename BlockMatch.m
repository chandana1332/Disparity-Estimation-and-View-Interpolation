function BlockMatch()
tic;
I1 = imread('Data/view1.png');
I2 = imread('Data/view5.png');

I1 = im2double(rgb2gray(I1));
I2 =im2double(rgb2gray(I2));
% I1=rgb2gray(I1);
% I2=rgb2gray(I2);


D1=abs(Disp1(I1,I2));
% a1=max(D1);
% disp(a1);
D2=abs(Disp1(I2,I1));
figure,imshow(D1,[0,70]);
figure,imshow(D2,[0,70]);
%        end
%     end
% end
%            
% figure,imshow(D1,[0,70]);         
% 


 %consistency checking
 D3=zeros(size(D1));
 D4=zeros(size(D1));
 [a,b]=size(D1);
for i=1:a
    for j=1:b
       s1=D1(i,j);
       if(j+s1>b)
           s2=abs(D2(i,b));
       else
       s2=abs(D2(i,j+s1));
       end
       if(s1~=s2)
           D3(i,j)=NaN;
       else
           D3(i,j)=D1(i,j);
       end
    end
end
  figure,imshow(D3,[0,70]);         

  
  for i=1:a
    for j=1:b
       s1=D2(i,j);
       if(j-s1<1)
           s2=abs(D1(i,1));
       else
       s2=abs(D1(i,j-s1));
       end
       if(s1~=s2)
           D4(i,j)=NaN;
       else
           D4(i,j)=D2(i,j);
       end
    end
  end
  figure,imshow(D4,[0,70]);         

%MSE


 
Disp1 = imread('Data/disp1.png');
Disp2 = imread('Data/disp5.png');

Disp1=double(Disp1);
%disp(max(Disp1));
% % 
Disp2=double(Disp2);
[m,n]=size(Disp1);
% % 
a1=sum(sum((D1-Disp2).^2));
a1=a1/(m*n);


disp(a1);
a2=sum(sum((D2-Disp1).^2));
a2=a2/(m*n);
disp(a2);

  
  
  
  
%MSE for consistancy check

X=~(isnan(D3));
Y=~(isnan(D4));

b1=sum(sum((D3(X)-Disp2(X)).^2));
b1=b1/(m*n);


disp(b1);
b2=sum(sum((D4(Y)-Disp1(Y)).^2));
b2=b2/(m*n);
disp(b2);

toc;
end

%Disparity 

function [Disparity1]= Disp1(I1,I2)
left = I1;
right = I2;
%imshow(left);
%imshow(right);

%leftI=rgb2gray(left);
%rightI=rgb2gray(right);

Disparity = zeros(size(left));

disparityRange = 75;

bsize =7;
bsize=(bsize-1)/2;

[height,width] = size(left);

for m = 1 : height
      r1 = max(1, m - bsize);
    r2 = min(height, m + bsize);
	    for n = 1 : width
    		c1 = max(1, n - bsize);
        c2 = min(width, n + bsize);
    
        d1 = max(-disparityRange, 1 - c1);
        d2 = min(disparityRange, width - c2);
        b1 = right(r1:r2, c1:c2);
		
		s = d2 - d1 + 1;
		
		Diffs = zeros(s, 1);
		
		for i = d1 : d2
		
			b2 = left(r1:r2, (c1 + i):(c2 + i));
		
			Ind = i + 1;
            Index=Ind-d1;
            
		
			Diffs(Index, 1) = sum(sum((b1 - b2).^2));
        end
            
		[temp, si] = sort(Diffs);
		
		p = si(1, 1);
		
		d1 = p + d1 - 1;
			
	
			Disparity(m, n) = d1;
	
    end

end

Disparity1=Disparity;
%figure,imshow(Disparity1,[0,70]);

end







