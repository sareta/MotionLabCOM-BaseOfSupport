%{
By: Siniva Areta
This code takes data collected from the code 'RawDataCollection.m' and
processes it into an animation. 
%}

%This portion of the code asks the user for the measurements that are used
%to locate positions of the feet (L/R Toes, L/R Heels, LR Sides). 
%{
lefttoe = input('Distance from sensor to left toe: '); % top of the foot where the toe is
leftheel = input('Distance from sensor to left heel: ');% the heel 
leftoutside= input('Distance from sensor to the outside of the left foot: '); % the outer part of the left foot
leftinner = input('Distance from sensor to the inside of the left foot: ');  % the inner part of the left foot

righttoe = input('Distance from sensor to right toe: ');
rightheel = input('Distance from sensor to right heel: ');
rightoutside = input('Distance from sensor to outside of right foot: ');  % the outer part of the right foot
rightinner = input('Distance from sensor to inside of right foot: '); % the inner part of the right foot
%}
%This portion of the code works if you're processing data from the same
%person. This allows you to put in the values without doing the input every
%time. Note that the description of the distances can be found in the guide
%as well as in the input calls.
lefttoe = 2.651;
leftheel = 8.584; 
leftoutside = 2.225;
leftinner = 1.865;

righttoe = 3.046;
rightheel = 8.248;
rightoutside = 2.059;
rightinner = 2.148;

bottomright_new=[];
topright_new=[];
rightright_new=[];
leftright_new=[];
bottomleft_new=[];
topleft_new=[];
rightleft_new=[];
leftleft_new=[];

LToeMin=0;
LHeelMin=0;
RToeMin=0;
RHeelMin=0;

