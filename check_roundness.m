function result_shape = check_roundness(out_pst_pxl,img_label,center,num_obj)

%====================================================
THR_SHAPE       = 1.16;
GOOD            = 1;
BAD             = 0;
result_shape    = [];
pnt             = 1;       %using to access the element in out_pst_pxl
thres           = [];
%====================================================
for obj=1:num_obj
    perimeter   = out_pst_pxl(pnt,2); %get number of perimeter pixels of each object
    x_center    = center(obj,1);
    y_center    = center(obj,2);
    if perimeter~=1
        sur_area    = sum(sum(img_label==obj));     
        pnt         = pnt+perimeter+1;
        thres_shape = (4*pi*sur_area)/(perimeter^2);
    
        if (thres_shape>= THR_SHAPE)
            thres        = [thres;thres_shape];
            result_shape = [result_shape;[x_center,y_center,GOOD]]; 
        else
            thres        = [thres;thres_shape];
            result_shape = [result_shape;[x_center,y_center,BAD]];
        end
    else
        thres       = [thres;1313];
        result_shape = [result_shape;[x_center,y_center,BAD]];
        pnt          = pnt + 2;
    end
end
%====================================================
end

