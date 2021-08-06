%{
%//=========================================================================%
//  This funtion explores labels for an image, return a labeled image
//  and number of labels of an image, this algorithm will abandon border pixels
//  and attach '0' value for them.
//  In this funtion uses algorithm "Two pass" by:
//	"https://en.wikipedia.org/wiki/Connected-component_labeling"
//  max = 499 labels
//  return = E_OVFL_CCLABLE: over flow
//  return = MAX_CCLABLE: don't have any object in the image
//	Note: In this function, img is the input binary image, 
//	it's also the label output image. 
//	Input: img: is a binary image, getting border is based on this one
//			cut_bd: this value is the number of border pxl that wanna abandon
//  Output: img: this value is the binary input, it also contains the label of
//			output
    Notice: Check again the result of algorithm, it exists some hidden
    error
//=========================================================================%
%}

function [IMG_label,nb_obj_now] = CC_label(img,cut_bd)

BLACK       = 0;
[row,col]   = size(img);
IMG_label   = zeros(row,col);
nei         = zeros(1,4);
ON          = 1;
OFF         = 0;
nb_obj_now      = 0;

st1_labelnow = 0;
equi        = zeros(255,255);        %contain similar label
equi_tem    = zeros(1,255);
equi_final  = zeros(1,255);

%=========================================================================STEP 1

for i=cut_bd+1:(row - cut_bd)
    for j=cut_bd+1:(col - cut_bd)
        if (img(i,j) ~= BLACK)
            lb_min=255;
            %------------------------------------
            % Get neibor of the considered pixel
            %------------------------------------
            nei(1,1) = IMG_label(i,j-1);   %West
            nei(1,2) = IMG_label(i-1,j-1); %North-West
            nei(1,3) = IMG_label(i-1,j);   %North
            nei(1,4) = IMG_label(i-1,j+1); %North-East
        
            %------------------------------------
            % Get new label or assign min label for current pixel 
            %------------------------------------
            if sum(nei) == 0
                st1_labelnow     = st1_labelnow + 1;
                IMG_label(i,j)   = st1_labelnow;
            else
                %-------------------
                % get min label from neighbor
                %-------------------
                for ii=1:4
                    if (nei(1,ii) ~= 0)&&(nei(1,ii) < lb_min)
                        lb_min = nei(1,ii);
                    end
                end
                %-------------------
                % assign to min label and store equivalent
                %-------------------
                IMG_label(i,j)    = lb_min;  
                for ii= 1:4
                    if nei(1,ii)~=0
                        equi(nei(1,ii),lb_min) = 1;
                    end
                end
                %-------------------
            end
            %------------------------------------
        end
    end
end

%------------------------------------
% Arrange the equivalent table
%------------------------------------
            
for value_cur=1:255
    for value_min=1:255
        if (equi(value_cur,value_min) == 1)
           equi_tem(1,value_cur) =  value_min;
           break;
        end
    end
end

for value=1:st1_labelnow
    tem = value;
    if (equi_tem(1,value) == value)
        nb_obj_now = nb_obj_now + 1;
        equi_final(1,value) = nb_obj_now;
    else
        while (equi_tem(1,tem) ~= tem)
            tem = equi_tem(1,tem);
            equi_tem(1,value) = tem;
        end
    end
end
%========================================================================= STEP 2            
for i= cut_bd+1:(row - cut_bd)
        for j = cut_bd+1:(col- cut_bd)
            if IMG_label(i, j) ~= BLACK
                IMG_label(i, j) = equi_final(1,equi_tem(IMG_label(i,j)));
            end
        end	
end
end




