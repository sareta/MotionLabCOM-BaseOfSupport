%{
totalFrames = size(test1, 1);


%intialize the marker matrices
markerOne = zeros(totalFrames/3, 6);
markerTwo = zeros(totalFrames/3, 6);
markerThree = zeros(totalFrames/3, 6);

for i = 1:totalFrames/3 %a third of the row size
    markerOne(i,1) = test1{i*3-2, 5};   
    markerOne(i,2) = test1{i*3-2, 6};
    markerOne(i,3) = test1{i*3-2, 7}*-1;
    markerOne(i,4) = test1{i*3-2, 8};   
    markerOne(i,5) = test1{i*3-2, 9};
    markerOne(i,6) = test1{i*3-2, 10};
    
    markerTwo(i,1) = test1{i*3-1, 5};   
    markerTwo(i,2) = test1{i*3-1, 6};
    markerTwo(i,3) = test1{i*3-1, 7}*-1;
    markerTwo(i,4) = test1{i*3-1, 8};   
    markerTwo(i,5) = test1{i*3-1, 9};
    markerTwo(i,6) = test1{i*3-1, 10};
    
    markerThree(i,1) = test1{i*3, 5};   
    markerThree(i,2) = test1{i*3, 6};
    markerThree(i,3) = test1{i*3, 7}*-1;
    markerThree(i,4) = test1{i*3, 8};   
    markerThree(i,5) = test1{i*3, 9};
    markerThree(i,6) = test1{i*3, 10};
end
%}
helper=avg([1 2 3 4 5 6])