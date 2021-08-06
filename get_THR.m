function [True_value,False_value] = get_THR(   file,...
                                                length,...
                                                listTemplate,...
                                                type) 
                                                

%==========================================================================
background     = imread("D:\B. WORK\1. CODE_PROJECT\MATLAB\matlab_coffee_bean\sample\background.jpg");
background     = imresize(background,0.5);

True_value     = [];
False_value    = [];
BAD            = 0;
GOOD           = 1;

for add_thres_otsu=9:20
    for num_part=5:9
        for THR_convex=0.1:0.05:0.45
            for THR_block=1:3
            %-------------------------------------------- prepare parameter
            nb_obj = 0;
            result = [];                          
            %--------------------------------------------
            for i=3:length
                IMG = imread(listTemplate(i).name);
                %---------------------------------% SEGMENTATION    
                [IMGBi,~,IMG_sub] = segmentation_RGB(   IMG,...
                                                        background,...
                                                        add_thres_otsu); %Use RGB %-25
    
                 [center,~,out_pst_pxl,nb_obj_real,order_lb,img_label] = pre_evaluation(IMGBi);

                %---------------------------------% find border and calculate result
                 if (nb_obj_real ~= 0)
                    result = features_evaluation(   IMG_sub,...                         %remember to add some broken line into result 
                                                    out_pst_pxl,...
                                                    order_lb,...,
                                                    center,...
                                                    img_label,...
                                                    nb_obj_real,...
                                                    num_part,...
                                                    THR_convex,...
                                                    THR_block);
                 end
                result  = [result;result_single];
                nb_obj  = nb_obj + nb_obj_single;
                %---------------------------------%
            end         %end round 1
            %--------------------------------------------
            
        
        if type == BAD
            true_object = sum(1-result(:,2));
            percent     = (sum(1-result(:,2))/nb_obj) * 100;
        else 
            true_object = sum(result(:,2));
            percent     = (sum(result(:,2))/nb_obj) * 100;
        end
        
        True_value = [True_value ;thr_pxl,thr_percent,true_object,nb_obj];
        False_value= [False_value;thr_pxl,thr_percent,nb_obj-true_object,nb_obj];
        
        fprintf(file,'thr_pxl: %d    thr_percent: %d  number_object = %d true_object = %d percent = %.2f\n',...
                thr_pxl,thr_percent,nb_obj,true_object,percent);
            
    %--------------------------------------------
            end
        end
    fprintf(file,'================================= \n');
    fprintf(file,' \n'); 
    end
end

