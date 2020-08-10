function anh = dh_morong_dx2( I )
[hang,cot]   = size(I);
anh          = zeros(hang+4,cot+4);
[hangmoi,cotmoi] = size(anh);
%==========================================================================%       
        for h=1:hang
            for c=1:cot
                anh(h+2,c+2) = I(h,c);
            end
        end
%--------------------------------------------------------------------------% sao chep bien cot  
       for c1=3:cotmoi-2
           anh(2,c1)         = anh(3,c1);
           anh(1,c1)         = anh(4,c1);
           anh(hangmoi-1,c1) = anh(hangmoi-2,c1);
           anh(hangmoi  ,c1) = anh(hangmoi-3,c1);
       end
%--------------------------------------------------------------------------% sao chep bien hang
       for h1=3:hangmoi-2
           anh(h1,2)        = anh(h1,3);
           anh(h1,1)        = anh(h1,4);
           anh(h1,cotmoi-1) = anh(h1,cotmoi-2);
           anh(h1,cotmoi  ) = anh(h1,cotmoi-3);
       end
%--------------------------------------------------------------------------% goc thu nhat
       anh(1,1) = anh(4,4);
       anh(1,2) = anh(1,3);
       anh(2,1) = anh(3,1);
       anh(2,2) = anh(3,3);
%--------------------------------------------------------------------------% goc thu 2
       anh(1,cotmoi-1)  = anh(1,cotmoi-2);
       anh(1,cotmoi)    = anh(4,cotmoi-3);
       anh(2,cotmoi-1)  = anh(3,cotmoi-2);
       anh(2,cotmoi)    = anh(3,cotmoi);
%--------------------------------------------------------------------------% goc thu 3
       anh(hangmoi-1,1) = anh(hangmoi-2,1);
       anh(hangmoi-1,2) = anh(hangmoi-2,3);
       anh(hangmoi  ,1) = anh(hangmoi-3,4);
       anh(hangmoi  ,2) = anh(hangmoi  ,3);
%--------------------------------------------------------------------------% goc thu 4
       anh(hangmoi-1,cotmoi-1) = anh(hangmoi-2,cotmoi-2);
       anh(hangmoi-1,cotmoi  ) = anh(hangmoi-2,cotmoi  );
       anh(hangmoi  ,cotmoi-1) = anh(hangmoi  ,cotmoi-2);
       anh(hangmoi  ,cotmoi  ) = anh(hangmoi-2,cotmoi-3);
          
end

