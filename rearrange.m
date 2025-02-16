function rearranged = rearrange(image)
%New image is rearranged so when transformed dc is at centre
%
%  Usage: new image = rearrange(image)
%
%  Parameters: image      - array of points 

%get dimensions
[rows,cols]=size(image); 

%rearrange image
for x = 1:cols %address all columns
  for y = 1:rows %address all rows
    rearranged(y,x)=image(y,x)*((-1)^(y+x)); %Eq. 2.30
  end
end
end