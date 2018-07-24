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
%Set time bounds
Max = 500;
%Set time interval
InitialTime = 1;
%Set initial time
b=[];
c=[];
d=[];
e=[];
InitialTime = 1;
%Set time bounds
lefttoe= 7.5; % top of the foot where the toe is
leftheel= 5;% the heel 
leftoutside= 2.5; % the outer part of the left foot
leftinner= 2;  % the inner part of the left foot

righttoe= 7.5;
rightheel= 5;
rightoutside = 2.5;  % the outer part of the right foot
rightinner = 2; % the inner part of the right foot

leftglute= 5; %left side of the sitting outline
rightglute =5; %right side of the sitting outline

leftknee=18; % knee offsets 
rightknee=18; 

storage1 = [];
storage2 = [];
storage3 = [];
while(InitialTime < Max)
    b=[b;readVoltage(a,'A0')];
    c=[c;readVoltage(a,'A1')];
    d=[d;readVoltage(a,'A2')];
    e=[e;readVoltage(a,'A3')];
    data = g4client('127.0.0.1', 7234, .25);
    
    totalFrames = size(data, 1);

    %intialize the marker matrices
    markerOne = zeros(totalFrames/3, 6);
    markerTwo = zeros(totalFrames/3, 6);
    markerThree = zeros(totalFrames/3, 6);

    for i = 1:totalFrames/3 %a third of the row size
        markerOne(i,1) = data{i*3-2, 5};   
        markerOne(i,2) = data{i*3-2, 6};
        markerOne(i,3) = data{i*3-2, 7}*-1;
        markerOne(i,4) = data{i*3-2, 8};   
        markerOne(i,5) = data{i*3-2, 9};
        markerOne(i,6) = data{i*3-2, 10};
    
        markerTwo(i,1) = data{i*3-1, 5};   
        markerTwo(i,2) = data{i*3-1, 6};
        markerTwo(i,3) = data{i*3-1, 7}*-1;
        markerTwo(i,4) = data{i*3-1, 8};   
        markerTwo(i,5) = data{i*3-1, 9};
        markerTwo(i,6) = data{i*3-1, 10};
    
        markerThree(i,1) = data{i*3, 5};   
        markerThree(i,2) = data{i*3, 6};
        markerThree(i,3) = data{i*3, 7}*-1;
        markerThree(i,4) = data{i*3, 8};   
        markerThree(i,5) = data{i*3, 9};
        markerThree(i,6) = data{i*3, 10};
        
    end
    AVG1 = mean(markerOne);
    AVG2 = mean(markerTwo);
    AVG3 = mean(markerThree);
    storage1 = [storage1;AVG1];
    storage2 = [storage2;AVG2];
    storage3 = [storage3;AVG3];
    InitialTime=InitialTime+1;
end