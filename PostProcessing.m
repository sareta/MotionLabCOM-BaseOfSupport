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
%{
storage1(:,1)=storage1(:,1)/2.54;
storage1(:,2)=storage1(:,2)/2.54;
storage1(:,3)=storage1(:,3)/2.54;
storage2(:,1)=storage2(:,1)/2.54;
storage2(:,2)=storage2(:,2)/2.54;
storage2(:,3)=storage2(:,3)/2.54;
storage3(:,1)=storage3(:,1)/2.54;
storage3(:,2)=storage3(:,2)/2.54;
storage3(:,3)=storage3(:,3)/2.54;
%}
lefttoe = 3.75;
leftheel = 6.75; 
leftoutside = 2.5;
leftinner = 1.375;

righttoe = 3.75;
rightheel = 6.75;
rightoutside = 2.5;
rightinner = 1.375;
for i=1:74
    %{
    R = (storage1(i,4)-0);   %alpha angle for left foot
    S = (storage2(i,4)-0);   %alpha angle for right foot 
    T = (storage3(i,4)-0);   %alpha angle for sacral marker
    %}
    n=1;
    
    az1 = storage1(i,4);
    el1 = storage1(i,5);
    rol1= storage1(i,6);
    az2 = storage2(i,4);
    el2 = storage2(i,5);
    rol2= storage2(i,6);
    az3 = storage3(i,4);
    el3 = storage3(i,5);
    rol3= storage3(i,6);
    
    topleft_new(n,1) = storage1(i,1)+lefttoe*cosd(el1)*cosd(az1);
    topleft_new(n,2) = storage1(i,2)+lefttoe*sind(az1);
    bottomleft_new(n,1) = storage1(i,1)-leftheel*cosd(el1)*cosd(az1);
    bottomleft_new(n,2) = storage1(i,2)-leftheel*sind(az1);
    rightleft_new(n,1) = storage1(i,1)-leftinner*sind(az1);
    rightleft_new(n,2) = storage1(i,2)+leftinner*cosd(rol1)*cosd(az1);
    leftleft_new(n,1) = storage1(i,1)+leftoutside*sind(az1);
    leftleft_new(n,2) = storage1(i,2)-leftoutside*cosd(az1)*cosd(rol1);
    
    topright_new(n,1) = storage3(i,1)+righttoe*cosd(el3)*cosd(az3);
    topright_new(n,2)= storage3(i,2)+righttoe*sind(az3);
    bottomright_new(n,1) = storage3(i,1)-leftheel*cosd(el3)*cosd(az3);
    bottomright_new(n,2) = storage3(i,2)-leftheel*sind(az3);
    rightright_new(n,1) = storage3(i,1)-leftinner*sind(az3);
    rightright_new(n,2) = storage3(i,2)+leftinner*cosd(rol3)*cosd(az3);
    leftright_new(n,1) = storage3(i,1)+leftoutside*sind(az3);
    leftright_new(n,2) = storage3(i,2)-leftoutside*cosd(az3)*cosd(rol3);
    %}
    %{
    topleft = [storage1(i,1), storage1(i,2)+ lefttoe];             
    bottomleft = [storage1(i,1), storage1(i,2)-leftheel];                  
    rightleft = [ storage1(i,1)+leftoutside, storage1(i,2)];        
    leftleft= [storage1(i,1)-leftinner, storage1(i,2)];         
    
    topright=[storage3(i,1), storage3(i,2)+ righttoe];       
    bottomright=[storage3(i,1), storage3(i,2)- rightheel];
    rightright=[storage3(i,1)-rightinner, storage3(i,2)];
    leftright= [storage3(i,1)+rightoutside, storage3(i,2)];
    
    sitleft = [storage2(i,1)+ leftglute, storage2(i,2)];         %offset for when they are sitting down
    sitright = [storage2(i,1)-rightglute, storage2(i,2)];
    
    kneeleftout= [storage1(i,1)+1.5, storage1(i,2)-leftknee]; %left knee outer point 
    kneerightout= [storage3(i,1)-1.5, storage3(i,2)-rightknee]; %right knee outer point 
    
    topleft_new(n,1) = (((topleft(n,1)-storage1(i,1))*cosd(R)) - ((topleft(n,2)-storage1(i,2))*sind(R))) + storage1(i,1) ;
    topleft_new(n,2) = (((topleft(n,1)-storage1(i,1))*sind(R)) + ((topleft(n,2)-storage1(i,2))*cosd(R))) + storage1(i,2) ;
    bottomleft_new(n,1) = (((bottomleft(n,1)-storage1(i,1))*cosd(R)) - ((bottomleft(n,2)-storage1(i,2))*sind(R))) +storage1(i,1);
    bottomleft_new(n,2) = (((bottomleft(n,1)-storage1(i,1))*sind(R)) + ((bottomleft(n,2)-storage1(i,2))*cosd(R))) + storage1(i,2) ;
    rightleft_new(n,1) = (((rightleft(n,1)-storage1(i,1))*cosd(R)) - ((rightleft(n,2)-storage1(i,2))*sind(R))) + storage1(i,1);
    rightleft_new(n,2) = (((rightleft(n,1)-storage1(i,1))*sind(R)) + ((rightleft(n,2)-storage1(i,2))*cosd(R))) + storage1(i,2) ;
    leftleft_new(n,1) = (((leftleft(n,1)-storage1(i,1))*cosd(R)) - ((leftleft(n,2)-storage1(i,2))*sind(R))) + storage1(i,1);
    leftleft_new(n,2) = (((leftleft(n,1)-storage1(i,1))*sind(R)) + ((leftleft(n,2)-storage1(i,2))*cosd(R))) + storage1(i,2) ;
    
    topright_new(n,1) = (((topright(n,1)-storage3(i,1))*cosd(S)) - ((topright(n,2)-storage3(i,2))*sind(S))) + storage3(i,1)  ;
    topright_new(n,2)= (((topright(n,1)-storage3(i,1))*sind(S)) + ((topright(n,2)-storage3(i,2))*cosd(S))) +storage3(i,2) ;
    bottomright_new(n,1) =(((bottomright(n,1)-storage3(i,1))*cosd(S)) - ((bottomright(n,2)-storage3(i,2))*sind(S))) + storage3(i,1);
    bottomright_new(n,2)= (((bottomright(n,1)-storage3(i,1))*sind(S)) + ((bottomright(n,2)-storage3(i,2))*cosd(S))) +storage3(i,2);
    rightright_new(n,1)= (((rightright(n,1)-storage3(i,1))*cosd(S)) - ((rightright(n,2)-storage3(i,2))*sind(S))) + storage3(i,1);
    rightright_new(n,2)= (((rightright(n,1)-storage3(i,1))*sind(S)) + ((rightright(n,2)-storage3(i,2))*cosd(S))) +storage3(i,2);
    leftright_new(n,1)= (((leftright(n,1)-storage3(i,1))*cosd(S)) - ((leftright(n,2)-storage3(i,2))*sind(S))) + storage3(i,1);
    leftright_new(n,2)= (((leftright(n,1)-storage3(i,1))*sind(S)) + ((leftright(n,2)-storage3(i,2))*cosd(S))) +storage3(i,2);
 %}
    
    sacral= [storage2(i,1)+1.2*cosd(el2)*sind(az2)+6*sind(el2)*cosd(rol2),storage2(i,2)+1.2*sind(az2)*cosd(el2)+6*sind(az2)*cosd(rol2)];
    
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
    if position==8
        XValues = [bottomleft_new(n,1) leftleft_new(n,1) topleft_new(n,1) topright_new(n,1) rightright_new(n,1) bottomright_new(n,1) bottomleft_new(n,1)];
        YValues = [bottomleft_new(n,2) leftleft_new(n,2) topleft_new(n,2) topright_new(n,2) rightright_new(n,2) bottomright_new(n,2) bottomleft_new(n,2)];
    elseif position==7
        if LH==1
            XValues = [bottomleft_new(n,1) leftleft_new(n,1) topleft_new(n,1) topright_new(n,1) rightright_new(n,1) leftright_new(n,1) bottomleft_new(n,1)];
            YValues = [bottomleft_new(n,2) leftleft_new(n,2) topleft_new(n,2) topright_new(n,2) rightright_new(n,2) leftright_new(n,2) bottomleft_new(n,2)];
        else
            XValues = [leftright_new(n,1) leftleft_new(n,1) topleft_new(n,1) topright_new(n,1) rightright_new(n,1) bottomright_new(n,1) rightleft_new(n,1)];
            YValues = [leftright_new(n,2) leftleft_new(n,2) topleft_new(n,2) topright_new(n,2) rightright_new(n,2) bottomright_new(n,2) rightleft_new(n,2)];
        end
    elseif position == 6
        XValues = [leftleft_new(n,1) topleft_new(n,1) topright_new(n,1) rightright_new(n,1) leftright_new(n,1) rightleft_new(n,1) leftleft_new(n,1)];
        YValues = [leftleft_new(n,2) topleft_new(n,2) topright_new(n,2) rightright_new(n,2) leftright_new(n,2) rightleft_new(n,2) leftleft_new(n,2)];
    elseif position == 5
        if LT == 3
            XValues = [bottomleft_new(n,1) leftleft_new(n,1) topleft_new(n,1) rightleft_new(n,1) leftright_new(n,1) rightright_new(n,1) bottomright_new(n,1) bottomleft_new(n,1)];
            YValues = [bottomleft_new(n,2) leftleft_new(n,2) topleft_new(n,2) rightleft_new(n,2) leftright_new(n,2) rightright_new(n,2) bottomright_new(n,2) bottomleft_new(n,2)];
        else
            XValues = [bottomleft_new(n,1) leftleft_new(n,1) rightleft_new(n,1) leftright_new(n,1) topright_new(n,1) rightright_new(n,1) bottomright_new(n,1) bottomleft_new(n,1)];
            YValues = [bottomleft_new(n,2) leftleft_new(n,2) rightleft_new(n,2) leftright_new(n,2) topright_new(n,2) rightright_new(n,2) bottomright_new(n,2) bottomleft_new(n,2)];
        end
    elseif position == 4
        if RT == 3 
            if RH == 1
                XValues = [bottomright_new(n,1) leftright_new(n,1) topright_new(n,1) rightright_new(n,1) bottomright_new(n,1)];
                YValues = [bottomright_new(n,2) leftright_new(n,2) topright_new(n,2) rightright_new(n,2) bottomright_new(n,2)];
            else
                XValues = [bottomleft_new(n,1) leftleft_new(n,1) rightleft_new(n,1) topright_new(n,1) rightright_new(n,1) leftright_new(n,1) bottomleft_new(n,1)];
                YValues = [bottomleft_new(n,2) leftleft_new(n,2) rightleft_new(n,2) topright_new(n,2) rightright_new(n,2) leftright_new(n,2) bottomleft_new(n,2)];
            end
        else
            if LH == 1
                XValues = [bottomleft_new(n,1) leftleft_new(n,1) topleft_new(n,1) rightleft_new(n,1) bottomleft_new(n,1)];
                YValues = [bottomleft_new(n,2) leftleft_new(n,2) topleft_new(n,2) rightleft_new(n,2) bottomleft_new(n,2)];
            else
                XValues = [rightleft_new(n,1) leftleft_new(n,1) topleft_new(n,1) leftright_new(n,1) rightright_new(n,1) bottomright_new(n,1) rightleft_new(n,1)];
                YValues = [rightleft_new(n,2) leftleft_new(n,2) topleft_new(n,2) leftright_new(n,2) rightright_new(n,2) bottomright_new(n,2) rightleft_new(n,2)];
            end
        end
    elseif position == 3
        if RT == 3
            XValues = [leftright_new(n,1) topright_new(n,1) rightright_new(n,1) leftright_new(n,1)];
            YValues = [leftright_new(n,2) topright_new(n,2) rightright_new(n,2) leftright_new(n,2)];
        else
            XValues = [leftleft_new(n,1) topleft_new(n,1) rightleft_new(n,1) leftleft_new(n,1)];
            YValues = [leftleft_new(n,2) topleft_new(n,2) rightleft_new(n,2) leftleft_new(n,2)];
        end
    elseif position == 2
        XValues = [bottomleft_new(n,1) leftleft_new(n,1) rightleft_new(n,1) leftright_new(n,1) rightright_new(n,1) bottomright_new(n,1) bottomleft_new(n,1)];
        YValues = [bottomleft_new(n,2) leftleft_new(n,2) rightleft_new(n,2) leftright_new(n,2) rightright_new(n,2) bottomright_new(n,2) bottomleft_new(n,2)];
    elseif position == 1
        if RH == 1
            XValues = [bottomright_new(n,1) leftright_new(n,1) rightright_new(n,1) bottomright_new(n,1)];
            YValues = [bottomright_new(n,2) leftright_new(n,2) rightright_new(n,2) bottomright_new(n,2)];
        else
            XValues = [bottomleft_new(n,1) leftleft_new(n,1) rightleft_new(n,1) bottomleft_new(n,1)];
            YValues = [bottomleft_new(n,2) leftleft_new(n,2) rightleft_new(n,2) bottomleft_new(n,2)];
        end
    else
        XValues=[];
        YValues=[];
        fprintf('\n')
        fprintf('Your feet are not detected')
    end
    plot(XValues,YValues,'m*')
    hold on
    if position > 0
        xv=XValues([2:end 1]);
        yv=YValues([2:end 1]);
        aa = XValues.*yv - xv.*YValues; 
        A = sum( aa ) /2;
        xc = sum( (XValues+xv).*aa  ) /6/A;
        yc = sum( (YValues+yv).*aa  ) /6/A;
        RawXValues = [bottomleft_new(n,1) leftleft_new(n,1) topleft_new(n,1) topright_new(n,1) rightright_new(n,1) bottomright_new(n,1) bottomleft_new(n,1)];
        RawYValues = [bottomleft_new(n,2) leftleft_new(n,2) topleft_new(n,2) topright_new(n,2) rightright_new(n,2) bottomright_new(n,2) bottomleft_new(n,2)];
        fill(XValues,YValues,'c')
        hold on
        plot(xc,yc,'b+',RawXValues,RawYValues,'m*')
        hold on
        plot(sacral(1),sacral(2),'ro',storage2(i,1),storage2(i,2),'ko')
    else
        xc=0;
        yc=0;
    end 
    grid ON
    hold off
    xlim ([-70 10])  % can change the limits of the graph once larger area is being used 
    ylim ([-10 70])
    title('Position of Center of Base of Support and Center of Mass')
    xlabel('X Position (in)')
    ylabel('Y Position (in)')
    drawnow;
    COMtoBOSdistance(i,1) = ((sacral(1)-xc).^2+(sacral(2)-yc).^2).^(1/2);
    pause(.5)
end
%plot(1:1:49,COMtoBOSdistance,'k');