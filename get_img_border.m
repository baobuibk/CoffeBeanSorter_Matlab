function [img_border] = get_img_border(img,img_label)


WHITE           = 1;
[row,col]       = size(img);

num_label       = zeros(500,1);
img_border      = zeros(row,col);

%============================== Search the number pxl of each obj at img edge
for i=6:row-5
    if (img_label(i,6)~=0)
        num_label(img_label(i,6),1)       = num_label(img_label(i,6),1) + 1;
    end
    if  (img_label(i,col-5)~=0)
        num_label(img_label(i,col-5),1)   = num_label(img_label(i,col-5),1) +1;
    end
end

for j=6:col-5
    if (img_label(6,j) ~= 0)
        num_label(img_label(6,j),1)       = num_label(img_label(6,j),1) + 1;
    end
    if (img_label(row-5,j)~=0)
        num_label(img_label(row-5,j),1)   = num_label(img_label(row-5,j),1) +1;
    end
end

%============================== get the image border to one pxl width
for ii=6:row-5
    for jj=6:col-5
        if img_label(ii,jj)~=0
            if num_label(img_label(ii,jj),1) > 15        %remove border 0-5 
                img(ii,jj) = BLACK;
            end
        end
        sum_neib = sum(sum(img(ii-1:ii+1,jj-1:jj+1)));
        if (((img(ii,jj) == WHITE) && (sum_neib <= 8)))
            img_border(ii,jj) = WHITE;
        end
    end
end

img_border  = lammanh_process(img_border);              % thin to 1 pixel
end

