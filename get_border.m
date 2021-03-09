
function [IMG_border,nb_obj] = get_border(IMG_bi)

WHITE       =   1;
BLACK       =   0;
[row,col]   =   size(IMG_bi);
IMG_border  =   zeros(row,col);
nb_obj      =   0;

for i=6:row-5
    for j=6:col-5
        sum_neib = sum(sum(IMG_bi(i-1:i+1,j-1:j+1)));
        if (((img(i,j) == WHITE) && (sum_neib <= 8)))
            IMG_border(i,j) = WHITE;
        end  
    end
end
IMG_border = lammanh_process(IMG_border);

%[IMG_lable,nb_obj] = bwlabel(IMG_bi);


%write_img2text(img_border,2);
%=====================================% find border line
for ii=6:row-5
   for jj=6:col-5
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        if IMG_border(ii,jj) == WHITE
            [posi_single, si_flag, img_border_si,img_border] = find_border_single(img_border,ii,jj);
 %           imwrite(img_border_si, 'D:\IMG_border_sg.jpg');
            if si_flag == 0
                out_border     = out_border|img_border_si;
                nb_obj         = nb_obj + 1;
                out_pst_pxl    = [out_pst_pxl;131313,size(posi_single,1);posi_single];
            else 
                continue;
            end
        end 
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    end
end

end

