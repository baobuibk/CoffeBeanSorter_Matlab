function [img, row, col,dir3, name_img ] = Load_img()

    [name_img, direct] = uigetfile('*.bmp;*.BMP;*.tif;*.TIF;*.jpg;*.raw;','Open An Image');
    full               = strcat(direct,name_img);
    img                = imread(full);
    [row,col,dir3]     = size(img);

end

