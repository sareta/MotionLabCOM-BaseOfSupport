
%{
By: Siniva Areta
This code takes data collected from the code 'RawDataCollection.m' and
'PostProcessing.m' and solves for means of the foot position. This is only
useful for validation of the locations that are calculated by the system.
%}

LLMx = mean(leftleft_new(:,1));  %Left Left X
LLMy = mean(leftleft_new(:,2));  %Leff Left Y
TLMx = mean(topleft_new(:,1));  %Top Left X
TLMy = mean(topleft_new(:,2));  %Top Left Y
RLMx = mean(rightleft_new(:,1));  %Right Left X
RLMy = mean(rightleft_new(:,2));  %Right Left Y
BLMx = mean(bottomleft_new(:,1));  %Bottom Left X
BLMy = mean(bottomleft_new(:,2));  %Bottom Left Y
LRMx = mean(leftright_new(:,1));  %Left Right X
LRMy = mean(leftright_new(:,2));  %Left Right Y
TRMx = mean(topright_new(:,1));  %Top Right X
TRMy = mean(topright_new(:,2));  %Top Right Y
RRMx = mean(rightright_new(:,1));  %Right Right X
RRMy = mean(rightright_new(:,2));  %Right Right Y
BRMx = mean(bottomright_new(:,1));  %Bottom Right X
BRMy = mean(bottomright_new(:,2));  %Bottom Right Y