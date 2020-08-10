function  rgb2xyz_table_test()


%ROW =   240;
%COL =   640;
X   =   zeros(8,256);
%==========================================================================
for i=0:255
    table1 =    (((i/255)+0.055)/1.055)^2.4;         %It occurs when red >THR  -> 1
    table2 =    (i/255)/12.92;                       %It occurs when red < THR -> 0
    
    red_k    = 0.01933081871559;
    green_k  = 0.11919477979463;
    blue_k   = 0.95053215224966;
    
    X(1,i+1) =  red_k*table2 + green_k*table2 + blue_k*table2;    %000
    X(2,i+1) =  red_k*table2 + green_k*table2 + blue_k*table1;    %001
    X(3,i+1) =  red_k*table2 + green_k*table1 + blue_k*table2;    %010
    X(4,i+1) =  red_k*table2 + green_k*table1 + blue_k*table1;    %011
    X(5,i+1) =  red_k*table1 + green_k*table2 + blue_k*table2;    %100
    X(6,i+1) =  red_k*table1 + green_k*table2 + blue_k*table1;    %101
    X(7,i+1) =  red_k*table1 + green_k*table1 + blue_k*table2;    %110
    X(8,i+1) =  red_k*table1 + green_k*table1 + blue_k*table1;    %111
   
end
%==========================================================================
XXn = (X./1.088754).^1/3;
%X = X./1.088754;
%XXn = 7.787.*X + 0.13793103448;

matrix_save(XXn);

end

