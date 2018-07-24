%clear all other variables
clear global
%Make sure the arduino support package is installed
global a;
%Find COM port
if ~isempty(instrfind);
    fclose(instrfind);
    delete(instrfind);
end
%Make an object of arduino
a=arduino();
b=[];
c=[];
d=[];
e=[];
InitialTime = 1;
%Set time bounds
Max = input('Maximum time:');
while(InitialTime < Max)
    b=[b;readVoltage(a,'A0')];
    c=[c;readVoltage(a,'A1')];
    d=[d;readVoltage(a,'A2')];
    e=[e;readVoltage(a,'A3')];
    InitialTime=InitialTime+1;
    pause(1/120)
end