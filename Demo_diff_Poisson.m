clc;clear;close all;
addpath '...\image\';

imgID = 1; 

Img = imread([num2str(imgID),'.bmp']); 
Img1 = Img;
c0 = 1;initialLSF = ones(size(Img(:,:,1))).*c0;
t=-1;alfa=3.5;iterNum=200;k=5;d=5;T=10;omga=5;
initialLSF(87:102,65:85) = -c0 ;
    
Img = double(Img(:,:,1));
figure;imagesc(Img);colormap(gray);hold on;axis off; axis equal;title('Image')
%% parameter setting
timestep = 1;           
epsilon = 1;            
K = fspecial('average', [k k]);        

%******** Edge differential fitting function **************
se = strel('disk',d);           
f1 = imdilate(Img,se);          
f2 = imerode(Img,se);           
e = (abs(Img-f1)-abs(Img-f2));
figure;imagesc(e);colormap(gray);hold on;axis off; axis equal;title('e')
G=fspecial('gaussian',[9 9],1);         
Img_gao=imfilter(Img,G,'replicate');    
[Ix,Iy]=gradient(Img_gao);              
f=Ix.^2+Iy.^2;                          
tau = std2(Img);       
g = (2/pi)*atan(f/tau);              


eP = e.*Poisson(e,T);   
figure;imagesc(eP);colormap(gray);hold on;axis off; axis equal;title('ePoisson')

eD = zeros(size(Img)); 
eD = 0.05*((1-g).*(eD-0)-g.*(eD-omga*eP));

u = initialLSF;
figure;imagesc(Img1, [0, 255]);colormap(gray);hold on;axis off; axis equal;

tic
for n = 1:iterNum
    u1 = u;                                     
    DrcU = (epsilon/pi)./(epsilon^2.+u.^2);     
	eD=eD+0.01*((1-g).*(eD-0)-g.*(eD-omga*eP)); 
    eForce = -t*alfa*atan(eD/tau);              
    u = u + timestep*eForce.*DrcU;              
    u = tanh(5*u);                          
    u = imfilter(u,K,'replicate');          
    
     if mod(n,10) == 0    
        hold on;contour(u,[0 0],'c'); axis off,axis equal
        title([num2str(n),'  iterations']);pause(0.001);
     end
     
     if abs(u - u1) < 0.01        
        break  
     end

end
time = toc;

figure;imagesc(eD);colormap(gray);hold on;axis off; axis equal;title('µü´úÓÅ»¯');
figure;imagesc(Img1, [0, 255]);colormap(gray);hold on;axis off; axis equal;
contour(u,[0 0],'r','linewidth',2);
contour(initialLSF,[0 0],'g','linewidth',2);
str=['T=' num2str(time) ', N=' num2str(n)];title(str);


function y = Poisson(x,T)
	et = x/T;
	y = (et.^2-log(1+exp(et.^2))+log(2));
end

