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

a = (markerOne(:,4)-90) ;  %alpha angle for left foot
b = (markerThree(:,4)-90); %alpha angle for right foot 
c= (markerTwo(:,4)-90);   %alpha angle for sacral marker

% offests will need to be changed fer person 
lefttoe = 7; % top of the foot where the toe is
leftheel = 4.5;% the heel 
leftoutside = 2.5; % the outer part of the left foot
leftinner = 1.5;  % the inner part of the left foot

righttoe = 7;
rightheel = 4.5;
rightoutside = 2.5;  % the outer part of the right foot
rightinner = 1.5; % the inner part of the right foot

leftglute = 5; %left side of the sitting outline
rightglute =5; %right side of the sitting outline

leftknee = 18; % knee offsets 
rightknee = 18; 

topleft = [markerOne(:,1), markerOne(:,2)+ lefttoe];             
bottomleft = [markerOne(:,1), markerOne(:,2)-leftheel];                  
rightleft = [markerOne(:,1)+leftoutside, markerOne(:,2)];        
leftleft = [markerOne(:,1)-leftinner, markerOne(:,2)];         

topright = [markerThree(:,1), markerThree(:,2)+ righttoe];       
bottomright = [markerThree(:,1), markerThree(:,2)- rightheel];
rightright = [markerThree(:,1)-rightinner, markerThree(:,2)];
leftright = [markerThree(:,1)+rightoutside, markerThree(:,2)];

sitleft = [markerTwo(:,1)+ leftglute, markerTwo(:,2)];         %offset for when they are sitting down
sitright = [markerTwo(:,1)-rightglute, markerTwo(:,2)];

kneeleftout = [markerOne(:,1)+1.5, markerOne(:,2)-leftknee]; %left knee outer point 
kneerightout = [markerThree(:,1)-1.5, markerThree(:,2)-rightknee]; %right knee outer point 

