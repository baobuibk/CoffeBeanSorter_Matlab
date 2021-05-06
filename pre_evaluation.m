function [center,out_border,out_pst_pxl,num_obj_real,nb_obj_eva,order_lb,img_label] = pre_evaluation(img)

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

[row,col]       = size(img);
img_border      = zeros(row,col);
out_border      = zeros(row,col);
out_pst_pxl     = [];
BLACK           = 0;
WHITE           = 1;
order_lb        = [];
center          = [];
%mt_border      = [];
%ON              = 1;
%OFF             = 0;
%TRUE           = 1;

%[img_label,num_obj]     = bwlabel(img);   
[img_label,num_obj_real,~]     = CC_label(img,5);   
nb_obj_eva  = num_obj_real;
%=====================================% thinning border
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
for i=6:row-5
    for j=6:col-5
        sum_neib = sum(sum(img(i-1:i+1,j-1:j+1)));
        if (((img(i,j) == WHITE) && (sum_neib <= 8)))
            img_border(i,j) = WHITE;
        end  
    end
end
img_border = lammanh_process(img_border);

%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
%=====================================% eliminate residual line
for i=6:row-5
    for j=6:col-5
        %--------------------------------%
        if (img_border(i,j) == WHITE)
            %--------------------------------%
            sum_neighbor = (sum(sum(img_border(i-1:i+1,j-1:j+1))));   
            if (sum_neighbor == 1)              %if exist one point noise
                img_border(i,j) = BLACK;
            %--------------------------------%    
            elseif (sum_neighbor == 2) || (sum_neighbor > 3)                % if the line is broken or so on, remove all the object and consider as bad obj.  
                del_val                        = img_label(i,j);
                [img_border,coor_noise_obj]    = eliminate_noise_line(del_val,img_border,img_label);
                out_pst_pxl                    = [out_pst_pxl;131313,1;coor_noise_obj]; 
                center                         = [center;coor_noise_obj];
                order_lb                       = [order_lb;del_val];
                nb_obj_eva                     = nb_obj_eva - 1;
            
            %--------------------------------%        
            else
                continue;
            end
            %--------------------------------%
        end
    end
end

%write_img2text(img_border,2);
%=====================================% find border line
for ii=6:row-5
   for jj=6:col-5
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        if img_border(ii,jj) == WHITE
            cur_label      = img_label(ii,jj);
            [posi_single, img_border_si,img_border] = find_border_single(img_border,ii,jj);
 %           imwrite(img_border_si, 'D:\IMG_border_sg.jpg');
            out_border     = out_border|img_border_si;
            out_pst_pxl    = [out_pst_pxl;131313,size(posi_single,1);posi_single];
            center         = [center;floor(sum(posi_single,1)/size(posi_single,1))];
            order_lb       = [order_lb;img_label(ii,jj)];
        end
   end 
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
end
end


