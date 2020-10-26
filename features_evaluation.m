function [out_result] = features_evaluation(out_border,img_label)

%===============================================================
%out_result = [x coordinate, y coordinate, result, object class
%funtion return value of good object and it's coodinate
% GOOD : 1
% BAD  : 0
%===============================================================
GOOD = 1;
BAD  = 0;
out_result  = [];
pnt_end     = 0;

rs_roundness  = check_roundness(out_border,img_label);
rs_convexhull = check_convexhull(out_border);

rs_color      = check_color();

                                                       % get position after thinning 
    [result_shape,x_center,y_center] = check_single_shape(pos_single,num_part,THR_convex,THR_block);       % check shape
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    [img,img_check]     = explore_single_img(pos_single,IMGSeg_CIE);
    [result_color]     = check_color(img,img_check);                               % check color

    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    result     =  result_shape && result_color; %
    out_result = [out_result;x_center,y_center,result,i];
end
end

