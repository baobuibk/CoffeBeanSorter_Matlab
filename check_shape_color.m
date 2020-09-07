function [out_result] = check_shape_color(IMGBi,IMG,pos_px,num_object,num_part,THR_convex,THR_block,label)

%===============================================================
%out_result = [x coordinate, y coordinate, result, object class
%funtion return value of good object and it's coodinate
% GOOD : 1
% BAD  : 0
%===============================================================
GOOD = 1;
BAD  = 0;
out_result  = [];

t_IMGBi(:,:,1)  = IMGBi;
t_IMGBi(:,:,2)  = IMGBi;
t_IMGBi(:,:,3)  = IMGBi;
IMGSeg_CIE      = IMG.*uint8(t_IMGBi);
Lab_img         = rgb2labnew(IMGSeg_CIE);

for i=1:num_object
    pos_single = pos_px{i};                                                                                % get position after thinning 
    [result_shape,x_center,y_center] = check_single_shape(pos_single,num_part,THR_convex,THR_block);       % check shape
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

%    [img,img_check]     = explore_single_img(pos_single,IMGSeg_CIE);
    [result_color]     = check_color(Lab_img,label,num_object);                                % check color

    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    result     =  result_shape && result_color; %
    out_result = [out_result;x_center,y_center,result,i];
end
end