% This loop applies alpha/yaw angle to offsets 
for n= 1:totalFrames/3
   topleft_new(n,1) = (((topleft(n,1)-markerOne(n,1))*cosd(a(n,1))) - ((topleft(n,2)-markerOne(n,2))*sind(a(n,1)))) + markerOne(n,1) ;
   topleft_new(n,2) = (((topleft(n,1)-markerOne(n,1))*sind(a(n,1))) + ((topleft(n,2)-markerOne(n,2))*cosd(a(n,1)))) + markerOne(n,2) ;
   bottomleft_new(n,1) = (((bottomleft(n,1)-markerOne(n,1))*cosd(a(n,1))) - ((bottomleft(n,2)-markerOne(n,2))*sind(a(n,1)))) + markerOne(n,1);
   bottomleft_new(n,2) = (((bottomleft(n,1)-markerOne(n,1))*sind(a(n,1))) + ((bottomleft(n,2)-markerOne(n,2))*cosd(a(n,1)))) + markerOne(n,2) ;
   rightleft_new(n,1) = (((rightleft(n,1)-markerOne(n,1))*cosd(a(n,1))) - ((rightleft(n,2)-markerOne(n,2))*sind(a(n,1)))) + markerOne(n,1);
   rightleft_new(n,2) = (((rightleft(n,1)-markerOne(n,1))*sind(a(n,1))) + ((rightleft(n,2)-markerOne(n,2))*cosd(a(n,1)))) + markerOne(n,2) ;
   leftleft_new(n,1) = (((leftleft(n,1)-markerOne(n,1))*cosd(a(n,1))) - ((leftleft(n,2)-markerOne(n,2))*sind(a(n,1)))) + markerOne(n,1);
   leftleft_new(n,2) = (((leftleft(n,1)-markerOne(n,1))*sind(a(n,1))) + ((leftleft(n,2)-markerOne(n,2))*cosd(a(n,1)))) + markerOne(n,2) ;
   
   topright_new(n,1) = (((topright(n,1)-markerThree(n,1))*cosd(b(n,1))) - ((topright(n,2)-markerThree(n,2))*sind(b(n,1)))) + markerThree(n,1)  ;
   topright_new(n,2) = (((topright(n,1)-markerThree(n,1))*sind(b(n,1))) + ((topright(n,2)-markerThree(n,2))*cosd(b(n,1)))) +markerThree(n,2) ;
   bottomright_new(n,1) = (((bottomright(n,1)-markerThree(n,1))*cosd(b(n,1))) - ((bottomright(n,2)-markerThree(n,2))*sind(b(n,1)))) + markerThree(n,1);
   bottomright_new(n,2) = (((bottomright(n,1)-markerThree(n,1))*sind(b(n,1))) + ((bottomright(n,2)-markerThree(n,2))*cosd(b(n,1)))) +markerThree(n,2);
   rightright_new(n,1) = (((rightright(n,1)-markerThree(n,1))*cosd(b(n,1))) - ((rightright(n,2)-markerThree(n,2))*sind(b(n,1)))) + markerThree(n,1);
   rightright_new(n,2) = (((rightright(n,1)-markerThree(n,1))*sind(b(n,1))) + ((rightright(n,2)-markerThree(n,2))*cosd(b(n,1)))) +markerThree(n,2);
   leftright_new(n,1) = (((leftright(n,1)-markerThree(n,1))*cosd(b(n,1))) - ((leftright(n,2)-markerThree(n,2))*sind(b(n,1)))) + markerThree(n,1);
   leftright_new(n,2) = (((leftright(n,1)-markerThree(n,1))*sind(b(n,1))) + ((leftright(n,2)-markerThree(n,2))*cosd(b(n,1)))) +markerThree(n,2);
    
   sitleft_new(n,1) = (((sitleft(n,1)-markerTwo(n,1))*cosd(c(n,1))) - ((sitleft(n,2)-markerTwo(n,2))*sind(c(n,1)))) + markerTwo(n,1);
   sitleft_new(n,2) = (((sitleft(n,1)-markerTwo(n,1))*sind(c(n,1))) + ((sitleft(n,2)-markerTwo(n,2))*cosd(c(n,1)))) +markerTwo(n,2) ;
   sitright_new(n,1) = (((sitright(n,1)-markerTwo(n,1))*cosd(c(n,1))) - ((sitright(n,2)-markerTwo(n,2))*sind(c(n,1)))) + markerTwo(n,1);
   sitright_new(n,2) =(((sitright(n,1)-markerTwo(n,1))*sind(c(n,1))) + ((sitright(n,2)-markerTwo(n,2))*cosd(c(n,1)))) +markerTwo(n,2) ;
 
   kneeleftout_new(n,1)= (((kneeleftout(n,1)-markerOne(n,1))*cosd(a(n,1))) - ((kneeleftout(n,2)-markerOne(n,2))*sind(a(n,1)))) + markerOne(n,1) ;
   kneeleftout_new(n,2)= (((kneeleftout(n,1)-markerOne(n,1))*sind(a(n,1))) + ((kneeleftout(n,2)-markerOne(n,2))*cosd(a(n,1)))) + markerOne(n,2) ;
 
   kneerightout_new(n,1)=(((kneerightout(n,1)-markerThree(n,1))*cosd(b(n,1))) - ((kneerightout(n,2)-markerThree(n,2))*sind(b(n,1)))) + markerThree(n,1) ;
   kneerightout_new(n,2)=(((kneerightout(n,1)-markerThree(n,1))*sind(b(n,1))) + ((kneerightout(n,2)-markerThree(n,2))*cosd(b(n,1)))) + markerThree(n,2) ;
   
   sacral= [markerTwo(n,1), markerTwo(n,2)];
end

  %==================================================================================================================================================
  
  for j =  1:totalFrames/3  
    left_right_foot= [markerOne(j,2), markerOne(j,1), markerOne(j,3); markerThree(j,2), markerThree(j,1), markerThree(j,3)] ;    %coordinates of the left and right foot in a vector  
    dist_feet(j,:) = pdist(left_right_foot,'euclidean');   
    
    zero(j,1) = 0;
end

feet_sacral_dist = [dist_feet,markerTwo(:,3),markerOne(:,6),markerThree(:,6), zero]; %distance between feet, scaral height, roll angles for feet, colum of zeros 

