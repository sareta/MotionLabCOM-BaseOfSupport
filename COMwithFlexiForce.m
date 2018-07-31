%{
By: Siniva Areta
This code is basically a combination of 'RawDataCollection.m' and
'PostProcessing.m'. It takes the last .1 sec of Polhemus data, a voltage
reading from each flexiforce, and graphs it in the same loop. The problem
with this code is that because it is doing so much during each loop, the
timing is disjointed and the animation often doesn't make much sense. That
is the reason we switched to two codes, one for collecting data and the
other for processing it after it has been collected. 

*NOTE: If you are a CS major or very proficient in code efficiency, this
code has the potential to be very useful if time per loop could be
durastically decreased. In other words, if this code could perform in real
time and not be disjointed, it'd be a huge improvement from the current
system. 
%}

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
Max = 100;
%Set time interval
InitialTime = 1;
%Set initial time
w = 0;
x = 0;
y = 0;
z = 0;
%Foot Measurements
lefttoe= 7.5; % sensor to top of the foot where the toe is
leftheel= 5;% sensor to the heel 
leftoutside= 2.5; % sensor to the outer part of the left foot
leftinner= 2;  %sensor to the inner part of the left foot

righttoe= 7.5; %sensor to right toe
rightheel= 5; %sensor to right heel
rightoutside = 2.5;  %sensor to the outer part of the right foot
rightinner = 2; %sensor to the inner part of the right foot

leftglute= 5; %left side of the sitting outline
rightglute =5; %right side of the sitting outline

leftknee=18; % knee offsets 
rightknee=18; 

storage1 = [];
storage2 = [];
storage3 = [];

