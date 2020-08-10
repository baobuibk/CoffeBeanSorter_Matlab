function teta = dir_angle( Gx,Gy,pos_pxl,num_object,block)


%{
[hang,cot] = size(Gx);
Vx         = zeros(hang/block,cot/block);
Vy         = zeros(hang/block,cot/block);
teta       = zeros(hang/block,cot/block);
%}
pnt_end     = 0;
[row,col]   = size(Gx);
teta        = zeros(row,col);
Vy          = zeros(row,col);
Vx          = zeros(row,col);
GxGy        = Gx.*Gy;
GxGy2       = (Gx+Gy).*(Gx-Gy);
%--------------------------------------------------------------------------%
%{
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
%}
%--------------------------------------------------------------------------%
for i = 1:num_object
    pnt_st     = pnt_end    + 2;
    pnt_end    = pnt_st     + pos_pxl(pnt_st-1,2) - 1;
    pos_single = pos_pxl(pnt_st:pnt_end,:); 
    
    for num_pxl = 1 : size(pos_single,1)
        %------------------------------------------
        lmt_r_high    = pos_single(num_pxl,1) - block/2;
        lmt_r_low     = pos_single(num_pxl,1) + block/2;
        lmt_c_left    = pos_single(num_pxl,2) - block/2;
        lmt_c_right   = pos_single(num_pxl,2) + block/2;
        r_center      = pos_single(num_pxl,1);
        c_center      = pos_single(num_pxl,2);
        for pr = lmt_r_high:lmt_r_low
            for pc = lmt_c_left:lmt_c_right
                Vy(r_center,c_center) = Vy(r_center,c_center) + 2*GxGy(pr,pc);
                Vx(r_center,c_center) = Vx(r_center,c_center) +  GxGy2(pr,pc);
            end
        end
        %------------------------------------------
        %------------------------------------------------- tinh goc dinh huong
       if Vx(r_center,c_center) == 0
           teta(r_center,c_center) = pi/2;
       else 
          teta(r_center,c_center) = atan2(Vy(r_center,c_center),Vx(r_center,c_center))/2 + pi/2;
       end
    end
end
%--------------------------------------------------------------------------%
end

