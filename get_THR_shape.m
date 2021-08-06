function [True_value,False_value] = get_THR_shape(  file,...
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
        for THR_convex=0.1:0.02:0.45
            for THR_block=1:3
                %-------------------------------------------- prepare parameter
                nb_obj_ge = 0;
                result_ge = [];                          
                %--------------------------------------------
                for i=3:length
                    IMG = imread(listTemplate(i).name);
                    IMG = imresize(IMG,[240 320]);
                    %---------------------------------% SEGMENTATION    
                    [IMGBi,~,IMG_sub] = segmentation_RGB(   IMG,...
                                                            background,...
                                                            add_thres_otsu); %Use RGB %-25
                      
                    [center,~,out_pst_pxl,nb_obj_real,order_lb,img_label] = pre_evaluation(IMGBi);

                    %---------------------------------% find border and calculate result
                    if (nb_obj_real ~= 0)
                        result = features_evaluation(   IMG_sub,...                         %remember to add some broken line into result 
                                                        out_pst_pxl,...
                                                        order_lb,...
                                                        center,...
                                                        img_label,...
                                                        nb_obj_real,...
                                                        num_part,...
                                                        THR_convex,...
                                                        THR_block);
                    end
                    result_ge  = [result_ge;result];
                    nb_obj_ge  = nb_obj_ge + nb_obj_real;
                    
                    fprintf('add_thres_otsu: %d  num_part: %d  THR_convex = %d THR_block = %d i=%d\n',...
                            add_thres_otsu,num_part,THR_convex,THR_block,i);
                %---------------------------------%
                end         %end round 1
            %--------------------------------------------
            
                if type == BAD
                    true_object = sum(1-result(:,3));                  %if result get BAD value, result = 0=> 1-result will get 1
                    percent     = (sum(1-result(:,3))/nb_obj_ge) * 100;
                else 
                    true_object = sum(result(:,3));
                    percent     = (sum(result(:,3))/nb_obj_ge) * 100;
                end
        
                True_value = [True_value ;add_thres_otsu,num_part,THR_convex,THR_block,true_object,nb_obj_ge];
                False_value= [False_value;add_thres_otsu,num_part,THR_convex,THR_block,nb_obj_ge-true_object,nb_obj_ge];
        
                fprintf(file,'add_thres_otsu: %d    num_part: %d  THR_convex = %d THR_block = %d true_object= %d nb_obj_ge= %d  percent = %.2f\n',...
                            add_thres_otsu,num_part,THR_convex,THR_block,true_object,nb_obj_ge,percent);
                
            %--------------------------------------------
            end
            fprintf(file,'================================= \n');
        end
        fprintf(file,'================================= \n');
    end
    fprintf(file,'================================= \n');
end
end