%creates a data set with the dist between feet, sacral height, roll angles, and a colum of zeros that indictaed differnt movements 

  for m=1:totalFrames/3;
    
 if feet_sacral_dist(m,2) > 32  %standing = 1
     feet_sacral_dist(m,5) = 1;
 end
  
  if feet_sacral_dist(m,1) < 15 && feet_sacral_dist(m,2) < 30 %full kneel = 2
       if feet_sacral_dist(m,3) >100 | feet_sacral_dist(m,3) < -100 | feet_sacral_dist(m,4) >100 | feet_sacral_dist(m,4) < -100
          feet_sacral_dist(m,5) = 2;
      end
  end 
 
 if feet_sacral_dist(m,1) > 20  && feet_sacral_dist(m,2) < 30   %half kneel  =3
     feet_sacral_dist(m,5) = 3;
 end
 
 if feet_sacral_dist(m,1)< 25 && feet_sacral_dist(m,2) < 30   %sit =4   
     if feet_sacral_dist(m,3) < 55 && feet_sacral_dist(m,3) > -55 && feet_sacral_dist(m,4) > -55 && feet_sacral_dist(m,4) < 55
    feet_sacral_dist(m,5) = 4;  
     end
 end 
end

 figure(1)
for k=1:totalFrames/3
    cla;
    grid on
    
   topleft_new(k,1) = (((topleft(k,1)-markerOne(k,1))*cosd(a(k,1))) - ((topleft(k,2)-markerOne(k,2))*sind(a(k,1)))) + markerOne(k,1) ;
   topleft_new(k,2) = (((topleft(k,1)-markerOne(k,1))*sind(a(k,1))) + ((topleft(k,2)-markerOne(k,2))*cosd(a(k,1)))) + markerOne(k,2) ;
   bottomleft_new(k,1)= (((bottomleft(k,1)-markerOne(k,1))*cosd(a(k,1))) - ((bottomleft(k,2)-markerOne(k,2))*sind(a(k,1)))) + markerOne(k,1);
   bottomleft_new(k,2)= (((bottomleft(k,1)-markerOne(k,1))*sind(a(k,1))) + ((bottomleft(k,2)-markerOne(k,2))*cosd(a(k,1)))) + markerOne(k,2) ;
   rightleft_new(k,1) = (((rightleft(k,1)-markerOne(k,1))*cosd(a(k,1))) - ((rightleft(k,2)-markerOne(k,2))*sind(a(k,1)))) + markerOne(k,1);
   rightleft_new(k,2)= (((rightleft(k,1)-markerOne(k,1))*sind(a(k,1))) + ((rightleft(k,2)-markerOne(k,2))*cosd(a(k,1)))) + markerOne(k,2) ;
   leftleft_new(k,1)= (((leftleft(k,1)-markerOne(k,1))*cosd(a(k,1))) - ((leftleft(k,2)-markerOne(k,2))*sind(a(k,1)))) + markerOne(k,1);
   leftleft_new(k,2)= (((leftleft(k,1)-markerOne(k,1))*sind(a(k,1))) + ((leftleft(k,2)-markerOne(k,2))*cosd(a(k,1)))) + markerOne(k,2) ;
   
   topright_new(k,1) = (((topright(k,1)-markerThree(k,1))*cosd(b(k,1))) - ((topright(k,2)-markerThree(k,2))*sind(b(k,1)))) + markerThree(k,1)  ;
   topright_new(k,2)= (((topright(k,1)-markerThree(k,1))*sind(b(k,1))) + ((topright(k,2)-markerThree(k,2))*cosd(b(k,1)))) +markerThree(k,2) ;
   bottomright_new(k,1) =(((bottomright(k,1)-markerThree(k,1))*cosd(b(k,1))) - ((bottomright(k,2)-markerThree(k,2))*sind(b(k,1)))) + markerThree(k,1);
   bottomright_new(k,2)= (((bottomright(k,1)-markerThree(k,1))*sind(b(k,1))) + ((bottomright(k,2)-markerThree(k,2))*cosd(b(k,1)))) +markerThree(k,2);
   rightright_new(k,1)= (((rightright(k,1)-markerThree(k,1))*cosd(b(k,1))) - ((rightright(k,2)-markerThree(k,2))*sind(b(k,1)))) + markerThree(k,1);
   rightright_new(k,2)= (((rightright(k,1)-markerThree(k,1))*sind(b(k,1))) + ((rightright(k,2)-markerThree(k,2))*cosd(b(k,1)))) +markerThree(k,2);
   leftright_new(k,1)= (((leftright(k,1)-markerThree(k,1))*cosd(b(k,1))) - ((leftright(k,2)-markerThree(k,2))*sind(b(k,1)))) + markerThree(k,1);
   leftright_new(k,2)= (((leftright(k,1)-markerThree(k,1))*sind(b(k,1))) + ((leftright(k,2)-markerThree(k,2))*cosd(b(k,1)))) +markerThree(k,2);

    bos_x= [topleft_new(k,2),rightleft_new(k,2),bottomleft_new(k,2),bottomright_new(k,2),rightright_new(k,2),topright_new(k,2)];
    bos_y= [topleft_new(k,1),rightleft_new(k,1),bottomleft_new(k,1),bottomright_new(k,1),rightright_new(k,1),topright_new(k,1)];
   
    bos_leftx= [topleft_new(k,2),rightleft_new(k,2),bottomleft_new(k,2), leftleft_new(k,2)]; % bos of left foot 
    bos_lefty= [topleft_new(k,1),rightleft_new(k,1),bottomleft_new(k,1), leftleft_new(k,1)];
    bos_rightx= [topright_new(k,2),rightright_new(k,2),bottomright_new(k,2), leftright_new(k,2)]; %bos for right foot
    bos_righty= [topright_new(k,1),rightright_new(k,1),bottomright_new(k,1), leftright_new(k,1)];
   
    bos_sitx= [topleft_new(k,2),rightleft_new(k,2),sitleft_new(k,2),sitright_new(k,2),rightright_new(k,2),topright_new(k,2)];
    bos_sity= [topleft_new(k,1),rightleft_new(k,1),sitleft_new(k,1),sitright_new(k,1),rightright_new(k,1),topright_new(k,1)];
    
    bos_fullx= [kneeleftout_new(k,2),kneerightout_new(k,2),leftright_new(k,2),topright_new(k,2),topleft_new(k,2),leftleft_new(k,2)];
    bos_fully= [kneeleftout_new(k,1),kneerightout_new(k,1),leftright_new(k,1),topright_new(k,1),topleft_new(k,1),leftleft_new(k,1)];
    
    bos_halfkneelleftx= [kneerightout_new(k,2),leftright_new(k,2),topright_new(k,2),rightright_new(k,2),bottomleft_new(k,2),rightleft_new(k,2), topleft_new(k,2), leftleft_new(k,2) ];
    bos_halfkneellefty= [kneerightout_new(k,1),leftright_new(k,1),topright_new(k,1),rightright_new(k,1),bottomleft_new(k,1),rightleft_new(k,1), topleft_new(k,1), leftleft_new(k,1) ];
    
    bos_halfkneelrightx= [kneeleftout_new(k,2),leftleft_new(k,2),topleft_new(k,2),rightleft_new(k,2),bottomright_new(k,2),rightright_new(k,2), topright_new(k,2), leftright_new(k,2) ];     
    bos_halfkneelrighty= [kneeleftout_new(k,1),leftleft_new(k,1),topleft_new(k,1),rightleft_new(k,1),bottomright_new(k,1),rightright_new(k,1), topright_new(k,1), leftright_new(k,1) ];
    
    positions = feet_sacral_dist;
    
 if positions(k,5) == 1  %standing  %% might have to differntiate between walking an standing
      if markerOne(k,6)< 55 && markerOne(k,6)> -55 && markerThree(k,6)< 55 && markerThree(k,6)> -55
         fill( bos_x, bos_y, 'c') 
          x=  bos_x;
          y=  bos_y;
       
      elseif markerThree(k,6)< 55 && markerThree(k,6)> -55
          fill(bos_rightx, bos_righty, 'c')
          x= bos_rightx;
          y= bos_righty;
          
      elseif markerOne(k,6)< 55 && markerOne(k,6)> -55 
     fill(bos_leftx, bos_lefty, 'c')
          x= bos_leftx;
          y= bos_lefty; 
      end   
