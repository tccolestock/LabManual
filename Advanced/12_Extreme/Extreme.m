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
Echo State Network Time Series Prediction 

function MPCR_ELM()

close all
clear all
clc
% x = [0 0; 0 1; 1 0; 1 1]
% y = [ 0; 1; 1; 0]

% x=[1,0,0;0,1,0;0,0,1;1,1,1;0,0,0;1,1,0;0,1,1;1,0,1];
% y=[1,1,1,0,0,0,0,0]';

% x=[1,0,0,0;0,1,0,0;0,0,1,0;0,0,0,1;1,1,1,1;0,0,0,0;1,1,0,0;0,0,1,1;1,1,0,1;1,0,1,1;1,0,0,1;0,1,1,0;1,0,1,0;0,1,0,1;0,1,1,1;1,1,1,0];
% y=[1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0]';


x=[-20:.5:20];

% y=10.*x+0.5;
y=x.^2;
% y=abs(sin(x/8));
% y=sin(20.*x);
% y=x.^2+20.*rand(size(x));
%   y=0.5*sinc(x/8);
% y=exp(-0.02.*(x-4).^2);
% y=10.*exp(-(x-4).^2)+sin(2.*x)+x;

x=x/norm(x);
y=y/norm(y);


x=x';
y=y';



r=randperm(size(x,1));




x=x(r);
y=y(r);




x1=x(1:end/2);
x2=x(end/2+1:end);

y1=y(1:end/2);
y2=y(end/2+1:end);



h=1000;



W1=randn(size(x1,2)+1,h)+eps;



H1=tanh(([x1 ones(size(x1,1),1)]*W1));



% B=pinv(H1)*y1;

B=H1\y1;





H2=tanh(([x2 ones(size(x2,1),1)]*W1));


y02=(H2*B);







plot(x2,y02,'bx','Markersize', 10)

hold on

plot(x1,y1,'ro','Markersize', 15)







end















