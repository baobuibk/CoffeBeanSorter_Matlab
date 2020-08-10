function teta = dinhhuong_process(IMG,block )
 %-------------------------------------------------------------------------%
IMG = double(IMG);
[Gx,Gy] = dh_sobel(IMG);                                                   %[Gx,Gy] = sobel_processnew(anh);
teta    = dh_tinhgoc(Gx,Gy,block);
teta    = dh_lammuotgoc(teta);
dh_hienthigoc(teta);

end

