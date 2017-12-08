function cm=PCAKmeans_v2(im1,im2,bm,BLOCK)
im1=double(im1);
im2=double(im2);
bm=double(bm);
Ratio=0.95;

delta=abs(im1-im2);

len=size(delta,1);
Z1=zeros(len,ceil(BLOCK/2));
Z2=zeros(ceil(BLOCK/2),len+BLOCK);
DD=[Z1,delta,Z1];
DD=[Z2;DD;Z2];
delta=DD;
X=[];
for k1=1:size(bm,1)
    for k2=1:size(bm,2)
        Vk=DD(k1:k1+BLOCK-1,k2:k2+BLOCK-1);
        X=[X,reshape(Vk,[],1)];
    end
end


meanVal=mean(X');
meanVal=meanVal';
C=zeros(size(meanVal));
for k1=1:size(X,2)
    X(:,k1)=X(:,k1)-meanVal;
    C=C+X(:,k1)*X(:,k1)';
end
C=C/k1;
[V,D]=eig(C);
Val=diag(D);
for k1=length(Val):-1:1
    if(sum(Val(k1:length(Val)))>=Ratio*sum(Val))
        break;
    end
end
% k1=length(Val)-3+1;
Vec=V(:,k1:length(Val));
FEATURE=(X-repmat(meanVal,1,size(X,2)))'*Vec;

[CC,label]=Kmeans(FEATURE',2);


cm=reshape(label,size(bm));
cm=cm'-1;


end