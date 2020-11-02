function [out_result] = features_evaluation(    out_border,...
                                                img_label,...
                                                THR_block,...
                                                NUM_PART,...
                                                THR_convex)                      
%===============================================================
%out_result = [x coordinate, y coordinate, result, object class
%funtion return value of good object and it's coodinate
% GOOD : 1
% BAD  : 0
%===============================================================
GOOD = 1;
BAD  = 0;
out_result  = [];

rs_rdness   = check_roundness(out_border,img_label);
rs_cvhull   = check_convexhull(out_border,NUM_PART,THR_block,THR_convex);

%rs_color    = check_color();
%{
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    [img,img_check]     = explore_single_img(pos_single,IMGSeg_CIE);
    [result_color]     = check_color(img,img_check);                               % check color

    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
%}
    result     =  rs_rdness;
    out_result = [out_result;result];
end



