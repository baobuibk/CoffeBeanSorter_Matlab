function [out_result] = features_evaluation(    IMG,...
                                                out_border,...
                                                order_lb,...
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

out_result  = [];

%rs_rdness       = check_roundness(out_border,img_label);
%{
rs_convexity    = check_convexhull1(out_border,img_label);
num_object      = size(out_border,1);

%rs_LBPs         = LBPs(out_border,IMG);
rs_GLCM         = check_GLCM(GLCM_img,img_label,out_border);
%}    
%num_object      = size(out_border,1);
color           = evaluate_color(IMG,img_label,num_obj,thr_pxl,thr_percent);

%result          = [rs_rdness,rs_convexity,rs_GLCM,color];
out_result      = [out_result;color];
end



