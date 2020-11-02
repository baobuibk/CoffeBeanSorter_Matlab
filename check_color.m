function [result_color] = check_color(IMGSeg,img_check)

%===================================================================%
% funtion calculate image histogram and return result of coffee qualily 
%
%
%===================================================================%CIE 


%=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=Test

lab1 = rgb2labnew(IMGSeg);

L   = lab1(:,:,1);
a   = lab1(:,:,2);
b   = lab1(:,:,3);
GOOD = 1;
BAD  = 0;
%write_img2text(L,2);

%=============================================Test
Chroma = sqrt(a.*a + b.*b);
Hue    = atan(b./(a+eps));
Sum_L = 0;
Sum_a = 0;
Sum_b = 0;
Sum_Chroma = 0;
Sum_Hue    = 0;

total_px  = 0;
[row,col] = size(L);
%=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-= Calculate sum L,a,b
%write_img2text(img_check,2);
for i=1:row
    for j=1:col
        %-----------------------------%
        if img_check(i,j) == 1
            total_px = total_px + 1;
            Sum_L = Sum_L + L(i,j);
            Sum_a = Sum_a + a(i,j);
            Sum_b = Sum_b + b(i,j);
            Sum_Chroma  = Sum_Chroma + Chroma(i,j);
            Sum_Hue     = Sum_Hue + Hue(i,j);
        end
        %-----------------------------%
    end
end

%=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=Calculate average L,a,b
Avr_L = Sum_L/total_px;
Avr_a = Sum_a/total_px;
Avr_b = Sum_b/total_px;
Avr_Chroma = Sum_Chroma/total_px;
Avr_Hue = Sum_Hue/total_px;

%fprintf(Review_good,'%.4f   %.4f    %.4f    %.4f    %.4f \n',Avr_L,Avr_a,Avr_b,Avr_Chroma,Avr_Hue);
%fprintf(Review_good_name,'L: %.4f   a: %.4f    b: %.4f    Chroma: %.4f    Hue: %.4f   %d\n',Avr_L,Avr_a,Avr_b,Avr_Chroma,Avr_Hue,num);

w0 = 257.774711141135696835;
w1 = -1.983727219269821873; 
w2 = -22.504981531149287122;
w3 = 84.292970330603694151;

result_color = sgn(Avr_L*w1 + Avr_b*w2 + Avr_Hue*w3 + w0);

function y = sgn(x)
GOOD = 1;
BAD  = 0;
if x>=0
   y =  BAD;
else
   y =  GOOD ;
end

