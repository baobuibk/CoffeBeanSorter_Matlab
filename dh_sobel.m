function [Gx,Gy] = dh_sobel(I)

%--------------------------------------------------------------------------%
I = double(I);
[hang,cot] = size(I);
Gx        = zeros(hang,cot);                                               %sobex     = [1 0 -1;2 0 -2;1 0 -1];
Gy        = zeros(hang,cot);                                               %sobey     = [1 2 1;0 0 0;-1 -2 -1]
anh       = dh_zero_pading1(I);                                            %hangmoi   = hang +2; %cotmoi    = cot +2;
%--------------------------------------------------------------------------%
for h=1:hang
    for c=1:cot
        Gx(h,c) =(anh(h,c)+2*anh(h+1,c)+anh(h+2,c)) - (anh(h,c+2)+2*anh(h+1,c+2)+anh(h+2,c+2)); 
        Gy(h,c) =(anh(h,c)+2*anh(h,c+1)+anh(h,c+2)) - (anh(h+2,c)+2*anh(h+2,c+1)+anh(h+2,c+2));
    end
end      
end

