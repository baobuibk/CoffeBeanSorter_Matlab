function out_img = lammanh_process( in_img)
%[hang,cot] = size(ANHGOC);
%--------------------------------------------------------------------------%
%in_img = 1- in_img;
out_img   =  lm_step1(in_img);
out_img   =  lm_step2(out_img);
%=======================================
%out_img   =  lm_pointstraight(out_img);
%=======================================
%out_img   = lm_step3(out_img);
%out_img   = 1- out_img;

%write_img2text(out_img,2);

end

