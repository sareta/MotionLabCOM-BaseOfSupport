hold off
n=0
for i=[2 66 74 85 150]
    az1 = storage1(i,4);
    el1 = storage1(i,5);
    rol1= storage1(i,6);
    az2 = storage2(i,4);
    el2 = storage2(i,5);
    rol2= storage2(i,6);
    az3 = storage3(i,4);
    el3 = storage3(i,5);
    rol3= storage3(i,6);
    
    topleft_new(i,1) = storage1(i,1)+lefttoe*cosd(el1)*cosd(az1);
    topleft_new(i,2) = storage1(i,2)+lefttoe*sind(az1);
    bottomleft_new(i,1) = storage1(i,1)-leftheel*cosd(el1)*cosd(az1);
    bottomleft_new(i,2) = storage1(i,2)-leftheel*sind(az1);
    rightleft_new(i,1) = storage1(i,1)-leftinner*sind(az1);
    rightleft_new(i,2) = storage1(i,2)+leftinner*cosd(rol1)*cosd(az1);
    leftleft_new(i,1) = storage1(i,1)+leftoutside*sind(az1);
    leftleft_new(i,2) = storage1(i,2)-leftoutside*cosd(az1)*cosd(rol1);
    
    topright_new(i,1) = storage3(i,1)+righttoe*cosd(el3)*cosd(az3);
    topright_new(i,2)= storage3(i,2)+righttoe*sind(az3);
    bottomright_new(i,1) = storage3(i,1)-leftheel*cosd(el3)*cosd(az3);
    bottomright_new(i,2) = storage3(i,2)-leftheel*sind(az3);
    rightright_new(i,1) = storage3(i,1)-leftinner*sind(az3);
    rightright_new(i,2) = storage3(i,2)+leftinner*cosd(rol3)*cosd(az3);
    leftright_new(i,1) = storage3(i,1)+leftoutside*sind(az3);
    leftright_new(i,2) = storage3(i,2)-leftoutside*cosd(az3)*cosd(rol3);
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
    
    sacral(i,:)= [storage2(i,1)+6*sind(el2)*cosd(az2),storage2(i,2)+6*sind(el2)*sind(az2)]; 
    
    RawXValues(i,:) = [bottomleft_new(i,1) leftleft_new(i,1) topleft_new(i,1) topright_new(i,1) leftright_new(i,1) rightleft_new(i,1) rightright_new(i,1) bottomright_new(i,1) bottomleft_new(i,1)];
    RawYValues(i,:) = [bottomleft_new(i,2) leftleft_new(i,2) topleft_new(i,2) topright_new(i,2) leftright_new(i,2) rightleft_new(i,2) rightright_new(i,2) bottomright_new(i,2) bottomleft_new(i,2)];
    
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
        XValuesPosition8(i,:) = [bottomleft_new(i,1) leftleft_new(i,1) topleft_new(i,1) topright_new(i,1) rightright_new(i,1) bottomright_new(i,1) bottomleft_new(i,1)];
        YValuesPosition8(i,:) = [bottomleft_new(i,2) leftleft_new(i,2) topleft_new(i,2) topright_new(i,2) rightright_new(i,2) bottomright_new(i,2) bottomleft_new(i,2)];
        XValues = [bottomleft_new(i,1) leftleft_new(i,1) topleft_new(i,1) topright_new(i,1) rightright_new(i,1) bottomright_new(i,1) bottomleft_new(i,1)];
        YValues = [bottomleft_new(i,2) leftleft_new(i,2) topleft_new(i,2) topright_new(i,2) rightright_new(i,2) bottomright_new(i,2) bottomleft_new(i,2)];
        if i==2
            plot(XValuesPosition8(2,:),YValuesPosition8(2,:),'y*');
            bruteforceh1=fill(XValuesPosition8(2,:),YValuesPosition8(2,:),'w');
            set(bruteforceh1,'facealpha',.5);
            hold on
        else
            bruteforceh2=fill(XValuesPosition8(150,:),YValuesPosition8(150,:),'k');
            set(bruteforceh2,'facealpha',.5);
            plot(XValuesPosition8(150,:),YValuesPosition8(150,:),'k*');
            hold on
        end
    elseif position == 7
        if LH==1
            XValues = [bottomleft_new(i,1) leftleft_new(i,1) topleft_new(i,1) topright_new(i,1) rightright_new(i,1) leftright_new(i,1) bottomleft_new(i,1)];
            YValues = [bottomleft_new(i,2) leftleft_new(i,2) topleft_new(i,2) topright_new(i,2) rightright_new(i,2) leftright_new(i,2) bottomleft_new(i,2)];
            h=fill(XValues,YValues,'g');
            set(h,'facealpha',.5);
            plot(RawXValues(i,:),RawYValues(i,:),'g*')
            hold on
        else
            XValues = [leftright_new(i,1) leftleft_new(i,1) topleft_new(i,1) topright_new(i,1) rightright_new(i,1) bottomright_new(i,1) rightleft_new(i,1)];
            YValues = [leftright_new(i,2) leftleft_new(i,2) topleft_new(i,2) topright_new(i,2) rightright_new(i,2) bottomright_new(i,2) rightleft_new(i,2)];
            h=fill(XValues,YValues,'g');
            set(h,'facealpha',.5);
            plot(RawXValues(i,:),RawYValues(i,:),'g*')
            hold on
        end
    elseif position == 6
        XValues = [leftleft_new(i,1) topleft_new(i,1) topright_new(i,1) rightright_new(i,1) leftright_new(i,1) rightleft_new(i,1) leftleft_new(i,1)];
        YValues = [leftleft_new(i,2) topleft_new(i,2) topright_new(i,2) rightright_new(i,2) leftright_new(i,2) rightleft_new(i,2) leftleft_new(i,2)];
        h=fill(XValues,YValues,'b');
        set(h,'facealpha',.5);
        plot(RawXValues(i,:),RawYValues(i,:),'b*')
        hold on
    elseif position == 5
        if LT == 3
            XValues = [bottomleft_new(i,1) leftleft_new(i,1) topleft_new(i,1) rightleft_new(i,1) leftright_new(i,1) rightright_new(i,1) bottomright_new(i,1) bottomleft_new(i,1)];
            YValues = [bottomleft_new(i,2) leftleft_new(i,2) topleft_new(i,2) rightleft_new(i,2) leftright_new(i,2) rightright_new(i,2) bottomright_new(i,2) bottomleft_new(i,2)];
            h=fill(XValues,YValues,'b');
            set(h,'facealpha',.5);
            plot(RawXValues(i,:),RawYValues(i,:),'b*')
            hold on
        else
            XValues = [bottomleft_new(i,1) leftleft_new(i,1) rightleft_new(i,1) leftright_new(i,1) topright_new(i,1) rightright_new(i,1) bottomright_new(i,1) bottomleft_new(i,1)];
            YValues = [bottomleft_new(i,2) leftleft_new(i,2) rightleft_new(i,2) leftright_new(i,2) topright_new(i,2) rightright_new(i,2) bottomright_new(i,2) bottomleft_new(i,2)];
            h=fill(XValues,YValues,'b');
            set(h,'facealpha',.5);
            plot(RawXValues(i,:),RawYValues(i,:),'b*')
            hold on
        end
    elseif position == 4
        if RT == 3 
            if RH == 1
                XValues = [bottomright_new(i,1) leftright_new(i,1) topright_new(i,1) rightright_new(i,1) bottomright_new(i,1)];
                YValues = [bottomright_new(i,2) leftright_new(i,2) topright_new(i,2) rightright_new(i,2) bottomright_new(i,2)];
                h=fill(XValues,YValues,'r');
                set(h,'facealpha',.5);
                plot(RawXValues(i,:),RawYValues(i,:),'r*')
                hold on
            else
                XValues = [bottomleft_new(i,1) leftleft_new(i,1) rightleft_new(i,1) topright_new(i,1) rightright_new(i,1) leftright_new(i,1) bottomleft_new(i,1)];
                YValues = [bottomleft_new(i,2) leftleft_new(i,2) rightleft_new(i,2) topright_new(i,2) rightright_new(i,2) leftright_new(i,2) bottomleft_new(i,2)];
                h=fill(XValues,YValues,'b');
                set(h,'facealpha',.5);
                plot(RawXValues(i,:),RawYValues(i,:),'b*')
                hold on
            end
        else
            if LH == 1
                XValues = [bottomleft_new(i,1) leftleft_new(i,1) topleft_new(i,1) rightleft_new(i,1) bottomleft_new(i,1)];
                YValues = [bottomleft_new(i,2) leftleft_new(i,2) topleft_new(i,2) rightleft_new(i,2) bottomleft_new(i,2)];
                h=fill(XValues,YValues,'g');
                set(h,'facealpha',.5);
                plot(RawXValues(i,:),RawYValues(i,:),'g*')
                hold on
            else
                XValues = [rightleft_new(i,1) leftleft_new(i,1) topleft_new(i,1) leftright_new(i,1) rightright_new(i,1) bottomright_new(i,1) rightleft_new(i,1)];
                YValues = [rightleft_new(i,2) leftleft_new(i,2) topleft_new(i,2) leftright_new(i,2) rightright_new(i,2) bottomright_new(i,2) rightleft_new(i,2)];
                h=fill(XValues,YValues,'w');
                set(h,'facealpha',.5);
                plot(RawXValues(i,:),RawYValues(i,:),'k*')
                hold on
            end
        end
    elseif position == 3
        if RT == 3
            XValues = [leftright_new(i,1) topright_new(i,1) rightright_new(i,1) leftright_new(i,1)];
            YValues = [leftright_new(i,2) topright_new(i,2) rightright_new(i,2) leftright_new(i,2)];
            h=fill(XValues,YValues,'b');
            set(h,'facealpha',.5);
            plot(RawXValues(i,:),RawYValues(i,:),'b*')
            hold on
        else
            XValues = [leftleft_new(i,1) topleft_new(i,1) rightleft_new(i,1) leftleft_new(i,1)];
            YValues = [leftleft_new(i,2) topleft_new(i,2) rightleft_new(i,2) leftleft_new(i,2)];
            h=fill(XValues,YValues,'b');
            set(h,'facealpha',.5);
            plot(RawXValues(i,:),RawYValues(i,:),'b*')
            hold on
        end
    elseif postion == 2
        XValues = [bottomleft_new(i,1) leftleft_new(i,1) rightleft_new(i,1) leftright_new(i,1) rightright_new(i,1) bottomright_new(i,1) bottomleft_new(i,1)];
        YValues = [bottomleft_new(i,2) leftleft_new(i,2) rightleft_new(i,2) leftright_new(i,2) rightright_new(i,2) bottomright_new(i,2) bottomleft_new(i,2)];
        h=fill(XValues,YValues,'b');
        set(h,'facealpha',.5);
        plot(RawXValues(i,:),RawYValues(i,:),'b*')
        hold on
    elseif position == 1
        if RH == 1
            XValues = [bottomright_new(i,1) leftright_new(i,1) rightright_new(i,1) bottomright_new(i,1)];
            YValues = [bottomright_new(i,2) leftright_new(i,2) rightright_new(i,2) bottomright_new(i,2)];
            h=fill(XValues,YValues,'b');
            set(h,'facealpha',.5);
            plot(RawXValues(i,:),RawYValues(i,:),'b*')
            hold on
        else
            XValues = [bottomleft_new(i,1) leftleft_new(i,1) rightleft_new(i,1) bottomleft_new(i,1)];
            YValues = [bottomleft_new(i,2) leftleft_new(i,2) rightleft_new(i,2) bottomleft_new(i,2)];
            h=fill(XValues,YValues,'b');
            set(h,'facealpha',.5);
            plot(RawXValues(i,:),RawYValues(i,:),'b*')
            hold on
        end
    else
        XValues=[];
        YValues=[];
        fprintf('\n')
        fprintf('Your feet are not detected')
    end
    if position > 0
        xv=XValues([2:end 1]);
        yv=YValues([2:end 1]);
        aa = XValues.*yv - xv.*YValues; 
        A = sum( aa ) /2;
        xc(i,1) = sum( (XValues+xv).*aa  ) /6/A;
        yc(i,1) = sum( (YValues+yv).*aa  ) /6/A;
        %hold off
    else
        xc(i,1)=0;
        yc(i,2)=0;
    end 
    grid ON
    %hold off
    xlim ([-35 25])  % can change the limits of the graph once larger area is being used 
    ylim ([-10 70])
    drawnow;
    %COMtoBOSdistance(i,1) = ((sacral(1)-xc).^2+(sacral(2)-yc).^2).^(1/2);
    pause(.1)
    n=n+1
