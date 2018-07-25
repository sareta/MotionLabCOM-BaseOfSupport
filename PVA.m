%{
figure
scatter3(storage1(:,1),storage1(:,2),storage1(:,3))
hold on 
scatter3(storage2(:,1),storage2(:,2),storage2(:,3))
hold on 
scatter3(storage3(:,1),storage3(:,2),storage3(:,3))
%}
lefttoe = 3.75;
leftheel = 6.75; 
leftoutside = 2.5;
leftinner = 1.375;

righttoe = 3.75;
rightheel = 6.75;
rightoutside = 2.5;
rightinner = 1.375;
pos1=[10 6 1];
pos2=[4 6 34];
pos3=[10 15 1];
i=1;
az1= 30;
el1= -15;
rol1= 0;
az2= 0;
el2= 85;
rol2= 45;
az3= 30;
el3= -15;
rol3= 0;

topleft_new(n,1) = pos1(i,1)+lefttoe*cosd(el1)*cosd(az1);
topleft_new(n,2) = pos1(i,2)+lefttoe*sind(az1);
bottomleft_new(n,1) = pos1(i,1)-leftheel*cosd(el1)*cosd(az1);
bottomleft_new(n,2) = pos1(i,2)-leftheel*sind(az1);
rightleft_new(n,1) = pos1(i,1)-leftinner*sind(az1);
rightleft_new(n,2) = pos1(i,2)+leftinner*cosd(rol1)*cosd(az1);
leftleft_new(n,1) = pos1(i,1)+leftoutside*sind(az1);
leftleft_new(n,2) = pos1(i,2)-leftoutside*cosd(az1)*cosd(rol1);

topright_new(n,1) = pos3(i,1)+righttoe*cosd(el3)*cosd(az3);
topright_new(n,2)= pos3(i,2)+righttoe*sind(az3);
bottomright_new(n,1) = pos3(i,1)-leftheel*cosd(el3)*cosd(az3);
bottomright_new(n,2) = pos3(i,2)-leftheel*sind(az3);
rightright_new(n,1) = pos3(i,1)-leftinner*sind(az3);
rightright_new(n,2) = pos3(i,2)+leftinner*cosd(rol3)*cosd(az3);
leftright_new(n,1) = pos3(i,1)+leftoutside*sind(az3);

sacral= [pos2(i,1)+1.2*cosd(el2)*cosd(az2)+6.7*sind(el2)*sind(rol2),pos2(i,2)+1.2*sind(az2)*cosd(el2)+6.7*sind(el2)*cosd(rol2)];

XValues = [bottomleft_new(n,1) leftleft_new(n,1) topleft_new(n,1) topright_new(n,1) rightright_new(n,1) bottomright_new(n,1) bottomleft_new(n,1)];
YValues = [bottomleft_new(n,2) leftleft_new(n,2) topleft_new(n,2) topright_new(n,2) rightright_new(n,2) bottomright_new(n,2) bottomleft_new(n,2)];

plot(XValues,YValues,'m*')
fill(XValues,YValues,'c')
hold on 
plot(sacral(1),sacral(2),'ro',pos2(i,1),pos2(i,2),'ko')