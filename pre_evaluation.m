function [img_border1,bd_array,num_obj,img_label] = pre_evaluation(img)

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
%---------------------------------------------------------
%   The obj on each row is organized as following:
%
%        x11      x12     x13      x21    x22      x23       
%        y11      y12     y13      y21    y22      y23   
%=========================================================

bd_array        = zeros(10000,1);

WHITE           = 1;
BLACK           = 0;
[row,col]       = size(img);
row_array       = [];          %using a specific in C instead

his_obj_bd      = zeros(500,1);  % Calculate the histogram of obj
pos_obj_arr     = zeros(500,1);  % Be used for save the position of object in 


[img_label,num_obj] = bwlabel(img);
[img_border]        = get_img_border(img,img_label);  

%=================================% Calculating the number of pxl border in each obj
for i=1:row
    for j=1:col
        his_obj_bd(img_label(i,j)) =  his_obj_bd(img_label(i,j)) + 1;
    end
end
%=================================% Calculating starting position of each obj in border array
pos_obj_arr(1,1) = 1;

for ii=2:500
    pos_obj_arr(ii,1) = pos_obj_arr(ii-1,1) + his_obj_bd(ii-1,1)+1;
end

%=================================% Get border position

%--------------------------------%The first elimination will remove residual pxl around obj 

for i=6:row-5
    for j=6:col-5
        if (img_border(i,j) == WHITE)
            sum_neighbor = (sum(sum(img_border(i-1:i+1,j-1:j+1))));  
            %--------------------------------%
            if (sum_neighbor == 1)                                          %if exist one point noise, remove this point
                img_border(i,j) = BLACK;
            elseif (sum_neighbor == 2)
                remove_redundant(i,j,img_border);
            else
                continue;
            end
            %--------------------------------%
        end
    end
end

%--------------------------------%The second elimination will remove all if it still exist 

last_lb = -1;
nb_pxl_row = 0;
for i=6:row-5   
    for j=6:col-5
        %--------------------------------%
        if (img_border(i,j) == WHITE)
            %--------------------------------%
            sum_neighbor = (sum(sum(img_border(i-1:i+1,j-1:j+1))));  
            if (sum_neighbor == 1)                                          %if exist one point noise, remove this point
                img_border(i,j) = BLACK;
                
            %--------------------------------%    
            elseif (sum_neighbor == 2) || (sum_neighbor > 3)                %if the line is broken or so on, remove all the object and consider as bad obj.  
                del_val                     = img_label(i,j);
                [img_border,coor_noise_obj] = eliminate_noise_line(del_val,img_border,img_label);
                bd_array(pos_obj_arr,1)     = 1313;                          %insert flag
                bd_array(pos_obj_arr,1)     = 1;                             %nb of meaningful pxl  
                bd_array(pos_obj_arr+1,:)   = coor_noise_obj;
                num_obj                     = num_obj - 1;
                
            %--------------------------------%                              %get the position of border  
            else
                row_array = [row_array;i,j];
                if (i==col-5) || (img_label(i,j)~= last_lb)
                    last_lb     =   img_label(i,j);
                    row_array   =   [];
                    bd_array    =   get_obj_row(row_array,bd_array,pos_obj_arr,nb_pxl_row,last_lb);

                else
                    nb_pxl_row = nb_pxl_row + 1;
                    continue;
                end
            end
            
            %--------------------------------%
        end
    end
end
img_border1 = img_border;                      % Be used for display purpose
%=================================%


end


