function result_shape = check_roundness(out_border,img_label)

%====================================================
THR_SHAPE       = 1;
GOOD            = 1;
BAD             = 0;
result_shape    = [];
%====================================================
num_obj = size(out_border,1);
for obj=1:num_obj
    sur_area    = sum(sum(img_label==obj));
    perimeter   = size(out_border{obj},1);
    thres_shape = (4*pi*sur_area)/  (perimeter^2);
    if (thres_shape>= THR_SHAPE)
       result_shape = [result_shape;[obj,thres_shape,GOOD]]; 
    else
       result_shape = [result_shape;[obj,thres_shape,BAD]];
    end
end
%====================================================



end

