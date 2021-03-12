function [img_border1,out_pst_pxl,num_obj,img_label] = pre_evaluation(img)

%=========================================================
% This funtion find border of image and return
% bordered image and position 
%
% out_border: border image 
% out_pst_pxl : pixel position 
% num_object  : number of good object
% er_find_line: check error when find border (ON=1, OFF=0)
% 
% The out_pst_pxl is organized as following:
%       131313   number of pixel object 1
%         x1        y1
%         x2        y2
%              ...
%         xn        yn
%       131313   number of pixel object 2
%         x1        y1
%              ...
%         xm        ym
%=========================================================
WHITE           = 1;
BLACK           = 0;
[row,col]       = size(img);
out_pst_pxl     = [];

his_obj_bd      = zeros(500,1);

[img_label,num_obj] = bwlabel(img);
[img_border]        = get_img_border(img,img_label);  

for i=1:row
    for j=1:col
        his_obj_bd(img_label(i,j)) =  his_obj_bd(img_label(i,j)) + 1;
    end
end


%=====================================% Get border position
fdbd_array = zeros(2000,1);
bwbd_array = zeros(2000,1);
temp_array = zeros(row,2);

bd_array   = zeros(2000,1);

for i=6:row-5
    for j=6:col-5
        %--------------------------------%
        if (img_border(i,j) == WHITE)
            %--------------------------------%
            sum_neighbor = (sum(sum(img_border(i-1:i+1,j-1:j+1))));  
            if (sum_neighbor == 1)                                          %if exist one point noise
                img_border(i,j) = BLACK;
                
            %--------------------------------%    
            elseif (sum_neighbor == 2) || (sum_neighbor > 3)                %if the line is broken or so on
                del_val     = img_label(i,j);
                [img_border,coor_noise_obj]  = eliminate_noise_line(del_val,img_border,img_label);
                bd_array    = [bd_array;1313,1;coor_noise_obj];
                num_obj     = num_obj - 1;
                
            %--------------------------------%                              %get the position of border  
            else
                idx1 = 1;
                if j == (col-5)
                    temp_array(idx1,1) = 1313;
                    temp_array(idx1,2) = 1313;
                    calculate_here;                    
                    
                else
                    temp_array(idx1,1) = j;
                    temp_array(idx1,2) = img_label(i,j);
                    idx1 = idx1 + 1;
                end
%                get_pst_boder(img_border,i,j);                                 %get the position of border pxl here
            end
            
            %--------------------------------%
        end
    end
end
img_border1 = img_border;                      % Be used for display purpose
%=====================================%


end


