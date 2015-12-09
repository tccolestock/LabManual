clear all
close all
clc



trainLength = 2000;
testLength = 2000;
initLength = 100;

data = load('MackeyGlass_t17.txt');

figure(10);
plot(data(1:1000));
title('A sample of data');

in_d_unity = 1; 
out_d_unity = 1;
reservoir_d = 1000;
a = 0.3; % leaking rate

rand( 'seed', 42 );
Window = (rand(reservoir_d,1+in_d_unity)-0.5) .* 1;
Weight = rand(reservoir_d,reservoir_d)-0.5;
Weight = Weight .* 0.13;


X = zeros(1+in_d_unity+reservoir_d,trainLength-initLength);
Yt = data(initLength+2:trainLength+1)';

x = zeros(reservoir_d,1);
for t = 1:trainLength
	u = data(t);
	x = (1-a)*x + a*tanh( Window*[1;u] + Weight*x );
	if t > initLength
		X(:,t-initLength) = [1;u;x];
	end
end



reg = 1e-8;  
X_T = X';
Wout = Yt*X_T * inv(X*X_T + reg*eye(1+in_d_unity+reservoir_d));


Y = zeros(out_d_unity,testLength); % Y is Training
u = data(trainLength+1);
for t = 1:testLength 
	x = (1-a)*x + a*tanh( Window*[1;u] + Weight*x );
	y = Wout*[1;u;x];
	Y(:,t) = y;
	u = y;

end




errorLength = 500;
mse = sum((data(trainLength+2:trainLength+errorLength+1)'-Y(1,1:errorLength)).^2)./errorLength;


figure(1);
plot( data(trainLength+2:trainLength+testLength+1), 'color', [0,0.75,0] );
hold on;
plot( Y', 'b' );





