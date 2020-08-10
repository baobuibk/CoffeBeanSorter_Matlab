function  matrix_save(matrix)
[row,col] = size(matrix);
check     = 0;

path = fopen('C:\Users\ducan\Documents\ECLIPSE\Coffee_bean\matrix_tem.txt','w');
for i=1:row
    %-----------------------------------------------
    for j=1:col     
        check = check + 1;
        if (check == 4)
            check = 0;
            fprintf(path,'%.18f, \n ',matrix(i,j));
        else
            fprintf(path,'%.18f,  ',matrix(i,j));
        end
    end
    %-----------------------------------------------
    fprintf(path,'},\n ');
    fprintf(path,'{ ');
end
fclose('all');
end