end
COBOSx=[xc(2,1) xc(66,1) xc(74,1) xc(85,1) xc(150,1)];
COBOSy=[yc(2,1) yc(66,1) yc(74,1) yc(85,1) yc(150,1)];
sacralX=[sacral(2,1) sacral(66,1) sacral(74,1) sacral(85,1) sacral(150,1)];
sacralY=[sacral(2,2) sacral(66,2) sacral(74,2) sacral(85,2) sacral(150,2)];
%h1=fill(XValuesPosition8(2,:),YValuesPosition8(2,:),'k')
%set(h1,'facealpha',.5)
plot(sacralX,sacralY,'m.','MarkerSize',15)
hold on
plot(COBOSx,COBOSy,'c+','MarkerSize',5)
hold on
%set(get(get(h15,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
title('Position of COBOS and Center of Mass during walking')
xlabel('X Position (in)')
ylabel('Y Position (in)')
legend('A. BOS-Both Feet (Initial)','B. BOS-Right Foot','B. Foot Locations-Right Foot','B. BOS-Transitioning Feet','B. Foot Locations-Transitioning Feet','B. BOS-Left Foot','B. Foot Locations-Left Foot','C. BOS-Both Feet (Final)','C. Foot Locations-Standing Both Feet','COM','COBOS')