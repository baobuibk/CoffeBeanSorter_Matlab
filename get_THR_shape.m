function [True_value,False_value] = get_THR_shape(  file,...
                                                    length,...
                                                    listTemplate,...
                                                    type) 
                                                

%==========================================================================
background     = imread("D:\B. WORK\1. CODE_PROJECT\MATLAB\matlab_coffee_bean\sample\background.jpg");

True_value     = [];
False_value    = [];
BAD            = 0;
GOOD           = 1;

for add_thres_otsu=-17:1:-11
    for num_part=5:7
        for THR_convex=0.2:0.05:0.35
            for THR_block=1:2
                for THR_GLCM=0.09:0.01:0.2

                %-------------------------------------------- prepare parameter
                nb_obj_ge = 0;
                result_ge = [];                          
                %--------------------------------------------
                for i=3:length
                    IMG = imread(listTemplate(i).name);
                    
                    %---------------------------------% SEGMENTATION    
                    [IMGBi,~,IMG_sub] = segmentation_RGB( IMG,...
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
                                                        THR_block,...
                                                        THR_GLCM);
                    end
                    resultsum  = result(:,1)&result(:,2)&result(:,3);
                    result_ge  = [result_ge;resultsum];
                    nb_obj_ge  = nb_obj_ge + nb_obj_real;
                    
                    fprintf('add_thres_otsu: %d  num_part: %d  THR_convex = %d THR_block = %d  THR_GLCM = %d  i=%d\n',...
                            add_thres_otsu,num_part,THR_convex,THR_block,THR_GLCM,i);
                %---------------------------------%
                end         %end round 1
            %--------------------------------------------
            
                if type == BAD
                    true_object = sum(1-result_ge);                  %if result get BAD value, result = 0=> 1-result will get 1
                    percent     = (sum(1-result_ge(:,4))/nb_obj_ge) * 100;
                else 
                    true_object = sum(result_ge(:,4));
                    percent     = (sum(result_ge(:,4))/nb_obj_ge) * 100;
                end
        
                True_value = [True_value ;add_thres_otsu,num_part,THR_convex,THR_block,THR_GLCM,true_object,nb_obj_ge];
                False_value= [False_value;add_thres_otsu,num_part,THR_convex,THR_block,THR_GLCM,nb_obj_ge-true_object,nb_obj_ge];
        
                fprintf(file,'add_thres_otsu: %d    num_part: %d  THR_convex = %d THR_block = %d true_object= %d THR_GLCM= %d nb_obj_ge= %d  percent = %.2f\n',...
                            add_thres_otsu,num_part,THR_convex,THR_block,true_object,nb_obj_ge,percent);
                
            %--------------------------------------------
                end
            end
            fprintf(file,'================\n');
        end
        fprintf(file,'================================= \n');
    end
    fprintf(file,'================*****================= \n');
end
end

