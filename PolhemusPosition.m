
clear, clc
%change for different files
data = xlsread('julia_gardentest1.xlsx');

totalFrames = size(data, 1);

%intialize the marker matrices
markerOne = zeros(totalFrames/3, 6);
markerTwo = zeros(totalFrames/3, 6);
markerThree = zeros(totalFrames/3, 6);

for i = 1:totalFrames/3 %a third of the row size
    markerOne(i,1) = data(i*3-2, 5);   
    markerOne(i,2) = data(i*3-2, 6);
    markerOne(i,3) = data(i*3-2, 7)*-1;
    markerOne(i,4) = data(i*3-2, 8);   
    markerOne(i,5) = data(i*3-2, 9);
    markerOne(i,6) = data(i*3-2, 10);
    
    markerTwo(i,1) = data(i*3-1, 5);   
    markerTwo(i,2) = data(i*3-1, 6);
    markerTwo(i,3) = data(i*3-1, 7)*-1;
    markerTwo(i,4) = data(i*3-1, 8);   
    markerTwo(i,5) = data(i*3-1, 9);
    markerTwo(i,6) = data(i*3-1, 10);
    
    markerThree(i,1) = data(i*3, 5);   
    markerThree(i,2) = data(i*3, 6);
    markerThree(i,3) = data(i*3, 7)*-1;
    markerThree(i,4) = data(i*3, 8);   
    markerThree(i,5) = data(i*3, 9);
    markerThree(i,6) = data(i*3, 10);
end


for j =  1:totalFrames/3  
     %calclates the distance between the feet 
    left_right_foot= [markerOne(j,2), markerOne(j,1), markerOne(j,3); markerThree(j,2), markerThree(j,1), markerThree(j,3)] ;     
    dist_feet(j,:) = pdist(left_right_foot,'euclidean');   
    
    zero(j,1) = 0;
end

feet_sacral_dist = [dist_feet,markerTwo(:,3),markerOne(:,6),markerThree(:,6), zero ]; %distance between feet, scaral height, roll angles for feet

figure(1) %height of the scarcal marker vs distance between the feet 
cla;
frame = 1:totalFrames/3;

plot (frame, markerTwo(:,3), 'b-') %height of the scaracl marker vs frame
hold on 
plot (frame,dist_feet, 'm-') % distance between the feet vs frame 
    % the blue line is the height of the sacral marker
    % pink line is distance between the feet 

xlabel('Frame #')
ylabel('Distance (in)')
legend('Sacrum Height','Distance Between Feet')
%=====================================================================

% This loop sorts the data into the various positions 
% when the data is taken in centimeters the values in the if statments should be converted to centimete as well
for k=1:totalFrames/3;
    
 if feet_sacral_dist(k,2) > 30  % or 76.2 cm for when the data is in cm
     standing(k,:) = feet_sacral_dist(k,:);
 else
     standing(k,:) = [0,0,0,0,0];
 end
 
  if feet_sacral_dist(k,1) < 15 && feet_sacral_dist(k,2) < 30 % 15 in = 38.1 cm  |   30 in = 76.2 cm
     full_kneeling(k,:) = feet_sacral_dist(k,:);
 else
     full_kneeling(k,:) = [0,0,0,0,0];
  end
  
  if full_kneeling(k,3) >100 | full_kneeling(k,3) < -100 | full_kneeling(k,4) >100 | full_kneeling(k,4) < -100  % !!! No conversion nessesary. The values in this statment are angles, not distances
      full_kneel(k,:) = full_kneeling(k,:);
  else 
      full_kneel(k,:) = [0,0,0,0,0];
  end 
 
 if feet_sacral_dist(k,1) > 20    && feet_sacral_dist(k,2) < 30 %  20 in = 50.8 cm       30 in = 76.2 cm
     oneleg_kneeling(k,:) = feet_sacral_dist(k,:);
 else
     oneleg_kneeling(k,:) = [0,0,0,0,0];
 end
 
 if feet_sacral_dist(k,1)< 25 && feet_sacral_dist(k,2) < 30    % 20 in = 50.8 cm       30 in = 76.2 cm
    sitting(k,:) = feet_sacral_dist(k,:);
 else
     sitting(k,:) = [0,0,0,0,0];
 end
 
 if sitting(k,3) < 55 && sitting(k,3) > -55 && sitting(k,4) > -55 && sitting(k,4) < 55  % These values are angles no need to convert. 
    sit(k,:) = sitting(k,:);
 else
    sit(k,:) = [0,0,0,0,0];

 end
end

 standing(standing == 0) = NaN;
 full_kneel(full_kneel == 0) = NaN;
 oneleg_kneeling(oneleg_kneeling == 0) = NaN;
 sit(sit == 0) = NaN;
 
 % Same as above graph but the different colors represent the different positions 
 figure(2)
 cla;
plot(frame, standing(:,1),'c-')   %light blue = standing 
 hold on 
plot (frame, standing(:,2),'c-')
hold on
 plot(frame, full_kneel(:,1),'m-')  % pink = full kneeling 
