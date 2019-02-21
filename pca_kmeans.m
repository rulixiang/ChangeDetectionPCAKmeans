function [change_map] = pca_kmeans(im1,im2,block_size,rate)
%% [change_map] = pca_kmeans(im1,im2,block_size,rate)
% im1: Input image for time 1 with size of [m,n,k];
% im2: Input image for time 2 with size of [m,n,k];
% block_size: Size of block;
% rate: Proportion of the Pricipal Components;
%
% change_map: Change map with size of [m,n];

%% set the proportion of the Pricipal Components;
if nargin <= 3
    rate=0.9;
end

%% calculate the image_size and padding_size;
image_size = size(im1);
padding_size = image_size + block_size;
padding_size(3) = padding_size(3) - block_size;

%% calculate the difference image;
delta = abs(double(im1)-double(im2));

%% padding
padding_img = zeros(padding_size);
lb = ceil(block_size/2);
ub_col = lb+image_size(1)-1;
ub_row = lb+image_size(2)-1;
padding_img(lb:ub_col,lb:ub_row,:)=delta;

%% generate feature vector for blocks;
vk = zeros(prod(image_size(1:2)),image_size(3)*block_size*block_size);
cnt=1;
for k1=1:image_size(1)
    for k2=1:image_size(2)
        vk_temp = padding_img(k1:k1+block_size-1,k2:k2+block_size-1,:);
        vk(cnt,:)=reshape(vk_temp,[],1);
        cnt=cnt+1;
    end
end
clear cnt;

%% normlization
mean_val = mean(vk);
std_val = std(vk)+1e-12;
num = size(vk,1);
vk = (vk-repmat(mean_val,num,1))./repmat(std_val,num,1);

%% PCA
cov = vk' * vk;
[V,D]=eig(cov);
val=diag(D);
for k1=length(val):-1:1
    if(sum(val(k1:length(val)))>=rate*sum(val))
        break;
    end
end
vec=V(:,k1:length(val));
feature=vk * vec;

%% kmeans
[label,~]=kmeans(feature,2);
change_map=reshape(label,image_size([2,1]));
change_map=change_map'-1;
end
