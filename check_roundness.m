function result_shape = check_roundness(out_pst_pxl,img_label,center,num_obj)

%====================================================
THR_SHAPE       = 1.16;
GOOD            = 1;
BAD             = 0;
result_shape    = [];
pnt             = 1;       %using to access the element in out_pst_pxl
%====================================================
for obj=1:num_obj
    sur_area    = sum(sum(img_label==obj));
    perimeter   = out_pst_pxl(pnt,2);         %get number of perimeter pixels of each object
    pnt         = pnt+perimeter+1;
    thres_shape = (4*pi*sur_area)/(perimeter^2);
    
%    object      = out_pst_pxl{obj};
%    center      = sum(object,1)/perimeter;
    x_center    = center(obj,1);
    y_center    = center(obj,2);
          
    if (thres_shape>= THR_SHAPE)
       result_shape = [result_shape;[obj,x_center,y_center,thres_shape,GOOD]]; 
    else
       result_shape = [result_shape;[obj,x_center,y_center,thres_shape,BAD]];
    end
end
%====================================================
end

