function color  = evaluate_color(IMG_seg,img_label,num_object,order_lb,THR_PXL,THR_PERCENT_LOWPXL)

%THR_PXL = 11;
%THR_PERCENT_LOWPXL = 0.07;
GOOD = 1;
BAD  = 0;
R = IMG_seg(:,:,1);             %Using red channel to analyze 
color = [];

for obj=1:num_object
    
        [row_his,col_his]   =   find(img_label == order_lb(obj,1));
        len_his             =   size(row_his,1);             %the number of pixel in each object
        his_obj             =   [];
        %-----------------------------
        for ii=1:len_his
            his_obj         =   [his_obj;R(row_his(ii),col_his(ii))];
        end
        %-----------------------------
%    his_R   =   histogram(his_obj,'BinLimits',[0,255],'Normalization','probability');
%    his_R   =   histogram(his_obj,'BinLimits',[0,25],'Normalization','probability');
        hist_zeros = sum(his_obj <= THR_PXL)/len_his;
    
        %-----------------------------
        if hist_zeros >= THR_PERCENT_LOWPXL
            color = [color;BAD];
        else
            color = [color;GOOD];
        end
end
%===================================================
end

