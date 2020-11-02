function rs_cvhull    = check_cvhull_part(object,NUM_PART,THR_block,THR_convex)
                                            
GOOD = 1;
BAD  = 0;
%=========================================================% PART 1
len_obj  = size(object,1);
len_part = floor(len_obj/NUM_PART);

xO       = round(sum(object(:,1))/len_obj);
yO       = round(sum(object(:,2))/len_obj);

for i=0:(NUM_PART-1)
    %--------------------------------------- get the coordinate A and B
    pnt_st    = floor(len_obj/NUM_PART)*i +1;
    xA        = object(pnt_st,1);
    yA        = object(pnt_st,2);
    
    pnt_end   = floor(len_obj/NUM_PART)*i+len_part;
    xB        = object(pnt_end,1);
    yB        = object(floor(len_obj/NUM_PART)*i+len_part,2);
    
    convex    = 0;
    concave   = 0;
    cnt_block = 0;
    %--------------------------------------- formula for AB
    vl_ori    = (yA-yB)*(xO-xA) + (xB-xA)*(yO-yA);
    for ii= pnt_st + 1:pnt_end - 1  
        xC = object(ii,1);
        yC = object(ii,2);
        
        vl_check   = (yA-yB)*(xC-xA) + (xB-xA)*(yC-yA);
        %------------------------------- 
        if (vl_ori*vl_check < 0)
            convex  = convex  + 1;
        else
            concave = concave + 1;
        end
    end
    %---------------------------------------
    a = (concave/(convex+concave));
    if (a > THR_convex)
        cnt_block = cnt_block + 1;
    end
end
%---------------------------------------------------------%
if cnt_block >= THR_block
    rs_cvhull = BAD;
else 
    rs_cvhull = GOOD;
end
end

