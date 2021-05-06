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

function [IMG_label,nb_obj,error] = CC_label(img,cut_bd)

BLACK       = 0;
[row,col]   = size(img);
same_lbst1  = zeros(1,500); 
same_lbst2  = zeros(1,500);
IMG_label   = zeros(row,col);
nei         = zeros(1,4);
ON          = 1;
OFF         = 0;
label_new   = 0;
label_real  = 0;
OV_LB      = 501;
flag_overflow = OFF;
error       = OFF;
%=========================================================================STEP 1

for i=cut_bd+1:(row - cut_bd)
    for j=cut_bd+1:(col - cut_bd)
        if (img(i,j) ~= BLACK)
		%--------------------------------------------
			lb_min = OV_LB;
			nei(1,1) = IMG_label(i      ,j - 1);    %West
			nei(1,2) = IMG_label(i - 1  ,j - 1);    %North West
			nei(1,3) = IMG_label(i - 1  ,j    );    %North
			nei(1,4) = IMG_label(i - 1  ,j + 1);    %North East
		%-------------------------------------------- calculate min label
            for ii=1:4
                if (nei(1,ii) ~= 0)&&(nei(1,ii) < lb_min)	 
                    lb_min = nei(1,ii);                             %if don't have any satisfying label: lb_min =500
                end
            end
            
				%-------------------------------------------- save same values and attach label for IMG
            if (lb_min ~= OV_LB)    
				IMG_label(i,j) = lb_min;
                for ii = 1:4 
                    if (nei(1,ii) ~= 0) 
                    	same_lbst1(1,nei(1,ii)) = lb_min;               %label have not been written-> write new for all 4 elements
                    end
                end
            else
                label_new               = label_new +1;
				IMG_label(i,j)          = label_new;
				same_lbst1(1,label_new) = label_new;			% replace
            end
				%--------------------------------------------
        end
        if (label_new >= OV_LB) 
            break;
        end
    end
    if (label_new >= OV_LB) 
        break;
    end	
end

if (label_new >= OV_LB) 
    flag_overflow = ON;
end

%========================================================================= STEP 2
if (flag_overflow == ON || label_new == 0) 
    error = ON;
else
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ARRANGING STORE
    for ii = 1:label_new
        tem = ii;
        if (same_lbst1(1,ii) == ii)
            label_real = label_real+1;
            same_lbst2(1,ii) = label_real;
        else
            while (same_lbst1(1,tem) ~= tem)
				tem = same_lbst1(1,tem);
				same_lbst1(1,ii) = tem;
            end
        end
    end
	%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    for i = cut_bd+1:(row - cut_bd)
        for j = cut_bd+1:(col- cut_bd)
            if IMG_label(i, j) ~= BLACK
                IMG_label(i, j) = same_lbst2(1,same_lbst1(IMG_label(i,j)));
            end
        end	
    end
end
nb_obj = label_real;
end




