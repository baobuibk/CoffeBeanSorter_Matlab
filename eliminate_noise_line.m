function [img_border] = eliminate_noise_line(del_val,img_border,img_label)

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


for  i=1:row
    for j=1:col
        if img_label(i,j) ==  del_val
            img_border(i,j) = BLACK;
        end
    end
end


end

