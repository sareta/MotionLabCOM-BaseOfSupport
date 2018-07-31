%{
By: Siniva Areta
This code takes in measured values of where the feet actally are during a
given data collection. Because measurement error is high, we made marks
for the source EM center, source axes, and foot locations and then used a
seperate software called 'Graph Grabber 2.0' to systematically measure the
foot locations that we had physically marked.
%}

%This indicates which frame of data you are entering
i=2
LL(i,1)=-11.9 %Left Left X
LL(i,2)=-.314 %Left Left Y
TL(i,1)=-8.47 %Top Left X
TL(i,2)=-1.24 %Top Left Y
RL(i,1)=-8.21 %Right Left X
RL(i,2)=1.93 %Right Left Y
BL(i,1)=-13.5 %Bottom Left X
BL(i,2)=8.12 %Bottom Left Y
LR(i,1)=-1.22 %Left Right X
LR(i,2)=4.30 %Left Right Y
TR(i,1)=1.93 %Top Right X
TR(i,2)=6.14 %Top Right Y
RR(i,1)=-1.08 %Right Right X
RR(i,2)=8.43 %Right Right Y
BR(i,1)=-8.46 %Bottom Right X
BR(i,2)=6.46 %Bottom Right Y
