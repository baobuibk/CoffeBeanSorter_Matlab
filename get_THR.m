function [True_value,False_value] = get_THR(    ADD_BINARY_THR,...
                                                file,...
                                                length,...
                                                listTemplate,...
                                                type)

%==========================================================================
background     = imread("D:\B. WORK\1. CODE_PROJECT\MATLAB\matlab_coffee_bean\sample\background.jpg");
True_value     = [];
False_value    = [];
BAD            = 0;
GOOD           = 1;

for thr_pxl=0:20
    count1 = 0;
    for thr_percent=0.02:0.01:0.2
        %-------------------------------------------- prepare parameter
        count = 0;
        count1 = count1 +1;
        fprintf("andepzai ahihi %d \n",count1);
        nb_obj = 0;
        result = [];                          
        %--------------------------------------------
        for i=3:length
            count = count+1
            IMG = imread(listTemplate(i).name);
            %---------------------------------% SEGMENTATION    
            [IMGBi,~,IMG] = segmentation_RGB(   IMG,...
                                                background,...
                                                ADD_BINARY_THR); %Use RGB %-25
    
            [~,out_border,~,img_label,nb_obj_single] = find_border_matlab(IMGBi);

            %---------------------------------% find border and calculate result
            if (nb_obj_single ~= 0)
                result_single = features_evaluation(    IMG,...
                                                        out_border,...
                                                        img_label,...
                                                        thr_pxl,...
                                                        thr_percent); 
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
    fprintf(file,'================================= \n');
    fprintf(file,' \n'); 
end
end

