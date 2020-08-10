function [ gfx,gfy ] = dh_gauss55( gx,gy )
[hang,cot] = size(gx);
gfx = zeros(hang,cot);
gfy = zeros(hang,cot);
X   = dh_morong_dx2(gx); 
Y   = dh_morong_dx2(gy);
a1=0       ; a2=0       ;  a3=0.0002  ;  a4=0       ; a5=0 ;
a6=0       ; a7=0.0113  ;  a8=0.0837  ;  a9 =0.0113 ; a10=0;
a11=0.0002 ; a12=0.0837 ;  a13=0.6187 ;  a14=0.0837 ; a15=0.0002;
a16=0      ; a17=0.0113 ;  a18=0.0837 ;  a19=0.0113 ; a20=0;
a21=0      ; a22=0      ;  a23=0.0002 ;  a24=0      ; a25=0;
 for h=1:hang
     for c=1:cot
         gfx1 = a1*X(h,c)    + a2*X(h,c+1)    + a3*X(h,c+2)    + a4*X(h,c+3)    + a5*X(h,c+4);
         gfx2 = a6*X(h+1,c)  + a7*X(h+1,c+1)  + a8*X(h+1,c+2)  + a9*X(h+1,c+3)  + a10*X(h+1,c+4);
         gfx3 = a11*X(h+2,c) + a12*X(h+2,c+1) + a13*X(h+2,c+2) + a14*X(h+2,c+3) + a15*X(h+2,c+4);
         gfx4 = a16*X(h+3,c) + a17*X(h+3,c+1) + a18*X(h+3,c+2) + a19*X(h+3,c+3) + a20*X(h+3,c+4);
         gfx5 = a21*X(h+4,c) + a22*X(h+4,c+1) + a23*X(h+4,c+2) + a24*X(h+4,c+3) + a25*X(h+4,c+4);
         gfx(h,c) = gfx1 + gfx2 + gfx3 + gfx4 + gfx5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         gfy1 = a1*Y(h,c)    + a2*Y(h,c+1)    + a3*Y(h,c+2)    + a4*Y(h,c+3)    + a5*Y(h,c+4);
         gfy2 = a6*Y(h+1,c)  + a7*Y(h+1,c+1)  + a8*Y(h+1,c+2)  + a9*Y(h+1,c+3)  + a10*Y(h+1,c+4);
         gfy3 = a11*Y(h+2,c) + a12*Y(h+2,c+1) + a13*Y(h+2,c+2) + a14*Y(h+2,c+3) + a15*Y(h+2,c+4);
         gfy4 = a16*Y(h+3,c) + a17*Y(h+3,c+1) + a18*Y(h+3,c+2) + a19*Y(h+3,c+3) + a20*Y(h+3,c+4);
         gfy5 = a21*Y(h+4,c) + a22*Y(h+4,c+1) + a23*Y(h+4,c+2) + a24*Y(h+4,c+3) + a25*Y(h+4,c+4);
         gfy(h,c) = gfy1 + gfy2 + gfy3 + gfy4 + gfy5;
     end
 end


end

