function cm=PCAKmeans(im1,im2,bm,BLOCK)
im1=double(im1);
im2=double(im2);
bm=double(bm);
Ratio=0.95;

delta=abs(im1-im2);
delta=bm;
num1=size(delta,1)/BLOCK;
num2=size(delta,2)/BLOCK;
X=zeros(size(reshape(delta,BLOCK*BLOCK,[])));
for k1=1:size(X,2)
    i=floor((k1-1)/num2)+1;
    j=mod(k1,num1);
    if(j==0)
        j=num1;
    end
    base1=(i-1)*BLOCK+1;
    base2=(j-1)*BLOCK+1;
    end1=i*BLOCK;
    end2=j*BLOCK;
    %disp(num2str([base1,base2,end1,end2]))
    xx=delta(base1:end1,base2:end2);
    X(:,k1)=reshape(xx,[],1);
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
cm=zeros(size(delta));

len=size(delta,1);
Z1=zeros(len,ceil(BLOCK/2));
Z2=zeros(ceil(BLOCK/2),len+BLOCK);
DD=[Z1,delta,Z1];
DD=[Z2;DD;Z2];
for k1=1:size(cm,1)
    for k2=1:size(cm,2)
        Vk=DD(k1:k1+BLOCK-1,k2:k2+BLOCK-1);
        Vk=reshape(Vk,1,[])-meanVal';
        Vk=Vk*Vec;
        if(pdist([Vk;CC(1,:)])>pdist([Vk;CC(2,:)]))
            cm(k1,k2)=1;
        else
            cm(k1,k2)=2;
        end
    end
end

end