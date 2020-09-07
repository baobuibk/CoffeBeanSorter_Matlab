function [result,x_center,y_center]     = check_single_shape(pos_npx1,num_part,THR_convex,THR_block)

GOOD = 1;
BAD  = 0;

%=========================================================%
total_pxl   = (size(pos_npx1,1));
xO          = sum(pos_npx1(:,1))/total_pxl;                                  % 'O' is original point 
yO          = sum(pos_npx1(:,2))/total_pxl;

len_avr     = floor(total_pxl/num_part);

pos2         = floor(len_avr/3);
pos3         = floor(len_avr*2/3);

pos_npx2     = [pos_npx1(( pos2 + 1):total_pxl,:);pos_npx1(1:pos2,:)]; % new position when transfer
pos_npx3     = [pos_npx1(( pos3 + 1):total_pxl,:);pos_npx1(1:pos3,:)]; % new position when transfer 


cnt_block       = 0;
cnt_block_t1    = 0;
cnt_block_t2    = 0;

%THR_dis_pix     = 0.9;
%THR_dis_per     = 0.3;  
%=========================================================% PART 1

for i=0:(num_part-1)
    pnt_st    = i*len_avr + 1;          
    pnt_end   = pnt_st +len_avr - 1;
    
    A         = pos_npx1(pnt_st,:);
    B         = pos_npx1(pnt_end,:);
    xA        = A(1,1);
    yA        = A(1,2);
    xB        = B(1,1);
    yB        = B(1,2);
    
    convex    = 0;
    concave   = 0;
%    count_dis = 0;
    vl_ori    = (yA-yB)*(xO-xA) + (xB-xA)*(yO-yA);
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%
    for ii= pnt_st + 1:pnt_end - 1  
        xC = pos_npx1(ii,1);
        yC = pos_npx1(ii,2);
        vl_check   = (yA-yB)*(xC-xA) + (xB-xA)*(yC-yA);
        %------------------------------- check distance from point to line 
%        dxC        = abs(vl_check)/(sqrt((yA-yB)^2 + (xB-xA)^2));
%        if dxC <= THR_dis_pix
%           count_dis = count_dis + 1;
%        end
        %-------------------------------
        if (vl_ori*vl_check < 0)
            convex  = convex  + 1;
        else
            concave = concave + 1;
        end
    end
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%
    a = (concave/(convex+concave));
%    count_dis = count_dis/(convex+concave);
    if (a > THR_convex)% || (count_dis > THR_dis_per))
        cnt_block = cnt_block + 1;
    end
end
%---------------------------------------------------------%
if cnt_block >= THR_block
    result1 = BAD;
else 
    result1 = GOOD;
end


%=========================================================% PART 2

 for i=0:(num_part-1)
    pnt_st     = i*len_avr + 1;          
    pnt_end    = pnt_st + len_avr - 1;
    
    At         = pos_npx2(pnt_st,:);
    Bt         = pos_npx2(pnt_end,:);
    xAt        = At(1,1);
    yAt        = At(1,2);
    xBt        = Bt(1,1);
    yBt        = Bt(1,2);
    
    convex     = 0;
    concave    = 0;
%    count_dis   = 0;
    vl_ori_t   = (yAt-yBt)*(xO-xAt) + (xBt-xAt)*(yO-yAt);
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%
    for ii= pnt_st + 1:pnt_end - 1  
        xCt = pos_npx2(ii,1);
        yCt = pos_npx2(ii,2);
        vl_check_t   = (yAt-yBt)*(xCt-xAt) + (xBt-xAt)*(yCt-yAt);
        %------------------------------- check distance from point to line
%        dxC        = abs(vl_check_t)/(sqrt((yAt-yBt)^2 + (xBt-xAt)^2));
%        if dxC <= THR_dis_pix
%            count_dis = count_dis + 1;
%        end
        %-------------------------------
        if (vl_ori_t*vl_check_t < 0)
            convex  = convex  + 1;
        else
            concave = concave + 1;
        end
    end
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%
    b = (concave/(convex+concave));
%    count_dis = count_dis/(convex+concave);
    if ((b> THR_convex)) %|| (count_dis > THR_dis_per))
        cnt_block_t1 = cnt_block_t1 + 1;
    end
end
%---------------------------------------------------------%

if cnt_block_t1 >= THR_block
    result2 = BAD;
else 
    result2 = GOOD;
end


%=========================================================% PART 3
for i=0:(num_part-1)
    pnt_st = i*len_avr + 1;          
    pnt_end   = pnt_st +len_avr - 1;
    
    At2         = pos_npx3(pnt_st,:);
    Bt2         = pos_npx3(pnt_end,:);
    xAt2        = At2(1,1);
    yAt2        = At2(1,2);
    xBt2        = Bt2(1,1);
    yBt2        = Bt2(1,2);
    
    convex    = 0;
    concave   = 0;
%    count_dis   = 0;
    vl_ori_t2   = (yAt2-yBt2)*(xO-xAt2) + (xBt2-xAt2)*(yO-yAt2);
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%
    for ii= pnt_st + 1:pnt_end - 1  
        xCt2 = pos_npx3(ii,1);
        yCt2 = pos_npx3(ii,2);
        vl_check_t   = (yAt2-yBt2)*(xCt2-xAt2) + (xBt2-xAt2)*(yCt2-yAt2);
         %------------------------------- check distance from point to line 
%        dxC   = abs(vl_check_t)/(sqrt((yAt2-yBt2)^2 + (xBt2-xAt2)^2));
%        if dxC <= THR_dis_pix
%            count_dis = count_dis + 1;
%        end
        %-------------------------------
        if (vl_ori_t2*vl_check_t < 0)
            convex  = convex  + 1;
        else
            concave = concave + 1;
        end
    end
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%
    c = (concave/(convex+concave));
%    count_dis = count_dis/(convex+concave);
    if (( c> THR_convex)) %|| (count_dis > THR_dis_per))
        cnt_block_t2 = cnt_block_t2 + 1;
    end
end
%---------------------------------------------------------%

if cnt_block_t2 >= THR_block
    result3 = BAD;
else 
    result3 = GOOD;
end

%=========================================================%

result = result1 && result2 && result3;
x_center = floor(xO);
y_center = floor(yO);
end

