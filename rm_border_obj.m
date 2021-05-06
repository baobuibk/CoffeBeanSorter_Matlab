function IMGBi          = rm_border_obj(IMGBi)



[row,col]   = size(IMGBi);
ON          = 1;
OFF         = 0;
BLACK       = 0;

[img_lb,~]  =  CC_label(IMGBi,5);

arr_rmbd    =[];
size_rmbd   = 0;
flag_check  = 0;
%------------------------
for r=6:row-5
    for c=6:col-5
        if ((r==6)||(r==row-5)||(c==6)||(c==col-5)) && (img_lb(r,c) ~= 0) %check on border
            %------------------------
            if (size_rmbd == 0)
                arr_rmbd = [arr_rmbd;img_lb(r,c)];
                size_rmbd = size_rmbd+1;
            else 
                for ii=1:size_rmbd
                   flag_check = flag_check|(img_lb(r,c) == arr_rmbd(ii,1));
                end
                if flag_check == ON
                    flag_check = OFF;
                    continue;
                else
                    arr_rmbd = [arr_rmbd;img_lb(r,c)];
                    size_rmbd = size_rmbd+1;
                end
            end
            %------------------------
        end
    end
end


for r=6:row-5
    for c=6:col-5
        if (img_lb(r,c) ~= 0)
            for ii=1:size_rmbd
                if img_lb(r,c) == arr_rmbd(ii,1)
                    IMGBi(r,c) = BLACK;
                    break;
                end
            end
            
        end
    end
end
%------------------------
end

