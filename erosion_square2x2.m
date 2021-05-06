%{
%   This function carries out erosion the image
%   The windown is used is a square that size 2x2
%
%}


function img = erosion_square2x2(img)

[row,col] = size(img);

for r= 1:row
    for c=1:col
        if (r==row)||(c==col)
            img(r,c) = img(r,c);
        else
            img(r,c) = img(r,c)&img(r,c+1)&img(r+1,c)&img(r+1,c+1);
        end
    end
end
end