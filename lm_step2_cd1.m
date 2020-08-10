function I   =  lm_step2_cd1(I)
[hang,cot] = size(I);
M          = uint8(ones(hang,cot));
I          = uint8(I);
%mtP        = zeros(3,3);
%P = zeros(1,8);
for h=2:(hang-1)
    for c=2:(cot-1)
        if (I(h,c)~=0)          
       
            %=========================================================condition2
            P1  = I(h-1,c-1);   P2 = I(h-1,c  );   P3 = I(h-1,c+1);
            P4  = I(h  ,c+1);   P5 = I(h+1,c+1);   P6 = I(h+1,c  );
            P7  = I(h+1,c-1);   P8 = I(h  ,c-1);   
            %-------------------------------------------------------------------%
            condition2 = (~P4)&&P8&&((P2&&(~P5)&&(~P6))||((~P2)&&(~P3)&&P6));
            if (condition2==1)
                M(h,c) = 0;
            end
        end
    end
end
I=I.*M;
end

