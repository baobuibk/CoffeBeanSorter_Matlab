function convexity   = check_convexhull1(out_border,img_label)

%===============================================================
% This function check whether coffee beans are broken or not. 
% If a object is broken, it's normally deformed -> convex. By contrast, 
% it will be concave. Using convex hull algorithm to check this
% property.
%===============================================================

GOOD =  1;
BAD  =  0;
num_obj = size(out_border,1);

convexity = [];
for obj=1:num_obj
    area_object         = sum(sum(img_label == obj));
    object              = out_border{obj};
    [bd_cvh,area_cvh]   = convhull(object);
    flag_conv           = area_object/(area_cvh+size(bd_cvh,1));
    if flag_conv <0.98   
        convexity  = [convexity;flag_conv,BAD];
    else
        convexity  = [convexity;flag_conv,GOOD];
    end
%    plot(object1(border,2),object1(border,1),'r');
end
end

