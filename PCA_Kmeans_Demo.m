
% Code for "Unsupervised Change Detection in 
% Satellite Images Using Principal Component
% Analysis and k-Means Clustering"
%
% <http://ieeexplore.ieee.org/document/5196726/>
% 
% Created on Thu Dec 7 2017, @author: rulixiang

clear;clc
close all
img_dir='./EROS_Data';
aa=dir(img_dir);

for k1=3:length(aa)
    img=aa(k1).name;
    disp(['Processing area-',img,' ...'])
    im1=imread([img_dir,'/',img,'/',img,'_1986.png']);
    im2=imread([img_dir,'/',img,'/',img,'_1992.png']);
    bm=imread([img_dir,'/',img,'/',img,'_change.png']);
    
    im1=rgb2gray(im1);
    im2=rgb2gray(im2);
    bm=rgb2gray(bm);

    figure
    subplot(121)
    imshow(im1)
    title([aa(k1).name,'\_1986'])
    subplot(122)
    imshow(im2)
    title([aa(k1).name,'\_1992'])

    figure
    BLOCK=[2,4,6,8,10];
    for k2=1:length(BLOCK)
        subplot(150+k2)
        if(k2==1)
            imshow(1-PCAKmeans_v2(im1,im2,BLOCK(k2)))
        else
            imshow(PCAKmeans_v2(im1,im2,BLOCK(k2)))
        end
        title(['h=',num2str(k2*2)])

    end
    
    
end
