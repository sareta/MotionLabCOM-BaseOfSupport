%{
By: Siniva Areta
This code takes data collected from the codes 'RawDataCollection.m' and
'PostProcessing.m' and gives useful information about the COM in reference
to the COBOS. This includes the difference in position, the velocity, and
the acceleration.
%}

hold off %turns off any other graph

%Lines 10=13 are code for a filter found on MathWorks.
windowSize = 10; %The higher this value is, the more filtered it is.
windowSizeVector = (1/windowSize)*ones(1,windowSize);
range = 1;
Position = filter(windowSizeVector,range,finalCOMtoBOS);
frame=1:1:size(finalCOMtoBOS,1); %Establishes frame number
%Lines 16-20 are code to solve for first and second derivatives of an
%equation. The code was found on MathWorks.
h = 0.1;       % step size
X = 1:h:211;    % domain
f = spline(frame,Position,X);% range-interpolates the data points and adjusts to domain.
Y = diff(f)/h;   % first derivative
Z = diff(Y)/h;   % second derivative
plot(X,f,'m') %Plots Position
title('Position difference of COM in reference to BOS');
xlabel('Frame number');
ylabel('Position difference (m)');
figure %New figure
plot(X(:,1:length(Y)),Y,'k'); %Plots Velocity
title('Velocity of COM in reference to BOS');
xlabel('Frame number');
ylabel('Velocity (m/s)');
figure %New figure
plot(X(:,1:length(Z)),Z,'c'); %Plots Acceleration
title('Acceleration of COM in reference to BOS');
xlabel('Frame number');
ylabel('Acceleration (m/s^2)');
hold on

