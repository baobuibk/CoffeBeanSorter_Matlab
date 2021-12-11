function [rs_GLCM] = check_GLCM(IMG,img_label,out_border,num_obj)


THR_GLCM    = 0.13;
GOOD        = 1;
BAD         = 0;
top         = 0;
bottom      = 0;
left        = 0;
right       = 0;
rs_GLCM     = [];
parameter   = [];

RED_chanel  = IMG(:,:,1);
pnt         = 1;


for obj=1:num_obj
    nb_border_pxl   = out_border(pnt,2);
    if (nb_border_pxl ~=1)                %if not containing the noise
        bd_obj          = out_border(pnt+1:nb_border_pxl+pnt,:);
        pnt             = pnt + nb_border_pxl+1;
    
        
        top             = min(bd_obj(:,1));
        down            = max(bd_obj(:,1));
        left            = min(bd_obj(:,2));
        right           = max(bd_obj(:,2));
    
        object          = RED_chanel(top:down,left:right);
        obj_label       = img_label(top:down,left:right);
        label           = (obj_label(:,:) == obj);
        object_GLCM     = object.*uint8(label);
    
        [GLCM90]        = graycomatrix(object_GLCM,'NumLevels',128,'Offset',[-1 0]);
        [GLCM0]         = graycomatrix(object_GLCM,'NumLevels',128,'Offset',[0 1]);
    
        stats           = graycoprops(floor((GLCM90+GLCM0)/2),{'Energy'});
               
        parameter       = struct2cell(stats);
    
        if (parameter{1} >= THR_GLCM)               %0.13
            rs_GLCM         = [rs_GLCM;BAD];
        else
            rs_GLCM         = [rs_GLCM;GOOD];
        end
    else
        rs_GLCM         = [rs_GLCM;BAD];
        pnt =pnt+2;
    end
    
    %{
    fprintf(GLCM_text,"contrast: %.4f   Correlation:%.4f   Energy:%.4f   Homogeneity:%.4f \n",...
                      parameter{1},     parameter{2},      parameter{3}, parameter{4}  );  
     
    count          = count + 1
                  %}
end
end

