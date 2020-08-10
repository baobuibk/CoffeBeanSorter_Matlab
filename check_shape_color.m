function [out_result,num_object_bad] = check_shape_color(IMGSeg_CIE,pos_px,num_object,num_part,THR_convex,THR_block,L_THR,b_THR,Chroma_THR)

%===============================================================
%out_result = [x coordinate, y coordinate, result, object class
%funtion return value of good object and it's coodinate
% GOOD : 1
% BAD  : 0
%===============================================================
GOOD = 1;
BAD  = 0;
num_object_bad = 0;
out_result  = [];
pnt_end     = 0;
for i=1:num_object
    pnt_st     = pnt_end + 2;
    pnt_end    = pnt_st + pos_px(pnt_st-1,2) - 1;
    pos_single = pos_px(pnt_st:pnt_end,:);                                                                 % get position after thinning 
    [result_shape,x_center,y_center] = check_single_shape(pos_single,num_part,THR_convex,THR_block);       % check shape
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    if result_shape == BAD
        num_object_bad = num_object_bad + 1;
    end
    [img,img_check]     = explore_single_img(pos_single,IMGSeg_CIE);
 
    [result_color]     = check_color(img,img_check,L_THR,b_THR,Chroma_THR);                               % check color

%    if result_color == BAD
%        fprintf(Review_bad,'Avr_L: %.4f    Avr_b: %.4f   Avr_Chroma: %.4f \n',Avr_L,Avr_b,Avr_Chroma);
%    else
%        fprintf(Review_good,'Avr_L: %.4f    Avr_b: %.4f   Avr_Chroma: %.4f \n',Avr_L,Avr_b,Avr_Chroma);
%    end
    
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    result     =  result_shape && result_color; %
    out_result = [out_result;x_center,y_center,result,i];
end
end

