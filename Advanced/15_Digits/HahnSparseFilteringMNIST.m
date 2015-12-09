
function HahnSparseFilteringMNIST()

clear all
close all
clc

load HahnMNISTRawData.mat

data1=data1_train_x;

label1=[];


for k=1:size(data1_train_y,1)
    
    label1=[label1; find(data1_train_y(k,:))-1];
    
end


for j=1:10
    
    
    data=[];
    
    
    for i=1:60000
        
        if label1(i)==j-1
            
            data=[data data1(:,i)];
            
            %         imagesc(reshape(data1(:,i),[16 16]))
            %
            %         label1(i)
            %
            %
            %         pause
            
        end
        
    end
    
    
    
    
    
    
    m=mean(data);
    X = data-m(ones(1,size(data,1)),:);
    
    
    
    
    
    
    nf = 100;  % # Features
    
    N=10;
    
    
    
    
    nm=[nf, size(X, 1)];
    
    W = randn(nm);
    
    W = W(:);
    
    
    
    t=3;
    
    
    
    for i = 2:N
        
        i
        
        filterplot(W,nm);
        
        %         pause
        drawnow
        
        
        [f,g] = SF(W,X,nf);
        
        
        
        W = W + t*g;
        
        
        
        %save(['HahnDictMNIST_10_25_' num2str(j-1) '.mat'],'Wp')
        
        
        
    end
    
    pause
    
end



end








function [f, g] = SF(W, X, a)


W = reshape(W, [a, size(X,1)]);

f    = W*X;

fs   = sqrt(f.^2 + 1e-8);

ell2fs = sqrt(sum(fs.^2,2) + 1e-8);

normfs  = fs./ell2fs(:,ones(1,size(fs,2)));

ell2normfs = sqrt(sum(normfs'.^2,2) + 1e-8);

fhat = normfs'./ell2normfs(:,ones(1,size(normfs',2)));

f  = sum(sum(fhat, 2), 1);




a=sum(ones(size(fhat)).*normfs', 2)./(ell2normfs.^2);

g = ones(size(fhat))./ell2normfs(:,ones(1,size(fhat,2))) - fhat.*a(:,ones(1,size(fhat,2)));

a=sum(g'.*fs, 2)./(ell2fs.^2);

g = g'./ell2fs(:,ones(1,size(g',2))) - normfs.*a(:,ones(1,size(normfs,2)));

g = (g .* ((W*X)./fs)) * X';

g = g(:);



end







function [D] = filterplot(X,nm)

size(X)
nm
pause

X = reshape(X, nm);

X = -1 + 2 * ((X - min(min(X)))/(max(max(X)) - min(min(X))));

[m n] = size(X);

w = round(sqrt(n));
h = (n / w);

c = floor(sqrt(m));
r = ceil(m / c);

p = 1;

D = - ones(p + r * (h + p),p + c * (w + p));

k = 1;
for j = 1:r
    for i = 1:c
        D(p + (j - 1) * (h + p) + (1:h), p + (i - 1) * (w + p) + (1:w)) = reshape(X(k, :), h, w) / max(abs(X(k, :)));
        k = k + 1;
    end
    
end


imagesc(D)
% surf(D)
% shading interp
colormap(gray)



end





