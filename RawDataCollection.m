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
Max = 75;
%Set time interval
InitialTime = 1;
%Set initial time
b=[];
c=[];
d=[];
e=[];
%{
storage1 = [];
storage2 = [];
storage3 = [];
%log=[];
InitialTime = 1;
%framevalues=[]
%}
while(InitialTime < Max)
    b=[b;readVoltage(a,'A0')];
    c=[c;readVoltage(a,'A1')];
    d=[d;readVoltage(a,'A2')];
    e=[e;readVoltage(a,'A3')];
    %{
    data = g4client('127.0.0.1', 7234, .1);
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
    %log=[log;data];
    %framevalues=[framevalues;size(data,1)];
%}    
InitialTime=InitialTime+1;
end