function rst = Test_matrix(img1,img2)

[row_img1,col_img1]  = size(img1);
[row_img2,col_img2]  = size(img2);
rst = 0 ;
%==============================================
if ((row_img1 ~= row_img2)|| (col_img1 ~= col_img2))
    rst = 13131313;
else
    %-----------------------------------------
    for i=1:row_img1
        for j=1:col_img1
            if(img1(i,j) ~= img2(i,j))
                rst = rst + 1;
            end
        end
    end
%==============================================
end