hold on 
 plot (frame, full_kneel(:,2),'m-')
hold on 
 plot(frame, oneleg_kneeling(:,1),'b-')   % dark blue = halk kneeling / kneeling on one leg
hold on 
 plot (frame, oneleg_kneeling(:,2),'b-')
hold on 
 plot (frame, sit(:,1),'g-')        % green = sitting     
hold on 
 plot (frame, sit(:,2),'g-')
 
xlabel('Frame #')
ylabel('Distance (in)') % chnage when the data inin centmeters 
legend('Stand/Walk',' ', 'Full Kneel', ' ', 'Half Kneel', ' ','Sit', ' ' ) 
% conversions needed when data is in cm 
  for m=1:totalFrames/3;
    
 if feet_sacral_dist(m,2) > 32  %standing = 1   // convert
     feet_sacral_dist(m,5) = 1;
 end
  
  if feet_sacral_dist(m,1) < 15 && feet_sacral_dist(m,2) < 30 %full kneel = 2   //convert 
       if feet_sacral_dist(m,3) >100 | feet_sacral_dist(m,3) < -100 | feet_sacral_dist(m,4) >100 | feet_sacral_dist(m,4) < -100  %// do not convert
          feet_sacral_dist(m,5) = 2;
      end
  end 
 
 if feet_sacral_dist(m,1) > 20  && feet_sacral_dist(m,2) < 30   %half kneel  =3  // convert
     feet_sacral_dist(m,5) = 3;
 end
 
 if feet_sacral_dist(m,1)< 25 && feet_sacral_dist(m,2) < 30   %sit =4   // convert
     if feet_sacral_dist(m,3) < 55 && feet_sacral_dist(m,3) > -55 && feet_sacral_dist(m,4) > -55 && feet_sacral_dist(m,4) < 55 %// do not convert
    feet_sacral_dist(m,5) = 4;  
     end
 end 
end

%counters

count_sit= 0;
count_fullkneel=0;
count_halfkneel=0;
count_stand = 0;   % this is really standing and walking

% This loop calaclates the number of time a person going into a position 

for n= 1:totalFrames/3;
 if n+1 < totalFrames/3
     if feet_sacral_dist(n,5)== 0 && feet_sacral_dist(n+1,5) == 4
         count_sit= 1+ count_sit;
     end 
    if feet_sacral_dist(n,5)==0 && feet_sacral_dist(n+1,5) == 2
     count_fullkneel= 1 + count_fullkneel;
    end 
    if feet_sacral_dist(n,5)==0 && feet_sacral_dist(n+1,5) == 3
     count_halfkneel= 1 + count_halfkneel;
    end 
    if feet_sacral_dist(n,5)==0 && feet_sacral_dist(n+1,5) == 1
     count_stand= 1 + count_stand;
    end 
 end
end 

sit2stand=0;
stand2sit=0;

%========================================

% this section calucates how long someone is in a position. 
% Time is in seconds 
kneeltime=0;
halfkneeltime=0;
sittime=0;
standtime=0;

for p= 1:totalFrames/3;
    if feet_sacral_dist(p,5)== 2
       kneeltime = 1+ kneeltime;
    end 
    if feet_sacral_dist(p,5)== 3
       halfkneeltime = 1+ halfkneeltime;
    end 
    if feet_sacral_dist(p,5)== 4
       sittime = 1+ sittime;
    end 
     if feet_sacral_dist(p,5)== 1
       standtime = 1+ standtime;
    end 
end

time_fullkneel = kneeltime*(1/120);   %time in seconds 
time_halfkneel = halfkneeltime*(1/120);
time_sit= sittime*(1/120);
time_stand = standtime*(1/120);


% figuring out the transitions 
%The zeros in the fifth column of the "feet_sacral_dist" matrix represent transitions between positions
%There number of zeros in not consistent between transitions so i need a way to by pass the zeros without getting a error message 

stand2sit=0;

for o = 1:totalFrames/3 - 35   %this needs work
   if feet_sacral_dist(o,5)== 1 && feet_sacral_dist(o+5,5) == 4
         stand2sit= 1+ stand2sit;
   elseif feet_sacral_dist(o,5) == 1 && feet_sacral_dist(o+10,5) == 4
         stand2sit= 1+ stand2sit;
   elseif feet_sacral_dist(o,5)== 1 && feet_sacral_dist(o+20,5) == 4
         stand2sit= 1+ stand2sit;
   elseif feet_sacral_dist(o,5)== 1 && feet_sacral_dist(o+35,5) == 4
         stand2sit= 1+ stand2sit;
     end  
end 
  
count_time= [count_stand time_stand; count_sit time_sit; count_fullkneel time_fullkneel; count_halfkneel time_halfkneel];
c = categorical({'stand','sit ','full kneel','half kneel' });

%Bar graph of time and number count 
% may want this data dispalyed in two sepatre graphs as the time periods get longer 

figure(3)
cla;
bar(c,count_time)
legend('Count','Time(s)')


