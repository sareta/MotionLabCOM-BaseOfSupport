%clear all other variables
clear global
clc
%Make sure the arduino support package is installed
global a;
%Find COM port
if ~isempty(instrfind);
    fclose(instrfind);
    delete(instrfind);A 
end
%Make an object of arduino
a=arduino();
%Set time bounds
Max = 300;
%Set time interval
InitialTime = 1;
%Set initial time
x = 0; 
y = 0;
z = 0;
w = 0;
while(InitialTime < Max)
 b = readVoltage(a,'A0');
 c = readVoltage(a,'A1');
 d = readVoltage(a,'A2');
 e = readVoltage(a,'A3');
 w = [w,1000*b];
 x = [x,1000*c];
 y = [y,1000*d];
 z = [z,1000*e];
 plot(w,'b');
 title('Voltage in FlexiForce Sensors');
 hold on 
 plot(x,'m');
 hold on 
 plot(y,'r');
 hold on 
 plot(z,'g');
 grid ON
 InitialTime = InitialTime +1;
 drawnow;
end
format compact
LToeAve = mean(w,2);
LHeelAve = mean(x,2);
LToeSTDEV = std(w);
LHeelSTDEV = std(x);
LToeMin = LToeAve-1.5.*LToeSTDEV
LHeelMin = LHeelAve-1.5.*LHeelSTDEV
RToeAve = mean(y,2);
RHeelAve = mean(z,2);
RToeSTDEV = std(y);
RHeelSTDEV = std(z);
RToeMin = RToeAve-1.25.*RToeSTDEV
RHeelMin = RHeelAve-1.25.*RHeelSTDEV
