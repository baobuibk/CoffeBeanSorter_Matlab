function rs_LBPs         = LBPs(out_border,IMG)

GOOD        = 1;
BAD         = 0;
top         = 0;
bottom      = 0;
left        = 0;
right       = 0;

%===============================================================
% This function calculates the Local binary pattern of object
% to give the quality inside coffee beans whether it is broken or not
%
%
%===============================================================

num_obj     = size(out_border,1);
IMG_gray    = IMG(:,:,2);

for obj=1:num_obj
    object          = out_border{obj};
    top             = min(object(:,1));
    down            = max(object(:,1));
    left            = min(object(:,2));
    right           = max(object(:,2));
    
    LBP_object      = extractLBPFeatures(IMG_gray(top:down,left:right),'NumNeighbors',16,'Radius',2);
    figure;
    bar(LBP_object,'grouped');



end