end 
    
    if positions(k,5) == 2  %full kneeling   
        hold on 
        plot(kneeleftout_new(k,2),kneeleftout_new(k,1), 'r.')
        hold on
        plot(kneerightout_new(k,2),kneerightout_new(k,1), 'g.')
       fill(bos_fullx,bos_fully, 'c') 
       x= bos_fullx;
       y= bos_fully;
    end 
   
    if positions(k,5) == 3  %half kneeling
        if markerThree(k,6)< 55 && markerThree(k,6)> -55   % if the foot is up right
            plot(kneeleftout_new(k,2),kneeleftout_new(k,1), 'r.')
            fill(bos_halfkneelrightx,bos_halfkneelrighty, 'c')
            x=bos_halfkneelrightx;
            y=bos_halfkneelrighty;
        end 
        if markerOne(k,6)< 55 && markerOne(k,6)> -55 
            plot(kneerightout_new(k,2),kneerightout_new(k,1), 'g.')
            fill(bos_halfkneelleftx, bos_halfkneellefty,'c')
            x=bos_halfkneelleftx;
            y=bos_halfkneellefty;
        end
    end 
    
    if positions(k,5) == 4  %sitting
      plot(sitleft_new(k,2),sitleft_new(k,1), 'g.')
      hold on 
      plot(sitright_new(k,2),sitright_new(k,1), 'g.')
      hold on 
     fill( bos_sitx, bos_sity, 'c')
     x= bos_sitx;
     y=  bos_sity;
    end 

    if positions(k,5) == 1 | positions(k,5) == 2 | positions(k,5) == 3 | positions(k,5) == 4
