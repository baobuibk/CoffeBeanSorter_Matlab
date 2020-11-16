function color  = evaluate_color(IMG_seg,img_label,num_object)

%[row,col] = size(img_label);

R = IMG_seg(:,:,3);
for obj=1:num_object
    avr_R =  
    his_R =  histogram(R(img_label==obj));
    
    
 
end
end

