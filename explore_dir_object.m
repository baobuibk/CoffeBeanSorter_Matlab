function  teta = explore_dir_object(IMGi,pos_pixel,num_object)
%================================================
% This function explore direction of object
%   
%
%================================================
    block   = 16;
    IMGi    = double(IMGi);
    [Gx,Gy] = dir_sobel(IMGi);                                              %[Gx,Gy] = sobel_processnew(anh);
    teta    = dir_angle(Gx, Gy, pos_pixel, num_object, block);
%    teta    = dh_lammuotgoc(teta);
    dh_hienthigoc(teta);

end

