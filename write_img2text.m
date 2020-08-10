function Error = write_img2text(IMG,type)

%===============================================================
% This funtion write a maxtrix image and write into a text
% RGB  = 1;
% GRAY = 2;
%===============================================================
RGB     = 1;
GRAY    = 2;

%=============================================================== RGB
if (type == RGB)
[row,col,~] = size(IMG);

Red     = fopen(' C:\Users\ducan\Documents\MATLAB\Coffee_bean_Matlab\Text_value\RGB_Red1.txt','w'); 
Green   = fopen('C:\Users\ducan\Documents\MATLAB\Coffee_bean_Matlab\Text_value\RGB_Green1.txt','w');
Blue    = fopen('C:\Users\ducan\Documents\MATLAB\Coffee_bean_Matlab\Text_value\RGB_Blue1.txt','w');
for i=1:row
    for j=1:col
        %----------------------------------------%1
        if IMG(i,j,1)<10
            fprintf(Red,'%d    ',IMG(i,j,1));
        elseif IMG(i,j,1)<100
            fprintf(Red,'%d   ',IMG(i,j,1));
        else 
            fprintf(Red,'%d  ',IMG(i,j,1));
        end
        %----------------------------------------%2
         if IMG(i,j,2)<10
            fprintf(Green,'%d    ',IMG(i,j,2));
        elseif IMG(i,j,2)<100
            fprintf(Green,'%d   ',IMG(i,j,2));
        else 
            fprintf(Green,'%d  ',IMG(i,j,2));
        end
        %----------------------------------------%3
        if IMG(i,j,3)<10
            fprintf(Blue,'%d    ',IMG(i,j,3));
        elseif IMG(i,j,3)<100
            fprintf(Blue,'%d   ',IMG(i,j,3));
        else 
            fprintf(Blue,'%d  ',IMG(i,j,3));
        end
        %----------------------------------------%
    end
    fprintf(Red,'\n');
    fprintf(Green,'\n');
    fprintf(Blue,'\n');
end
%=============================================================== GRAY     
elseif (type == GRAY)
    
    [row,col] = size(IMG);
    Gray = fopen('C:\Users\ducan\Documents\MATLAB\Coffee_bean_Matlab\Text_value\Gray.txt','w');
    for i=1:row
        for j=1:col
             %----------------------------------------%
        if IMG(i,j,1)<10
            fprintf(Gray,'%d    ',IMG(i,j,1));
        elseif IMG(i,j,1)<100
            fprintf(Gray,'%d   ',IMG(i,j,1));
        else 
            fprintf(Gray,'%d  ',IMG(i,j,1));
        end
             %----------------------------------------%        
        end
    end
    
    
    
    
%===============================================================
else
    Error = 1;
end

fclose('all');
end

