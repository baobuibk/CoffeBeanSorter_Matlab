function [out_shape_line] = check_shape_line(out_pst_pxl,num_obj)

GOOD = 1;
BAD  = 0;


pnt = 1;
THR_convex = 0.25;
THR_block = 1;
out_shape_line =[];
for i=1:num_obj
    nb_border_pxl   = out_pst_pxl(pnt,2);
    if (nb_border_pxl ~=1)                %if not containing the noise
        pst_each_obj    = out_pst_pxl(pnt+1:nb_border_pxl+pnt,:);
        pnt             = pnt + nb_border_pxl+1;
        rs_shape        = check_single_shape(pst_each_obj,5,THR_convex,THR_block);
        out_shape_line  = [out_shape_line;rs_shape];
    else                                  %if containing the noise
        out_shape_line  = [out_shape_line;BAD];
        
    end
end
end

