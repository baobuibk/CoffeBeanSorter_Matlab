function [out] = remove_sm_obj(img,THR,cut_bd)

[img_lb,nb_obj] =  CC_label(img,cut_bd);
[row,col]       = size(img);
each_obj        = zeros(nb_obj,1);
out             = zeros(row,col);

%-----------------------------
%   Calculate the number of pxl
%   in each obj
%-----------------------------
for r=cut_bd+1:row-cut_bd
    for c=cut_bd+1:col-cut_bd
        if img_lb(r,c) ~= 0
            each_obj(img_lb(r,c),1) = each_obj(img_lb(r,c),1)+1;
        end
    end
end

%-----------------------------
%  Eliminate small obj
%-----------------------------

for r=cut_bd+1:row-cut_bd
    for c=cut_bd+1:col-cut_bd
        if img_lb(r,c) ~= 0
            if each_obj(img_lb(r,c),1) < THR
                out(r,c) = 0;
            else
                out(r,c) = 1;
            end
        end
        
    end
end


end

