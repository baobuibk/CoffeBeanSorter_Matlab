function [img_border,out_border,IMGBi,img_label,nb_obj] = find_border_matlab(IMGBi)


%out_border =  bwboundaries(IMGBi,'noholes');  %get the border
%num_object = size(out_border,1);              

[lb_img,num_object] = bwlabel(IMGBi);         %connect component to get label

for nob = 1:num_object
    [row,col]   = find(lb_img == nob);
    cut_edge = sum(row == 475) >= 5 || sum(row == 6)    >= 5 || ...
               sum(col == 6)   >= 5 || sum(col == 635)  >= 5; 
    if (cut_edge == 1)
        lb_img(lb_img(:,:) == nob) = 0;
    else
        continue;
    end
end
IMGBi      = uint8((lb_img(:,:) ~=0));



[out_border,img_label,nb_obj] = bwboundaries(IMGBi,'noholes');

%=========================================get the image for display
[row,col]  = size(IMGBi);
img_border = zeros(row,col);

for dis=1:nb_obj
    border = out_border{dis};
    size_border = size(border,1);
    for jj=1:size_border
        img_border(border(jj,1),border(jj,2)) = 1;
    end
end

