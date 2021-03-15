function bd_array = get_obj_row(row_array,bd_array,pos_obj_arr,nb_pxl_row,last_lb)

if nb_pxl_row==1
    bd_array(pos_obj_arr(last_lb,1),1) = row_array(1,1);
    bd_array(pos_obj_arr(last_lb,1),2) = row_array(1,2);
elseif nb_pxl_row==2
    
    
else
    for i = 2:nb_pxl_row
        if (row_array(i,1)-row_array(i-1,1)) > 1   %checking splited points
    
    
    
    
        else 
            continue;
        end
    end
end
end

