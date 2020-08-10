function IMG = read_imgtxt()

ROW = 240;
COL = 320;


IMG = zeros(ROW,COL,3);

R = fopen('C:\Users\ducan\Documents\MATLAB\Coffee_bean_Matlab\R.txt');
RED = fscanf(R,'%lf');


G = fopen('C:\Users\ducan\Documents\MATLAB\Coffee_bean_Matlab\G.txt');
GREEN = fscanf(G,'%lf');

B = fopen('C:\Users\ducan\Documents\MATLAB\Coffee_bean_Matlab\B.txt');
BLUE =  fscanf(B,'%lf');

for i=1:ROW
    for j=1:COL
        pos = (i-1)*COL + j;
        IMG(i,j,1) = RED(pos); 
        IMG(i,j,2) = GREEN(pos);
        IMG(i,j,3) = BLUE(pos); 
    end
end


fclose('all');
end

