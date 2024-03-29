function [posi_single, img_border_si,img_border] = find_border_single(img_border,x_cur,y_cur)

%=====================================%
% This funtion explore single border of object and return single border 
% if see noise (1), si_flag = 1 
% if the line attract with limited image border, si_flag = 1
% 
%=====================================%
ON    = 1;
OFF   = 0;
BLACK = 0;
WHITE = 1;

[row,col]       = size(img_border);
img_border_si   = zeros(row,col);
posi_single     = [x_cur,y_cur];                                           % initializing si_posi
si_flag         = 0;
img_border(x_cur,y_cur)      = BLACK;                                      %eliminate starting pixel
img_border_si(x_cur,y_cur)   = WHITE;           % be used for display purpose
%=====================================%
mt_temp                 = img_border(x_cur-1:x_cur+1,y_cur-1:y_cur+1);     %search original pixel and next pixel
mt_temp(2,2)            = BLACK; 
[pos33_row,pos33_col]   = find(mt_temp == 1);  
%-------------------------------------
if pos33_col(1,1) > pos33_col(2,1)
    x_next      = x_cur + pos33_row(1,1) - 2;
    y_next      = y_cur + pos33_col(1,1) - 2;
    original_x  = x_cur + pos33_row(2,1) - 2;
    original_y  = y_cur + pos33_col(2,1) - 2;
else
    x_next      = x_cur + pos33_row(2,1) - 2;
    y_next      = y_cur + pos33_col(2,1) - 2;
    original_x  = x_cur + pos33_row(1,1) - 2;
    original_y  = y_cur + pos33_col(1,1) - 2;
end
%=====================================% find border here
flag_explore_line = ON;
while(flag_explore_line == ON)  
    if ((x_next == original_x)&&(y_next == original_y))
        flag_explore_line = OFF;
    end
    x_cur           =  x_next;
    y_cur           =  y_next;
    posi_single     =  [posi_single;x_cur,y_cur];
 
    img_border(x_cur,y_cur)      = BLACK;
    img_border_si(x_cur,y_cur)   = WHITE;
    
    if (flag_explore_line == ON)
        [pos33_row,pos33_col]   = find(img_border(x_cur-1:x_cur+1,y_cur-1:y_cur+1)==1);
        x_next = x_cur + pos33_row - 2;
        y_next = y_cur + pos33_col - 2;
    end
end

%write_img2text(img_border,2);

end


