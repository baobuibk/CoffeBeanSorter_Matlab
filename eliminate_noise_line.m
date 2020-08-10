function [img_border] = eliminate_noise_line(erl_xcur,erl_ycur,img_border)

%{
==========================================
This function eliminate line if it's broken
and return image after eliminated
==========================================
%}

BLACK = 0;
WHITE = 1;
ON    = 1;
OFF   = 0;

img_border(erl_xcur,erl_ycur) = BLACK;  
erl      = ON;
while(erl == ON)
    if (sum(sum(img_border(erl_xcur-1:erl_xcur+1,erl_ycur-1:erl_ycur+1))) ~= 1)               
        erl = OFF;               
    else              
        [erl_xnext,erl_ynext] = find(img_border(erl_xcur-1:erl_xcur+1,erl_ycur-1:erl_ycur+1) == 1);                
        erl_xcur = erl_xnext - 2 + erl_xcur;              
        erl_ycur = erl_ynext - 2 + erl_ycur;              
        img_border(erl_xcur,erl_ycur) = BLACK;              
    end            
end          
end

