function [out_border,out_pst_pxl,num_object] = find_border(img)

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

[row,col]       = size(img);
img_border      = zeros(row,col);
out_border      = zeros(row,col);
out_pst_pxl     = [];
BLACK           = 0;
WHITE           = 1;
num_object      = 0;
%mt_border      = [];
%ON              = 1;
%OFF             = 0;
%TRUE           = 1;


%=====================================% thinning border
%write_img2text(img_border,2);
img(:,1:5) = 0;
img(1:5,:) = 0;
img(row-4:row,:) = 0;
img(:,col-4:col) = 0;
%write_img2text(img,2);

%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
for i=6:row-5
    for j=6:col-5
        sum_neib = sum(sum(img(i-1:i+1,j-1:j+1)));
        if (((img(i,j) == WHITE) && (sum_neib <= 8)))
%         if (((img(i,j) == BLACK) && (sum_neib >=1 )))
            img_border(i,j) = WHITE;
        end 
    end
end
%write_img2text(img_border,2);

img_border = lammanh_process(img_border);
%write_img2text(img_border,2);
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
            elseif (sum_neighbor == 2)          %if the line is broken
       %         if (i>=15) &&(j>=303)
       %             check= 0;
       %         end
                erl_xcur = i;                  
                erl_ycur = j;
                img_border = eliminate_noise_line(erl_xcur,erl_ycur,img_border);
                
            %--------------------------------%        
            elseif (sum_neighbor > 3)
                erl_xcur = i;
                erl_ycur = j;
                img_border(erl_xcur,erl_ycur) = BLACK;
                for iii=-1:1
                    for jjj=-1:1
                        if(img_border(erl_xcur+iii,erl_ycur+jjj) == WHITE)
                            img_border = eliminate_noise_line(erl_xcur+iii,erl_ycur+jjj,img_border);
                        end
                    end
                end
            
            %--------------------------------%        
            else
                continue;
            end
            %--------------------------------%
        end
    end
end



%write_img2text(img_border,2);
%=====================================%find border line
for ii=6:row-5
   for jj=6:col-5
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        if img_border(ii,jj) == WHITE
            [posi_single, si_flag, img_border_si,img_border] = find_border_single(img_border,ii,jj);
 %           imwrite(img_border_si, 'D:\IMG_border_sg.jpg');
            if si_flag == 0
                out_border     = out_border|img_border_si;
                num_object     = num_object + 1;
                out_pst_pxl    = [out_pst_pxl;131313,size(posi_single,1);posi_single];
            else 
                continue;
            end
        end 
            %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    end
end
%write_img2text(img_border,2);

end


