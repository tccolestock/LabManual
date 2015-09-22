%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%------------------------------------------------------%
%
% Machine Perception and Cognitive Robotics Laboratory
%
%     Center for Complex Systems and Brain Sciences
%               Florida Atlantic University
%
%------------------------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%------------------------------------------------------%
%LabManual
%------------------------------------------------------%
%Backpropagation Neural Network Sunglasses Detector

function Hahn_bp_image_dropout_Left_Right_TV

clear all
close all
clc

cd /Users/williamedwardhahn/Desktop/NN_Project/faceinput
dr1=dir('*straight*open*_2.pgm');
dr2=dir('*straight*sunglasses*_2.pgm');
%
% dr1=dir('*left*_2.pgm');
% dr2=dir('*right*_2.pgm');

% dr1=dir('*up*_2.pgm');
% dr2=dir('*straight*_2.pgm');


% %
% dr1=dir('*left.pgm');
% dr2=dir('*right.pgm');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


f1={dr1.name}; % get only filenames to cell

c1=[];

for i=1:length(f1) % for each image
    
    a1=f1{i};
    
    b1=imread(a1);
    
    b1=b1(1:end)';
    
    c1=[c1 b1];
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f2={dr2.name}; % get only filenames to cell

c2=[];

for i=1:length(f2) % for each image
    
    a2=f2{i};
    
    b2=imread(a2);
    
    %       imagesc(b2)
    %
    %     pause
    
    b2=b2(1:end)';
    
    c2=[c2 b2];
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pattern=[im2double(c1) im2double(c2)]';

category=[ones(1,size(c1,2)) 0.*ones(1,size(c2,2))]';

r=randperm(size(pattern,1));

pattern=pattern(r,:);
category=category(r);



trainpattern=pattern(1:end/3,:);

testpattern=pattern(end/3+1:2*(end/3),:);

validpattern=pattern(2*(end/3)+1:end,:);


traincategory=category(1:end/3,:);

testcategory=category(end/3+1:2*(end/3),:);

validcategory=category(2*(end/3)+1:end,:);




%
r=randperm(size(pattern,1));

pattern=pattern(r,:);
category=category(r);


%
% for i =1:size(pattern,1)
%
% imagesc(reshape(pattern(i,:),60,64))
% colormap(gray)
%
% category(i)
%
% pause
%
% end
%
%
% return




bias=ones(size(trainpattern,1),1);
trainpattern = [trainpattern bias];

testpattern = [testpattern bias];
validpattern = [validpattern bias];





n1 = size(trainpattern,2)
n2 = 2;   %n2-1
n3 = size(traincategory,2);


w1 = 0.001*(1-2*rand(n1,n2-1));
w2 = 0.001*(1-2*rand(n2,n3));

dw1 = zeros(size(w1));
dw2 = zeros(size(w2));

L = 0.001;        % Learning
M = 0.5;          % Momentum






for loop=1:500
    
    
    %     b=rand()>0.5;
    
    
    b=1;
    
    
    
    act1 = [af((b*trainpattern) * w1) bias];
    act2 =  af((b*act1) * w2);
    
    
    
    
    error = traincategory - act2;
    sse = sum(error.^2);
    
    
    delta_w2 = error .* act2 .* (1-act2);
    delta_w1 = delta_w2*w2' .* act1 .* (1-act1);
    delta_w1(:,size(delta_w1,2)) = [];
    
    
    dw1 = L * trainpattern' * delta_w1 + M * dw1;
    dw2 = L * act1' * delta_w2 + M * dw2;
    
    
    w1 = w1 + dw1;
    w2 = w2 + dw2;
    
    
    
    w1=w1/norm(w1);
    w2=w2/norm(w2);
    
    
    
    
    figure(1)
    %     surf(reshape(w1(1:n1-1,1),60,64))
    %
    %     subplot(121)
    
    Iw1=reshape(w1(1:n1-1,1),60,64);
    
    
    
    
    
    
    p=Iw1(:,2:end)-Iw1(:,1:end-1);
    
    q=Iw1(2:end,:)-Iw1(1:end-1,:);
    
    
    [pn, pm]=size(p);
    
    [qn, qm]=size(q);
    
    n=min(pn,qn);
    m=min(pm,qm);
    
    p=p(1:n,1:m);
    q=q(1:n,1:m);
    
    
    TV=sqrt(p.^2+q.^2);
    
    
    sum(sum(TV>0.01))
    
    subplot(121)
    imagesc(Iw1)
    colormap(jet)
    
    subplot(122)
    
    
    imagesc(TV,[0,0.1])
    
    
    
    
    
    
    
    
    
    %     imagesc(reshape(w1(1:n1-1,2),60,64))
    %     subplot(163)
    %     plot(w1)
    %     subplot(164)
    %
    %     nn=1:length(testcategory);
    %     plot(nn(find(traincategory==1)),act2(find(traincategory==1)),'g^','MarkerSize',12)
    %     hold on
    %     plot(nn(find(traincategory==0)),act2(find(traincategory==0)),'rv','MarkerSize',12)
    %
    %     plot(traincategory,'bo')
    %     hold off
    %     %
    %
    %
    %     subplot(165)
    %     act1 = [af(testpattern * w1) bias];
    %     act2 = af(act1 * w2/2);
    %
    %     nn=1:length(testcategory);
    %     plot(nn(find(testcategory==1)),act2(find(testcategory==1)),'g^','MarkerSize',12)
    %     hold on
    %     plot(nn(find(testcategory==0)),act2(find(testcategory==0)),'rv','MarkerSize',12)
    %
    %     plot(testcategory,'bo')
    %     hold off
    %
    %     error2 = testcategory ~= (act2>0.5);
    %     sse2 = sum(error2);
    %
    %
    %     subplot(166)
    %     act1 = [af(validpattern * w1) bias];
    %     act2 = af(act1 * w2/2);
    %     nn=1:length(testcategory);
    %     plot(nn(find(validcategory==1)),act2(find(validcategory==1)),'g^','MarkerSize',12)
    %     hold on
    %     plot(nn(find(validcategory==0)),act2(find(validcategory==0)),'rv','MarkerSize',12)
    %
    %     hold on
    %     plot(validcategory,'bo')
    %     hold off
    %
    %     error3 = validcategory ~= (act2>0.5);
    %     sse3 = sum(error3);
    %
    %
    %     [(1-(sse2/length(testcategory)))*100 (1-(sse3/length(validcategory)))*100]
    %
    %
    drawnow()
    %
    
    
    
    
    
    
    
    
    
    
end







end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------%
%--------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function network_output = neural_network(neural_input,hidden_weights,output_weights)

network_output=af([af(([neural_input,1])*hidden_weights),1]*output_weights);

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------%
%--------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%









%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------%
%--------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function action = af (weighted_sum)


action = 1./(1+exp(-weighted_sum));  		% Logistic / Sigmoid Function


end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------%
%--------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