%This creates a for loop that creates frames in the animation for each of
%the captures. It finds the size of your capture using the storage values
%from 'RawDataCollection.m'
for i=1:size(storage1,1)
    %This creates variables to call for the Euler orientation angles for 
    %each sensor for each frame. Each angle has an abreviation of the angle 
    %followed by the number of the sensor it refers to.
    %az=Azimuth (+x to +y), el=Elevation (+z to +x), rol=Roll (+y to +z) 
    az1 = storage1(i,4);
    el1 = storage1(i,5);
    rol1= storage1(i,6);
    az2 = storage2(i,4);
    el2 = storage2(i,5);
    rol2= storage2(i,6);
    az3 = storage3(i,4);
    el3 = storage3(i,5);
    rol3= storage3(i,6);
    
    %This creates XY coordinates for each point of interest in the foot. It
    %relies on the location of the sensors' electromagnetic center as well
    %as the angles that describe the relationship between the coordinate
    %reference frames of the sources and the sensors. When these matricies
    %are complete, the row number will identify the frame, column 1 will be
    %the x position, and column 2 will be the y position. 
    topleft_new(i,1) = storage1(i,1)+lefttoe*cosd(az1);%cosd(el1)*
    topleft_new(i,2) = storage1(i,2)+lefttoe*sind(az1);%*cosd(el1)
    bottomleft_new(i,1) = storage1(i,1)-leftheel*cosd(az1);%*cosd(el1)
    bottomleft_new(i,2) = storage1(i,2)-leftheel*sind(az1);%*cosd(el1)
    %Note: Because the toe and heel are alligned with the x direction of 
    %the sensor, the roll angle does not effect the XY location of the toe
    %and heel.
    rightleft_new(i,1) = storage1(i,1)-leftinner*sind(az1);%*cosd(rol1)
    rightleft_new(i,2) = storage1(i,2)+leftinner*cosd(az1);%*cosd(rol1)
    leftleft_new(i,1) = storage1(i,1)+leftoutside*sind(az1);%*cosd(rol1)
    leftleft_new(i,2) = storage1(i,2)-leftoutside*cosd(az1);%*cosd(rol1)
    %Note: Because the sides of the foot are alligned with the y direction 
    %of the sensor, the elevation angle does not effect the XY location of 
    %the toe and heel.
    
    topright_new(i,1) = storage3(i,1)+righttoe*cosd(az3);%*cosd(el3)
    topright_new(i,2)= storage3(i,2)+righttoe*cosd(el3)*sind(az3);%
    bottomright_new(i,1) = storage3(i,1)-leftheel*cosd(az3);%*cosd(el3)
    bottomright_new(i,2) = storage3(i,2)-leftheel*sind(az3);%*cosd(el3)
    rightright_new(i,1) = storage3(i,1)-leftinner*sind(az3);%*cosd(rol3)
    rightright_new(i,2) = storage3(i,2)+leftinner*cosd(az3);%*cosd(rol3)
    leftright_new(i,1) = storage3(i,1)+leftoutside*sind(az3);%*cosd(rol3)
    leftright_new(i,2) = storage3(i,2)-leftoutside*cosd(az3);%*cosd(rol3)
    %The right foot has nearly all of the same angular principles as the
    %left foot. See diagram in guide for assistance. 
    
    sacral(i,1) = storage2(i,1)+6*sind(el2)*cosd(az2);%+1.2*cos(el2)*cos(az2);
    sacral(i,2) = storage2(i,2)+6*sind(el2)*sind(az2);%+1.2*cos(el2)*sin(az2);
    %The center of mass is located using the location of the sacral marker
    %(storage2(i,1) and storage2(i,2) and the offset is incorporated with
    %the other part. The offset is in the positive z direction on the
    %sensors and is then translated to X,Y coordinates of the source using
    %angles and trigonometry.
    
    %This portion calls the data from the flexiforce and assigns an on or
    %off value to the variables based on if enough force is being put on
    %that sensor to constitute declaring it to be 'on'. If a toe is 'on'
    %its value will be set to 3. If a heel is 'on', its value will be set
    %to 1. If the heels or toes are 'off', their value will be set to 0.
    if 1000*b(i,1) > LToeMin
        LT=3;
    else
        LT=0;
    end
    if 1000*c(i,1) > LHeelMin
            LH=1;
    else
        LH=0;
    end
    if 1000*e(i,1) > RToeMin
        RT=3;
    else
        RT=0;
    end
    if 1000*d(i,1) > RHeelMin
        RH=1;
    else
        RH=0;
    end
    position=LT+LH+RT+RH;
    %Using the logic of the values, I created a series of if statments that
    %find which configuration the feet are in based on the values of the
    %flexiforce. The code then makes a polygon of the base of support. The
    %details of what points determine the base of support can be found in
    %Ryan Kulwicki's Guide. The line 'set(h,'facealpha',.5)' sets the
    %opacity to 0.5.
    if position==8 %Both Feet on the ground
        XValues = [bottomleft_new(i,1) leftleft_new(i,1) topleft_new(i,1) topright_new(i,1) rightright_new(i,1) bottomright_new(i,1) bottomleft_new(i,1)];
        YValues = [bottomleft_new(i,2) leftleft_new(i,2) topleft_new(i,2) topright_new(i,2) rightright_new(i,2) bottomright_new(i,2) bottomleft_new(i,2)];
        h=fill(XValues,YValues,'k');
        set(h,'facealpha',.5);
        hold on
    elseif position==7
        if LH==1 %Left foot and right toe
            XValues = [bottomleft_new(i,1) leftleft_new(i,1) topleft_new(i,1) topright_new(i,1) rightright_new(i,1) leftright_new(i,1) bottomleft_new(i,1)];
            YValues = [bottomleft_new(i,2) leftleft_new(i,2) topleft_new(i,2) topright_new(i,2) rightright_new(i,2) leftright_new(i,2) bottomleft_new(i,2)];
            h=fill(XValues,YValues,'w');
            set(h,'facealpha',.5);
            hold on
        else %right foot and left toe
            XValues = [leftright_new(i,1) leftleft_new(i,1) topleft_new(i,1) topright_new(i,1) rightright_new(i,1) bottomright_new(i,1) rightleft_new(i,1)];
            YValues = [leftright_new(i,2) leftleft_new(i,2) topleft_new(i,2) topright_new(i,2) rightright_new(i,2) bottomright_new(i,2) rightleft_new(i,2)];
            h=fill(XValues,YValues,'w');
            set(h,'facealpha',.5);
            hold on
        end
    elseif position == 6 %Both toes
        XValues = [leftleft_new(i,1) topleft_new(i,1) topright_new(i,1) rightright_new(i,1) leftright_new(i,1) rightleft_new(i,1) leftleft_new(i,1)];
        YValues = [leftleft_new(i,2) topleft_new(i,2) topright_new(i,2) rightright_new(i,2) leftright_new(i,2) rightleft_new(i,2) leftleft_new(i,2)];
        h=fill(XValues,YValues,'g');
        set(h,'facealpha',.5);
        hold on
    elseif position == 5 
        if LT == 3 %Left foot and right heel
            XValues = [bottomleft_new(i,1) leftleft_new(i,1) topleft_new(i,1) rightleft_new(i,1) leftright_new(i,1) rightright_new(i,1) bottomright_new(i,1) bottomleft_new(i,1)];
            YValues = [bottomleft_new(i,2) leftleft_new(i,2) topleft_new(i,2) rightleft_new(i,2) leftright_new(i,2) rightright_new(i,2) bottomright_new(i,2) bottomleft_new(i,2)];
            h=fill(XValues,YValues,'m');
            set(h,'facealpha',.5);
            hold on
        else %Right foot and left heel
            XValues = [bottomleft_new(i,1) leftleft_new(i,1) rightleft_new(i,1) leftright_new(i,1) topright_new(i,1) rightright_new(i,1) bottomright_new(i,1) bottomleft_new(i,1)];
            YValues = [bottomleft_new(i,2) leftleft_new(i,2) rightleft_new(i,2) leftright_new(i,2) topright_new(i,2) rightright_new(i,2) bottomright_new(i,2) bottomleft_new(i,2)];
            h=fill(XValues,YValues,'m');
            set(h,'facealpha',.5);
            hold on
        end
    elseif position == 4
        if RT == 3 
            if RH == 1 %Right foot only
                XValues = [bottomright_new(i,1) leftright_new(i,1) topright_new(i,1) rightright_new(i,1) bottomright_new(i,1)];
                YValues = [bottomright_new(i,2) leftright_new(i,2) topright_new(i,2) rightright_new(i,2) bottomright_new(i,2)];
                h=fill(XValues,YValues,'c');
                set(h,'facealpha',.5);
                hold on
            else %Right toe, left heel
                XValues = [bottomleft_new(i,1) leftleft_new(i,1) rightleft_new(i,1) topright_new(i,1) rightright_new(i,1) leftright_new(i,1) bottomleft_new(i,1)];
                YValues = [bottomleft_new(i,2) leftleft_new(i,2) rightleft_new(i,2) topright_new(i,2) rightright_new(i,2) leftright_new(i,2) bottomleft_new(i,2)];
                h=fill(XValues,YValues,'y');
                set(h,'facealpha',.5);
                hold on
            end
        else
            if LH == 1 %Left foot only
                XValues = [bottomleft_new(i,1) leftleft_new(i,1) topleft_new(i,1) rightleft_new(i,1) bottomleft_new(i,1)];
                YValues = [bottomleft_new(i,2) leftleft_new(i,2) topleft_new(i,2) rightleft_new(i,2) bottomleft_new(i,2)];
                h=fill(XValues,YValues,'c');
                set(h,'facealpha',.5);
                hold on
            else %Left toe, right heel
                XValues = [rightleft_new(i,1) leftleft_new(i,1) topleft_new(i,1) leftright_new(i,1) rightright_new(i,1) bottomright_new(i,1) rightleft_new(i,1)];
                YValues = [rightleft_new(i,2) leftleft_new(i,2) topleft_new(i,2) leftright_new(i,2) rightright_new(i,2) bottomright_new(i,2) rightleft_new(i,2)];
                h=fill(XValues,YValues,'y');
                set(h,'facealpha',.5);
                hold on
            end
        end
    elseif position == 3
        if RT == 3 %Right toe only
            XValues = [leftright_new(i,1) topright_new(i,1) rightright_new(i,1) leftright_new(i,1)];
            YValues = [leftright_new(i,2) topright_new(i,2) rightright_new(i,2) leftright_new(i,2)];
            h=fill(XValues,YValues,'b');
            set(h,'facealpha',.5);
            hold on
        else %Left toe only
            XValues = [leftleft_new(i,1) topleft_new(i,1) rightleft_new(i,1) leftleft_new(i,1)];
            YValues = [leftleft_new(i,2) topleft_new(i,2) rightleft_new(i,2) leftleft_new(i,2)];
            h=fill(XValues,YValues,'b');
            set(h,'facealpha',.5);
            hold on
        end
    elseif position == 2 %Both heels
        XValues = [bottomleft_new(i,1) leftleft_new(i,1) rightleft_new(i,1) leftright_new(i,1) rightright_new(i,1) bottomright_new(i,1) bottomleft_new(i,1)];
        YValues = [bottomleft_new(i,2) leftleft_new(i,2) rightleft_new(i,2) leftright_new(i,2) rightright_new(i,2) bottomright_new(i,2) bottomleft_new(i,2)];
        h=fill(XValues,YValues,'r');
        set(h,'facealpha',.5);
        hold on
    elseif position == 1
        if RH == 1 %Right heel only
            XValues = [bottomright_new(i,1) leftright_new(i,1) rightright_new(i,1) bottomright_new(i,1)];
            YValues = [bottomright_new(i,2) leftright_new(i,2) rightright_new(i,2) bottomright_new(i,2)];
            h=fill(XValues,YValues,'b');
            set(h,'facealpha',.5);
            hold on
        else %Left heel only
            XValues = [bottomleft_new(i,1) leftleft_new(i,1) rightleft_new(i,1) bottomleft_new(i,1)];
            YValues = [bottomleft_new(i,2) leftleft_new(i,2) rightleft_new(i,2) bottomleft_new(i,2)];
            h=fill(XValues,YValues,'b');
            set(h,'facealpha',.5);
            hold on
        end
    else %No foot detection
        XValues=[];
        YValues=[];
        fprintf('\n')
        fprintf('Your feet are not detected')
    end
    %Plots raw values of each foot point regardless of whether or not it is
    %in contact with the ground. 
    plot(XValues,YValues,'m*')
    hold on
    %If the feet are detected, this portion locates the center of the base
    %of support. This code was found by Dr. Ann Reinthal and is a basic
    %code for finding the center of a centroid. 
    if position > 0
        xv=XValues([2:end 1]);
        yv=YValues([2:end 1]);
        aa = XValues.*yv - xv.*YValues; 
        A = sum( aa ) /2;
        xc = sum( (XValues+xv).*aa  ) /6/A;
        yc = sum( (YValues+yv).*aa  ) /6/A;
        RawXValues = [bottomleft_new(i,1) leftleft_new(i,1) topleft_new(i,1) topright_new(i,1) leftright_new(i,1) rightleft_new(i,1) rightright_new(i,1) bottomright_new(i,1) bottomleft_new(i,1)];
        RawYValues = [bottomleft_new(i,2) leftleft_new(i,2) topleft_new(i,2) topright_new(i,2) leftright_new(i,2) rightleft_new(i,2) rightright_new(i,2) bottomright_new(i,2) bottomleft_new(i,2)];
        %Plots center of base of support
        plot(xc,yc,'b+',RawXValues,RawYValues,'k*')
        hold on
        %Plots center of mass
        plot(sacral(i,1),sacral(i,2),'ro')
    else
        %If no feet are detected, the center of the base of support is set 
        %to (0,0) and it is not plotted.
        xc=0;
        yc=0;
    end 
    %Turns on grid
    grid ON
    %Sets window boundaries
    xlim ([-25 0])  % can change the limits of the graph once larger area is being used 
    ylim ([-30 80])
    %Sets title and axis labels
    title('Position of Center of Base of Support and Center of Mass')
    xlabel('X Position (in)')
    ylabel('Y Position (in)')
    %Draws grid
    drawnow;
    %Turns off the data from this frame so new data from the next frame can
    %be plotted seperately.
    hold off
    %Solves for the distance between the COM and COBOS and logs it into a
    %matrix where each row represents a different frame.
    COMtoBOSdistance(i,1) = ((sacral(1)-xc).^2+(sacral(2)-yc).^2).^(1/2);
    %This delays the code before running the next frame.
    pause(.1)
end
%plot(1:1:49,COMtoBOSdistance,'k');