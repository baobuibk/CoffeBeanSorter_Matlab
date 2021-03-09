function [img_border1,out_pst_pxl,num_obj,img_label] = find_border(img)

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
num_label       = zeros(500,1);
img_border      = zeros(row,col);
out_pst_pxl     = [];
out_border      = zeros(row,col);
num_obj         = 0;
%===============================================  find the number of pixels
%each object at border

%=============================================== ELMINATE BORDER PIXELS

img_label       = bwlabel(img);

for i=6:row-5
    if (img_label(i,6)~=0)
        num_label(img_label(i,6),1)       = num_label(img_label(i,6),1) + 1;
    end
    if  (img_label(i,col-5)~=0)
        num_label(img_label(i,col-5),1)   = num_label(img_label(i,col-5),1) +1;
    end
end

for j=6:col-5
    if (img_label(6,j) ~= 0)
        num_label(img_label(6,j),1)       = num_label(img_label(6,j),1) + 1;
    end
    if (img_label(row-5,j)~=0)
        num_label(img_label(row-5,j),1)   = num_label(img_label(row-5,j),1) +1;
    end
end

%=============================================== GET BORDER PIXELS
for ii=6:row-5
    for jj=6:col-5
        if img_label(ii,jj)~=0
            if num_label(img_label(ii,jj),1) > 15        %remove object 
                img(ii,jj) = BLACK;
            end
        end
        sum_neib = sum(sum(img(ii-1:ii+1,jj-1:jj+1)));
        if (((img(ii,jj) == WHITE) && (sum_neib <= 8)))
            img_border(ii,jj) = WHITE;
        end
    end
end

img_border  = lammanh_process(img_border);

%-----------------------------------------------
%===============================================
[img_label,num_obj]      = bwlabel(img);

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
            elseif (sum_neighbor == 2) || (sum_neighbor >3 )                %if the line is broken or so ...on
                
                del_val     = img_label(i,j);
                img_border  = eliminate_noise_line(del_val,img_border,img_label);
                num_obj     = num_obj - 1;
            %--------------------------------%        
            else
                continue;
            end
            %--------------------------------%
        end
    end
end
img_border1 = img_border;
%=====================================%
%=====================================%find border line
for ii=6:row-5
   for jj=6:col-5
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        if img_border(ii,jj) == WHITE
            [posi_single, si_flag, img_border_si,img_border] = find_border_single(img_border,ii,jj);
 %           imwrite(img_border_si, 'D:\IMG_border_sg.jpg');
            if si_flag == 0
                out_border     = out_border|img_border_si;
                num_obj        = num_obj + 1;
                out_pst_pxl    = [out_pst_pxl;131313,size(posi_single,1);posi_single];
            else 
                continue;
            end
        end 
            %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    end
end


end


