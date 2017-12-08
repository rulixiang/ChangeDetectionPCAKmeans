function [C,label]=Kmeans(X,k)
C=X(:,1:k)';
label=ones(1,size(X,2));
labelNew=label+1;
maxCnt=100;
cnt=0;
tic
while(cnt<=maxCnt && ~isequal(label,labelNew))
    cnt=cnt+1;
    disp(['Iteration ',num2str(cnt),'...'])
    toc
    label=labelNew;
    for k1=1:size(X,2)
        dist=zeros(1,k);
        for k2=1:k
            dist(k2)=pdist([C(k2,:);X(:,k1)'],'euclidean');
        end
        [~,labelNew(k1)]=min(dist);
    end
    for k2=1:k
        loc=find(labelNew==k2);
        if ~isempty(loc)
            temp=mean(X(:,loc)')';
            C(k2,:)=temp;
        end
    end
            
end
end