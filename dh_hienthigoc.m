function dh_hienthigoc(teta)
[h,w]   =   size(teta);
 x       =   0:w-1;
 y       =   0:h-1;
quiver(x,y,cos(teta),sin(teta),0.3);
%axis([0 w 0 h]),axis image, axis ij;
axis([0 w 0 h]), axis ij;
end