xm = mean(x);
ym = mean(y);
x = x - xm;
y = y - ym;
% summations for CCW boundary
 xp = x( [2:end 1] );
yp = y( [2:end 1] );
aa = x.*yp - xp.*y; 
A = sum( aa ) /2;
xc = sum( (x+xp).*aa  ) /6/A;
yc = sum( (y+yp).*aa  ) /6/A;
Ixx = sum( (y.*y +y.*yp + yp.*yp).*aa  ) /12;
Iyy = sum( (x.*x +x.*xp + xp.*xp).*aa  ) /12;
Ixy = sum( (x.*yp +2*x.*y +2*xp.*yp + xp.*y).*aa  ) /24;
dx = xp - x;
dy = yp - y;
P = sum( sqrt( dx.*dx +dy.*dy ) );
% check for CCW versus CW boundary
if A < 0,
  A = -A;
  Ixx = -Ixx;
  Iyy = -Iyy;
  Ixy = -Ixy;
end 
% centroidal moments
Iuu = Ixx - A*yc*yc;
Ivv = Iyy - A*xc*xc;
Iuv = Ixy - A*xc*yc;
J = Iuu + Ivv;
% replace mean of vertices
Centroidx = xc + xm;
Centroidy = yc + ym;
plot(Centroidx,Centroidy,'r+')

%centroid(k,1)=  Centroidx(k,1);  
%centroid(k,2)=  Centroidy(k,1); 

    else 
    %    centroid(k,1)=  NaN;  
     %   centroid(k,2)=  NaN;    
end 
  
 
    
   plot(markerOne(k,2), markerOne(k,1), 'mo')
  hold on
  plot(topleft_new(k,2), topleft_new(k,1), 'mo')
  hold on 
  plot(bottomleft_new(k,2), bottomleft_new(k,1), 'mo')
  hold on
  plot(rightleft_new(k,2), rightleft_new(k,1), 'mo')
  hold on
  plot(leftleft_new(k,2), leftleft_new(k,1), 'mo')
  hold on
  
  plot(markerThree(k,2), markerThree(k,1), 'bo')
  hold on
  plot(topright_new(k,2),topright_new(k,1), 'bo')
  hold on
  plot(bottomright_new(k,2), bottomright_new(k,1), 'bo')
  hold on
  plot(rightright_new(k,2), rightright_new(k,1), 'bo')
  hold on
  plot(leftright_new(k,2), leftright_new(k,1), 'bo')
  hold on 
   
  plot (markerTwo(k,2),markerTwo(k,1),'k*')  %scaral marker 
 % hold on
  
%  plot (0,120,'rs')   %represents the source
 % hold on 
%  plot (0,300,'rs')   %represents the source 
  
   xlim ([-60 60])  % can change the limits of the graph once larger area is being used 
   ylim ([-60 60])  
    
    pause(.00000001)
    
end 


