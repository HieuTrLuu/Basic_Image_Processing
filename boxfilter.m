function boxfilter(image, alpha1, beta1, alpha2, beta2)
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
    %fprintf(string(x>=alpha1 && x<=beta1));
    %fprintf('\n')
    if ((x>=alpha1 && x<=beta1) && (y>=alpha2 && y<=beta2))
        %fprintf('%i\n', x);
        %fprintf('%i\n', y);
        image(x,y) = 0;
        %fprintf('%i\n',image(x,y))
    end
  end
end
end

