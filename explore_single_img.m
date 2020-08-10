function [img,img_check]  = explore_single_img(pos_single,IMGSeg_CIE)


%==========================================================================
% This funtion explores single object and returns a image what needs for 
% next steps
%==========================================================================

img             =   [];
IMGSeg_CIE      =   double(IMGSeg_CIE);
[row,col,~]     =   size(IMGSeg_CIE);
%test            =   IMGSeg_CIE(:,:,3);
min_positon     =   min(pos_single,[],1);
min_row         =   min_positon(1,1);
min_col         =   min_positon(1,2);

max_positon     =   max(pos_single,[],1);
max_row         =   max_positon(1,1);
max_col         =   max_positon(1,2);

img_check       =   zeros(row,col);
sum_lbcur       =   0;

%=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-= explore min rectangle 

img_check(min_row:max_row,min_col:max_col) = IMGSeg_CIE(min_row:max_row,min_col:max_col,1);
%write_img2text(img_check,2);
[img_label,num_obj]      = bwlabel(img_check,8);

for obj=1:num_obj
    %---------------------------------------------
    sum_lbnxt = 0;
    for iii=1:row
        for jjj=1:col
            if img_label(iii,jjj) == obj
                sum_lbnxt = sum_lbnxt+1;
            end
        end
    end
    %--------------------------------------------- explore max object
    if (sum_lbnxt > sum_lbcur)
        sum_lbcur = sum_lbnxt;
        sa_obj    = obj;
    end
end

%=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-= found object
for ii=1:row
    for jj=1:col
        if img_label(ii,jj) == sa_obj
            img_check(ii,jj) = 1;
        else
            img_check(ii,jj) = 0;
        end
    end
end
%=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=

img(:,:,1) = img_check.*IMGSeg_CIE(:,:,1);
img(:,:,2) = img_check.*IMGSeg_CIE(:,:,2);
img(:,:,3) = img_check.*IMGSeg_CIE(:,:,3);
%img        = uint8(img);
%imagesc(img);
%write_img2text(img(:,:,3),2);

end

