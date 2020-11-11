function rs_cvhull = check_convexhull(out_border,NUM_PART,THR_block,THR_convex)
                                        
%---------------------------------------
GOOD = 1;
BAD  = 0;
nb_obj = size(out_border,1);
rs_cvhull = [];

%---------------------------------------
for obj=1:nb_obj
   object        = out_border{obj};
   
   %---------------------------------get lengh of out_border
   len_object    = size(object,1);
   
   %---------------------------------part 1
   part1         = object;
   rs_cvhull1    = check_cvhull_part(part1,NUM_PART,THR_block,THR_convex);
   
   %---------------------------------part 2
   pos_part2     = floor(size(object,1)/3);
   part2         = [object(pos_part2:len_object,:);object(1:pos_part2,:)];         
   rs_cvhull2    = check_cvhull_part(part2,NUM_PART,THR_block,THR_convex);
   
   %---------------------------------part 3
   pos_part3     = floor(2*size(object,1)/3);
   part3         = [object(pos_part3:len_object,:);object(1:pos_part3,:)];                                 
   rs_cvhull3    = check_cvhull_part(part3,NUM_PART,THR_block,THR_convex);
  
   %---------------------------------result
   rs_cvhull     = [rs_cvhull;rs_cvhull1 & rs_cvhull2 & rs_cvhull3];
                                    
end
%---------------------------------------
end

