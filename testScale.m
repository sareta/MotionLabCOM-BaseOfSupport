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
Max = 200;
%Set time interval
InitialTime = 1;
%Set initial time
x = 0; 
y = 0;
z = 0;
w = 0;
while(InitialTime < Max)
    b = mean([readVoltage(a,'A0') readVoltage(a,'A0') readVoltage(a,'A0')]);
    c = mean([readVoltage(a,'A1') readVoltage(a,'A1') readVoltage(a,'A1')]);
    d = mean([readVoltage(a,'A2') readVoltage(a,'A2') readVoltage(a,'A2')]);
    e = mean([readVoltage(a,'A3') readVoltage(a,'A3') readVoltage(a,'A3')]);
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
windowSize = 10;
windowSizeVector = (1/windowSize)*ones(1,windowSize);
range = 1;
LeftToe = filter(windowSizeVector,range,w);
LeftHeel = filter(windowSizeVector,range,x);
RightToe = filter(windowSizeVector,range,y);
RightHeel = filter(windowSizeVector,range,z);
t=1:1:200;
plot(t,LeftToe,'b',t,LeftHeel,'m',t,RightToe,'r',t,RightHeel,'g')
title('Voltage in Flexiforce Sensors')
format compact
LToeAve = mean(w,2)
LHeelAve = mean(x,2)
LToeSTDEV = std(w);
LHeelSTDEV = std(x);
LToeMin = LToeAve-1.5.*LToeSTDEV
LHeelMin = LHeelAve-1.5.*LHeelSTDEV
RToeAve = mean(y,2)
RHeelAve = mean(z,2)
RToeSTDEV = std(y);
RHeelSTDEV = std(z);
RToeMin = RToeAve-1.5.*RToeSTDEV
RHeelMin = RHeelAve-1.5.*RHeelSTDEV
RTA = mean(RightToe)
RHA = mean(RightHeel)
LTA = mean(LeftToe)
LHA = mean(LeftHeel)
