%{
By: Siniva Areta
This code takes data collected from the codes 'FootLocationsNominal.m' and
'FootLocationsPolemus.m' to find the error within the system.
%}

format compact
%Allows the user to distiguis which trial (foot configuration) this is.
i=1
%Solves for distances between Nominal and Polhemus foot locations using the
%principle of distance=sqrt(deltaX^2+deltaY^2).
distLL=((LL(i,1)-LLMx).^2+(LL(i,2)-LLMy).^2)^.5
distTL=((TL(i,1)-TLMx).^2+(TL(i,2)-TLMy).^2)^.5
distRL=((RL(i,1)-RLMx).^2+(RL(i,2)-RLMy).^2)^.5
distBL=((BL(i,1)-BLMx).^2+(BL(i,2)-BLMy).^2)^.5
distLR=((LR(i,1)-LRMx).^2+(LR(i,2)-LRMy).^2)^.5
distRR=((RR(i,1)-RRMx).^2+(RR(i,2)-RRMy).^2)^.5
distTR=((TR(i,1)-TRMx).^2+(TR(i,2)-TRMy).^2)^.5
distBR=((BR(i,1)-BRMx).^2+(BR(i,2)-BRMy).^2)^.5
%Combines all distances into a single matrix
Distances(i,:)=[distLL distTL distBL distRL distRR distLR distBR distTR];
Complete=[Distances(1,:) Distances(2,:)];
%Solves for mean, standard deviation, and associated error of the
%differences. 
MEAN=mean(Complete)
STDEV=std(Complete)
SE=STDEV./(16)^.5
AE=1.96*SE