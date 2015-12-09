%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%------------------------------------------------------%
%
% Machine Perception and Cognitive Robotics Laboratory
%
%     Center for Complex Systems and Brain Sciences
%
%              Florida Atlantic University
%
%------------------------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%------------------------------------------------------%
%http://frog.ai/blog/?p=39
%http://neuro.bstu.by/ai/RL-3.pdf
%------------------------------------------------------%
function MPCR_QLearning

clear all
close all
clc

NumRows = 16;
NumCols = NumRows;

G = 0.9; %gamma
L = 0.7; %learning rate
epsilon = 0.4; %best option with chance (1-epsilon) else random

NumStates = NumRows*NumCols;

Q = zeros(NumStates);       % Q matrices
R = zeros(NumStates);       % Reward matrix
A = zeros(NumRows,NumCols); % Agent


rc_map=zeros(2,NumStates); %row/col

i = 1:NumStates;
rc_map(2,i) = ceil(i/NumCols);
rc_map(1,i) = (i+NumRows)-(NumRows*rc_map(2,i));

N = zeros(NumStates);  %Neighbors (1 for linked; 0 for unlinked)

% allow linked states to be all neighbours including diagonal
for i = 1:NumStates
    for j = 1:NumStates
        if ((rc_map(2,j)-rc_map(2,i) < 2)&&(rc_map(2,j)-rc_map(2,i) > -2)&&(rc_map(1,j)-rc_map(1,i) < 2)&&(rc_map(1,j)-rc_map(1,i) > -2))&&((rc_map(2,j)~=rc_map(2,i))&&(rc_map(1,j)~=rc_map(1,i)))
            N(i,j) = 1;
        end
    end
end

Sfinal = NumRows*NumCols; %Reward in Last Array Location
N(Sfinal,:)=0;            %Goal State has No Neighbors
R(:,Sfinal) = 100;        %Reward of 100 in Goal State
A(Sfinal)=10;
A(1)=5;

%------------------------------------------------------%
%------------------------------------------------------%
%Main Loop

for i =1:10000
    
    pause(0.001)

    S1 = 1;
    
    while (S1 ~= Sfinal)
        
               
        [S2QB,S2]=max(N(S1,:).*Q(S1,:));
        

        if (rand < (1-epsilon)) || (S2QB==0)
            
            S2 = randi([1, NumStates]);
            
            while N(S1,S2) == 0
                S2 = randi([1, NumStates]);
            end;
            
        end;
        
        
        Q(S1,S2) = ((1-L)*Q(S1,S2)) + L*((R(S1,S2)+(G*(max(N(S2,:).*Q(S2,:))))));
        
        S1 = S2;
        
       
%------------------------------------------------------%        
%------------------------------------------------------%         
%Draw Agent Location Plot

        A(rc_map(1,S2),rc_map(2,S2)) = 1;
        
        subplot(131);
        imagesc(A(end:-1:1,:))
        title('Agent')
        axis off;
        pause(0.05)
        
        %Reset Agent Plot
        A(rc_map(1,S2),rc_map(2,S2)) = 0;
        A(Sfinal)=10;
        A(1)=5;
        
%------------------------------------------------------%        
%------------------------------------------------------%         
%Draw Q Values Plot        
        
        subplot(132);
        imagesc(Q)
        title('Q Values')
        xlabel('State 2')
        ylabel('State 1')
        drawnow()
             
      
%------------------------------------------------------%        
%------------------------------------------------------%        
%Draw Best Route        

        S11 = 1;
        route = zeros(NumRows,NumCols);
        route(1,1)=1;
        marker=1;
        
        [S2QB,S2QB2]=max(N(1,:).*Q(S11,:));
        
        while (S2QB > 0)&&(S2QB2~=Sfinal)
            
            [S2QB,S2QB2]=max(N(S11,:).*Q(S11,:));
            
            S11 = S2QB2;
            
            route(rc_map(1,S2QB2),rc_map(2,S2QB2)) = marker;
            marker=marker+1;
            
            subplot(133);
            imagesc(route(end:-1:1,:))
            title('Best Route')
            
            
            
        end
        
        
    end;
    
    
end


end
