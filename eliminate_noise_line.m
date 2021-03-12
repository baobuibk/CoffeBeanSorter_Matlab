function [img_border,coor_noise_obj] = eliminate_noise_line(del_val,img_border,img_label)

%{
==========================================
This function eliminate line if it's broken
and return image after eliminated
==========================================
%}

BLACK       = 0;
WHITE       = 1;
ON          = 1;
OFF         = 0;
[row,col]   = size(img_label);
coor_x      = 0;
coor_y      = 0;
nb_pxl      = 0;
for  i=1:row
    for j=1:col
        if img_label(i,j) ==  del_val
            img_border(i,j) = BLACK;
            coor_x = coor_x + i;
            coor_y = coor_y + i;
            nb_pxl = nb_pxl + 1;
        end
    end
end
coor_noise_obj = [round(coor_x/nb_pxl),round(coor_y/nb_pxl)];

end

