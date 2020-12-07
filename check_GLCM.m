function [rs_GLCM] = check_GLCM(IMG,img_label,out_border)

GOOD        = 1;
BAD         = 0;
num_obj     = size(out_border,1);
top         = 0;
bottom      = 0;
left        = 0;
right       = 0;

RED_chanel  = IMG(:,:,1);
for obj=1:num_obj
    bd_obj          = out_border{obj};
    top             = min(bd_obj(:,1));
    down            = max(bd_obj(:,1));
    left            = min(bd_obj(:,2));
    right           = max(bd_obj(:,2));
    
    object          = RED_chanel(top:down,left:right);
    obj_label       = img_label(top:down,left:right);
    label           = (obj_label(:,:) == obj);
    object_GLCM     = object.*uint8(label);
    
    [GLCM90]        = graycomatrix(object_GLCM,'NumLevels',64,'Offset',[-1 0]);
    [GLCM0]         = graycomatrix(object_GLCM,'NumLevels',64,'Offset',[0 1]);
    
    stats           = graycoprops(floor((GLCM90+GLCM0)/2),{'Contrast',...
                      'Correlation','Energy','Homogeneity'});
                
%    a = stats{Contrast};   
    C = struct2cell(stats);
    
                  
                  
                  
              
end
end