while(InitialTime < Max)
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
    
    R = (AVG1(4)-90);   %alpha angle for left foot
    S = (AVG2(4)-90);   %alpha angle for right foot 
    T = (AVG3(4)-90);   %alpha angle for sacral marker
    n=1;
    topleft = [AVG1(1), AVG1(2)+ lefttoe];             
    bottomleft = [AVG1(1), AVG1(2)-leftheel];                  
    rightleft = [ AVG1(1)+leftoutside, AVG1(2)];        
    leftleft= [AVG1(1)-leftinner, AVG1(2)];         
    
    topright=[AVG3(1), AVG3(2)+ righttoe];       
    bottomright=[AVG3(1), AVG3(2)- rightheel];
    rightright=[AVG3(1)-rightinner, AVG3(2)];
    leftright= [AVG3(1)+rightoutside, AVG3(2)];

    sitleft = [AVG2(1)+ leftglute, AVG2(2)];         %offset for when they are sitting down
    sitright = [AVG2(1)-rightglute, AVG2(2)];

    kneeleftout= [AVG1(1)+1.5, AVG1(2)-leftknee]; %left knee outer point 
    kneerightout= [AVG3(1)-1.5, AVG3(2)-rightknee]; %right knee outer point 
    
   topleft_new(n,1) = (((topleft(n,1)-AVG1(1))*cosd(R)) - ((topleft(n,2)-AVG1(2))*sind(R))) + AVG1(1) ;
   topleft_new(n,2) = (((topleft(n,1)-AVG1(1))*sind(R)) + ((topleft(n,2)-AVG1(2))*cosd(R))) + AVG1(2) ;
   bottomleft_new(n,1) = (((bottomleft(n,1)-AVG1(1))*cosd(R)) - ((bottomleft(n,2)-AVG1(2))*sind(R))) +AVG1(1);
   bottomleft_new(n,2) = (((bottomleft(n,1)-AVG1(1))*sind(R)) + ((bottomleft(n,2)-AVG1(2))*cosd(R))) + AVG1(2) ;
   rightleft_new(n,1) = (((rightleft(n,1)-AVG1(1))*cosd(R)) - ((rightleft(n,2)-AVG1(2))*sind(R))) + AVG1(1);
   rightleft_new(n,2) = (((rightleft(n,1)-AVG1(1))*sind(R)) + ((rightleft(n,2)-AVG1(2))*cosd(R))) + AVG1(2) ;
   leftleft_new(n,1) = (((leftleft(n,1)-AVG1(1))*cosd(R)) - ((leftleft(n,2)-AVG1(2))*sind(R))) + AVG1(1);
   leftleft_new(n,2) = (((leftleft(n,1)-AVG1(1))*sind(R)) + ((leftleft(n,2)-AVG1(2))*cosd(R))) + AVG1(2) ;
   
   topright_new(n,1) = (((topright(n,1)-AVG3(1))*cosd(S)) - ((topright(n,2)-AVG3(2))*sind(S))) + AVG3(1)  ;
   topright_new(n,2)= (((topright(n,1)-AVG3(1))*sind(S)) + ((topright(n,2)-AVG3(2))*cosd(S))) +AVG3(2) ;
   bottomright_new(n,1) =(((bottomright(n,1)-AVG3(1))*cosd(S)) - ((bottomright(n,2)-AVG3(2))*sind(S))) + AVG3(1);
   bottomright_new(n,2)= (((bottomright(n,1)-AVG3(1))*sind(S)) + ((bottomright(n,2)-AVG3(2))*cosd(S))) +AVG3(2);
   rightright_new(n,1)= (((rightright(n,1)-AVG3(1))*cosd(S)) - ((rightright(n,2)-AVG3(2))*sind(S))) + AVG3(1);
   rightright_new(n,2)= (((rightright(n,1)-AVG3(1))*sind(S)) + ((rightright(n,2)-AVG3(2))*cosd(S))) +AVG3(2);
   leftright_new(n,1)= (((leftright(n,1)-AVG3(1))*cosd(S)) - ((leftright(n,2)-AVG3(2))*sind(S))) + AVG3(1);
   leftright_new(n,2)= (((leftright(n,1)-AVG3(1))*sind(S)) + ((leftright(n,2)-AVG3(2))*cosd(S))) +AVG3(2);
    
   %{
   sitleft_new(n,1) = (((sitleft(n,1)-markerTwo(n,1))*cosd(T(n,1))) - ((sitleft(n,2)-markerTwo(n,2))*sind(T(n,1)))) + markerTwo(n,1);
   sitleft_new(n,2) = (((sitleft(n,1)-markerTwo(n,1))*sind(T(n,1))) + ((sitleft(n,2)-markerTwo(n,2))*cosd(T(n,1)))) +markerTwo(n,2) ;
   sitright_new(n,1) = (((sitright(n,1)-markerTwo(n,1))*cosd(T(n,1))) - ((sitright(n,2)-markerTwo(n,2))*sind(T(n,1)))) + markerTwo(n,1);
   sitright_new(n,2) =(((sitright(n,1)-markerTwo(n,1))*sind(T(n,1))) + ((sitright(n,2)-markerTwo(n,2))*cosd(T(n,1)))) +markerTwo(n,2) ;
 
   kneeleftout_new(n,1)= (((kneeleftout(n,1)-markerOne(n,1))*cosd(R(n,1))) - ((kneeleftout(n,2)-markerOne(n,2))*sind(R(n,1)))) + markerOne(n,1) ;
   kneeleftout_new(n,2)= (((kneeleftout(n,1)-markerOne(n,1))*sind(R(n,1))) + ((kneeleftout(n,2)-markerOne(n,2))*cosd(R(n,1)))) + markerOne(n,2) ;
 
   kneerightout_new(n,1)=(((kneerightout(n,1)-markerThree(n,1))*cosd(S(n,1))) - ((kneerightout(n,2)-markerThree(n,2))*sind(S(n,1)))) + markerThree(n,1) ;
   kneerightout_new(n,2)=(((kneerightout(n,1)-markerThree(n,1))*sind(S(n,1))) + ((kneerightout(n,2)-markerThree(n,2))*cosd(S(n,1)))) + markerThree(n,2) ;
   %}
    sacral= [AVG2(1),AVG2(2)];
    b = readVoltage(a,'A0');
    c = readVoltage(a,'A1');
    d = readVoltage(a,'A2');
    e = readVoltage(a,'A3');
    w = [w,1000*b];
    x = [x,1000*c];
    y = [y,1000*d];
    z = [z,1000*e];
    if 1000*b > LToeMin
        LT=3;
    else
        LT=0;
    end
    if 1000*c > LHeelMin
        LH=1;
    else
        LH=0;
    end
    if 1000*d > RToeMin
        RT=3;
    else
        RT=0;
    end
    if 1000*e > RHeelMin
        RH=1;
    else
        RH=0;
    end
    position=LT+LH+RT+RH;
    if position==8
        XValues = [bottomleft_new(n,1) leftleft_new(n,1) topleft_new(n,1) topright_new(n,1) rightright_new(n,1) bottomright_new(n,1) bottomleft_new(n,1)];
        YValues = [bottomleft_new(n,2) leftleft_new(n,2) topleft_new(n,2) topright_new(n,2) rightright_new(n,2) bottomright_new(n,2) bottomleft_new(n,2)];
    elseif position==7
        if LH==1
            XValues = [bottomleft_new(n,1) leftleft_new(n,1) topleft_new(n,1) topright_new(n,1) rightright_new(n,1) rightleft_new(n,1) bottomleft_new(n,1)];
            YValues = [bottomleft_new(n,2) leftleft_new(n,2) topleft_new(n,2) topright_new(n,2) rightright_new(n,2) rightleft_new(n,2) bottomleft_new(n,2)];
        else
            XValues = [leftright_new(n,1) leftleft_new(n,1) topleft_new(n,1) topright_new(n,1) rightright_new(n,1) bottomright_new(n,1) leftright_new(n,1)];
            YValues = [leftright_new(n,2) leftleft_new(n,2) topleft_new(n,2) topright_new(n,2) rightright_new(n,2) bottomright_new(n,2) leftright_new(n,2)];
        end
    elseif position == 6
        XValues = [leftleft_new(n,1) topleft_new(n,1) topright_new(n,1) rightright_new(n,1) rightleft_new(n,1) leftright_new(n,1) leftleft_new(n,1)];
        YValues = [leftleft_new(n,2) topleft_new(n,2) topright_new(n,2) rightright_new(n,2) rightleft_new(n,2) leftright_new(n,2) leftleft_new(n,2)];
    elseif position == 5
        if LT == 3
            XValues = [bottomleft_new(n,1) leftleft_new(n,1) topleft_new(n,1) leftright_new(n,1) rightleft_new(n,1) rightright_new(n,1) bottomright_new(n,1) bottomleft_new(n,1)];
            YValues = [bottomleft_new(n,2) leftleft_new(n,2) topleft_new(n,2) leftright_new(n,2) rightleft_new(n,2) rightright_new(n,2) bottomright_new(n,2) bottomleft_new(n,2)];
        else
            XValues = [bottomleft_new(n,1) leftleft_new(n,1) leftright_new(n,1) rightleft_new(n,1) topright_new(n,1) rightright_new(n,1) bottomright_new(n,1) bottomleft_new(n,1)];
            YValues = [bottomleft_new(n,2) leftleft_new(n,2) leftright_new(n,2) rightleft_new(n,2) topright_new(n,2) rightright_new(n,2) bottomright_new(n,2) bottomleft_new(n,2)];
        end
    elseif position == 4
        if RT == 3 
            if RH == 1
                XValues = [bottomright_new(n,1) rightleft_new(n,1) topright_new(n,1) rightright_new(n,1) bottomright_new(n,1)];
                YValues = [bottomright_new(n,2) rightleft_new(n,2) topright_new(n,2) rightright_new(n,2) bottomright_new(n,2)];
            else
                XValues = [bottomleft_new(n,1) leftleft_new(n,1) leftright_new(n,1) topright_new(n,1) rightright_new(n,1) rightleft_new(n,1) bottomleft_new(n,1)];
                YValues = [bottomleft_new(n,2) leftleft_new(n,2) leftright_new(n,2) topright_new(n,2) rightright_new(n,2) rightleft_new(n,2) bottomleft_new(n,2)];
            end
        else
            if LH == 1
                XValues = [bottomleft_new(n,1) leftleft_new(n,1) topleft_new(n,1) leftright_new(n,1) bottomleft_new(n,1)];
                YValues = [bottomleft_new(n,2) leftleft_new(n,2) topleft_new(n,2) leftright_new(n,2) bottomleft_new(n,2)];
            else
                XValues = [leftright_new(n,1) leftleft_new(n,1) topleft_new(n,1) rightleft_new(n,1) rightright_new(n,1) bottomright_new(n,1) leftright_new(n,1)];
                YValues = [leftright_new(n,2) leftleft_new(n,2) topleft_new(n,2) rightleft_new(n,2) rightright_new(n,2) bottomright_new(n,2) leftright_new(n,2)];
            end
        end
    elseif position == 3
        if RT == 3
            XValues = [rightleft_new(n,1) topright_new(n,1) rightright_new(n,1) rightleft_new(n,1)];
            YValues = [rightleft_new(n,2) topright_new(n,2) rightright_new(n,2) rightleft_new(n,2)];
        else
            XValues = [leftleft_new(n,1) topleft_new(n,1) leftright_new(n,1) leftleft_new(n,1)];
            YValues = [leftleft_new(n,2) topleft_new(n,2) leftright_new(n,2) leftleft_new(n,2)];
        end
    elseif position == 2
        XValues = [bottomleft_new(n,1) leftleft_new(n,1) leftright_new(n,1) rightleft_new(n,1) rightright_new(n,1) bottomright_new(n,1) bottomleft_new(n,1)];
        YValues = [bottomleft_new(n,2) leftleft_new(n,2) leftright_new(n,2) rightleft_new(n,2) rightright_new(n,2) bottomright_new(n,2) bottomleft_new(n,2)];
    elseif position == 1
        if RH == 1
            XValues = [bottomright_new(n,1) rightleft_new(n,1) rightright_new(n,1) bottomright_new(n,1)];
            YValues = [bottomright_new(n,2) rightleft_new(n,2) rightright_new(n,2) bottomright_new(n,2)];
        else
            XValues = [bottomleft_new(n,1) leftleft_new(n,1) leftright_new(n,1) bottomleft_new(n,1)];
            YValues = [bottomleft_new(n,2) leftleft_new(n,2) leftright_new(n,2) bottomleft_new(n,2)];
        end
    else
        fprintf('\n')
        fprintf('Your feet are not detected')
    end
    xv=XValues([2:end 1]);
    yv=YValues([2:end 1]);
    aa = XValues.*yv - xv.*YValues; 
    A = sum( aa ) /2;
    xc = sum( (XValues+xv).*aa  ) /6/A;
    yc = sum( (YValues+yv).*aa  ) /6/A;
    plot(XValues,YValues,'m')
    fill(XValues,YValues,'c')
    hold on
    plot(xc,yc,'b+',sacral(1),sacral(2),'ro')
    grid ON
    xlim ([-120 120])  % can change the limits of the graph once larger area is being used 
    ylim ([-120 50]) 
    InitialTime = InitialTime +1;
    drawnow;
    hold off 
end
