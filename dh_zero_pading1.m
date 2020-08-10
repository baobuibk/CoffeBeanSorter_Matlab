function anh = dh_zero_pading1( I )
[hang,cot] = size(I);
anh        = zeros(hang+2,cot+2);
[hangmoi,cotmoi] = size(anh);
for h=1:hangmoi
    for c=1:cotmoi
        if (h==1)||(c==1)||(h==hangmoi)||(c==cotmoi)
            anh(h,c) = 0;
        else
            anh(h,c) =I(h-1,c-1);
        end
    end
end
end

