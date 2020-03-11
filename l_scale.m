function l_scaled = l_scale(image, slope, bias)
%New image is rearranged so when transformed dc is at centre
%
%  Usage: new image = rearrange(image)
%
%  Parameters: image      - array of points 

%get dimensions
[rows,cols]=size(image); 

%rearrange image
l_scaled = zeros(rows,cols);

for x = 1 :rows
    for y = 1 :cols
%        if l_scaled(x,y) <=0
%           l_scaled(x,y) = 0;
%        elseif l_scaled(x,y) >255
%           l_scaled(x,y) = 255;
%        else
          l_scaled(x,y) = image(x,y) *slope +bias; 
%        end
    end
end

end

function l_clipped= l_clip(image, slope, bias, clip)
%New image is rearranged so when transformed dc is at centre
%
%  Usage: new image = rearrange(image)
%
%  Parameters: image      - array of points 

%get dimensions
[rows,cols]=size(image); 

%rearrange image
l_clipped = l_scale(image,slope, bias);

for x = 1 :cols
    for y = 1 :rows
       if l_clipped(x,y) <clip
          l_clipped(x,y) = clip;
       end
    end
end

end

