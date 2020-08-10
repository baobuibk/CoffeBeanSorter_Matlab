function [Gx,Gy] = dir_sobel(IMG)

%--------------------------------------------------------------------------%
%IMG = double(IMG);
[row,col] = size(IMG);
Gx        = zeros(row,col);                                                 %sobex     = [1 0 -1;2 0 -2;1 0 -1];
Gy        = zeros(row,col);                                                 %sobey     = [1 2 1;0 0 0;-1 -2 -1]
%IMG       = dh_zero_pading1(I);                                            %hangmoi   = hang +2; %cotmoi    = cot +2;
%--------------------------------------------------------------------------%
for r=6:row-5
    for c=6:col-5
        Gx(r,c) =(IMG(r,c)+2*IMG(r+1,c)+IMG(r+2,c)) - (IMG(r,c+2)+2*IMG(r+1,c+2)+IMG(r+2,c+2)); 
        Gy(r,c) =(IMG(r,c)+2*IMG(r,c+1)+IMG(r,c+2)) - (IMG(r+2,c)+2*IMG(r+2,c+1)+IMG(r+2,c+2));
    end
end      
end

