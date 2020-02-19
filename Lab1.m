% A.1 read and show the images
imshow(lena);

% A.2 write a copy for the images
imwrite(lena,lenaMap0, 'lenaCOPY.bmp');

% A.3 copy images as tiff, jpeg and gif
imwrite(lena,lenaMap1, 'lenaJPEG.jpeg');
imwrite(lena,lenaMap2, 'lenaJPEG.tiff');
imwrite(lena,lenaMap3, 'lenaJPEG.gif');

% A.4 copy images as tiff, jpeg and gif
% get 10 x 10 array of lena

% A.5 copy images as tiff, jpeg and gif
smallerArr = lena(1:10,1:10);
%get the shape of the vector
%size(arr);

% A.6 negate =  255 - bmpLena
negateLena = 255 - bmpLena;




% A.8 padding

imageSize = 512;
paddingImg = zeros(imageSize +2 ,imageSize +2);
paddingImg(2:imageSize +1,2:imageSize +1)= bmpLena;
tempAvg = zeros(imageSize+2 ,imageSize+2 );

for x = 2:imageSize+1
    for y = 2:imageSize+1
        tempAvg(x,y) = (paddingImg(x,y) + paddingImg(x+1,y) + paddingImg(x,y+1) + paddingImg(x+1,y+1))/4;
    end
end

% A.7 
newSize = imageSize/2;
reducedSize = zeros(imageSize/2 ,imageSize/2);
for i = 1:newSize 
    for j = 1:newSize
        x=2*i;
        y=2*j;
        reducedSize(i,j) = (paddingImg(x,y) + paddingImg(x+1,y) + paddingImg(x,y+1) + paddingImg(x+1,y+1))/4;
    end
end
imshow(reducedSize,[])

% A.9 
test = zeros(512,512 );
for i=i:1:7
    value = 2^i;
    test = (bitand(2^i,A)/2^i)*256;
    figure, imshow(test);
end
