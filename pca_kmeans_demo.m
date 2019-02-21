% MATLAB implementation for "Unsupervised Change Detection in Satellite Images Using Principal Component Analysis and k-Means Clustering"
% 
% Created on Thu Dec 7 2017, @author: rulixiang

clear;clc
close all
img_dir='./eros_Data';
aa=dir(img_dir);
block_size = [2,4,6,8,10];

for k1=3:length(aa)
    img=aa(k1).name;
    disp(['Processing area-',img,' ...'])
    im1=imread([img_dir,'/',img,'/',img,'_1986.png']);
    im2=imread([img_dir,'/',img,'/',img,'_1992.png']);
    bm=imread([img_dir,'/',img,'/',img,'_change.png']);

    figure
    subplot(121)
    imshow(im1)
    title([aa(k1).name,'\_1986'])
    subplot(122)
    imshow(im2)
    title([aa(k1).name,'\_1992'])

    figure
    for k2=1:length(block_size)
        subplot(150+k2)
        imshow(pca_kmeans(im1,im2,block_size(k2)))

        title(['h=',num2str(k2*2)])

    end
    
    
end