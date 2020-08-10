function teta = dh_tinhgoc( Gx,Gy,block )
[hang,cot] = size(Gx);
Vx         = zeros(hang/block,cot/block);
Vy         = zeros(hang/block,cot/block);
teta       = zeros(hang/block,cot/block);
GxGy        = Gx.*Gy;
GxGy2       = (Gx+Gy).*(Gx-Gy);
%--------------------------------------------------------------------------%
for h=1:block:hang
    for c=1:block:cot  
        i = (h-1)/block + 1;
        j = (c-1)/block + 1;      
        %------------------------------------------------- tinh tung block
        for ph=1:block
            for pc=1:block
                Vy(i,j) = Vy(i,j) + 2*GxGy(h+ph-1,c+pc-1);
                Vx(i,j) = Vx(i,j) + GxGy2(h+ph-1,c+pc-1);
            end
        end
        %------------------------------------------------- tinh goc dinh huong
       if Vx == 0
           teta(i,j) = pi/2;
       else 
          teta(i,j) = atan2(Vy(i,j),Vx(i,j))/2 + pi/2;
       end
    end
end
end

