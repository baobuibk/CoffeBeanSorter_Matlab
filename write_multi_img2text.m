function write_multi_img2text(type)


RGB     = 1;
GRAY    = 2;

addpath('C:\Users\ducan\Pictures\Test');
listTemplate   = dir('C:\Users\ducan\Pictures\Test');
[length,~]     = size(listTemplate);

for len=3:length
     
%=============================================================== RGB
if (type == RGB)
    
     Red    =  fopen(fullfile('C:\Users\ducan\Documents\MATLAB\Coffee_bean\Text_value', ['RGB_Red' num2str(len-2) '.txt']),'w');
     Green  =  fopen(fullfile('C:\Users\ducan\Documents\MATLAB\Coffee_bean\Text_value', ['RGB_Green' num2str(len-2) '.txt']),'w');
     Blue   =  fopen(fullfile('C:\Users\ducan\Documents\MATLAB\Coffee_bean\Text_value', ['RGB_Blue' num2str(len-2) '.txt']),'w');
     
     IMG        = imread(listTemplate(len).name);
     IMG        = imresize(IMG,[480 640]);
     IMG        = IMG(121:360,:,:);
     
    [ row,col,~] = size(IMG);

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
%{
elseif (type == GRAY)
    
    [row,col] = size(IMG);
    Gray = fopen('D:\B. WORK\LAB\COFFEE _BEAN IMAGE PROCESSING\Text_value\Gray.txt','w');
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
%}
end

fclose('all');
    
    
    
end

end

