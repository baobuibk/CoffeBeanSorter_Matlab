function noimg = dh_lammuotgoc(oimg)

    gx             =   cos(2*oimg);
    gy             =   sin(2*oimg);
    [gfx,gfy]      =   dh_gauss55(gx,gy);                                  %[gfx,gfy] = gauss_processnew(gx,gy);
    noimg          =   atan2(gfy,gfx); 
    noimg(noimg<0) =   noimg(noimg<0)+2*pi;
    noimg          =   0.5*noimg;
end