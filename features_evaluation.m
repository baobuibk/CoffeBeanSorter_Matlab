function [result] = features_evaluation(    IMG,...
                                            out_pst_pxl,...
                                            order_lb,... %using this one to synchronize shape and color in array
                                            center,...
                                            img_label,...
                                            num_obj)
                                                
                                                                                                                 
%===============================================================
%out_result = [x coordinate, y coordinate, result, object class
%funtion return value of good object and it's coodinate
% GOOD : 1
% BAD  : 0
%===============================================================
GOOD        = 1;
BAD         = 0;
thr_pxl     = 11;
thr_percent = 0.07;

result  = [];



rs_shape_line   = check_shape_line(out_pst_pxl,num_obj);
rs_rdness       = check_roundness(out_pst_pxl,img_label,center,num_obj);

%rs_convexity    = check_convexhull1(out_border,img_label);
%num_object      = size(out_border,1);

%rs_LBPs         = LBPs(out_border,IMG);
%rs_GLCM         = check_GLCM(IMG,img_label,out_pst_pxl);
 
%num_object      = size(out_border,1);
color           = evaluate_color(IMG,img_label,num_obj,thr_pxl,thr_percent);

result          = [rs_rdness,color,rs_shape_line];
%out_result      = [out_result;color];
end



