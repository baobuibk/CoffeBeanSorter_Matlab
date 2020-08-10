function lab = rgb2labnew(RED,GREEN,BLUE)

%===============================================
% This funtion is following this page:
%http://www.brucelindbloom.com/index.html?Eqn_RGB_to_XYZ.html
%https://www.mathworks.com/help/vision/ref/colorspaceconversion.html
% The aim convert RGB to CIELab with two main steps:
% The first: Inverse Companding and linear RGB to XYZ
% The second: Convert XYZ to Lab
%===============================================

%lab1 = rgb2xyz(RED);
%a = lab1(:,:,1);

if nargin == 1
  BLUE  = double(RED(:,:,3));         
  GREEN = double(RED(:,:,2));             
  RED   = double(RED(:,:,1));
    
end

%gama = 2.2;
%=================================================== Normalize data and Inverse Gamma Companding
RED     = double(RED/255);
GREEN   = double(GREEN/255);
BLUE    = double(BLUE/255);

THR_ISC    = 0.03928;   %0.04045
%=================================================== Inverse sRGB Companding
redTHR     = (RED     > THR_ISC);
greenTHR   = (GREEN   > THR_ISC);
blueTHR    = (BLUE    > THR_ISC);

red     = redTHR  .*(((RED   + 0.055)/1.055).^(2.4))  +  ((~redTHR)  .*(RED  /12.92));
green   = greenTHR.*(((GREEN + 0.055)/1.055).^(2.4))  +  ((~greenTHR).*(GREEN/12.92));
blue    = blueTHR .*(((BLUE  + 0.055)/1.055).^(2.4))  +  ((~blueTHR) .*(BLUE /12.92));

%=================================================== Inverse L* Companding
%write_img2text(blue,2);
%{
redTHR     = (RED     > 0.08);
greenTHR   = (GREEN   > 0.08);
blueTHR    = (BLUE    > 0.08);

red      = redTHR   .*(((RED   +0.16)/1.16).^3) + (~redTHR)  .*(100*red  /903.3);
green    = greenTHR .*(((GREEN +0.16)/1.16).^3) + (~greenTHR).*(100*green/903.3);
blue     = blueTHR  .*(((BLUE  +0.16)/1.16).^3) + (~redTHR)  .*(100*blue /903.3);
%}
%=================================================== Linear RGB to XYZ

XXn = 0.41239079926596*red + 0.35758433938388*green + 0.18048078840183*blue;
YYn = 0.21263900587151*red + 0.71516867876776*green + 0.07219231536073*blue;  
ZZn = 0.01933081871559*red + 0.11919477979463*green + 0.95053215224966*blue;  



%write_img2text(ZZn,2);
% Set a threshold
T = 0.008856;
%---------------------------
% Normalize for D65 white point
XXn = XXn ./ 0.950456;
YYn = YYn ./ 1;
ZZn = ZZn ./ 1.088754;



%===========================================================
XT = XXn > T;
YT = YYn > T;
ZT = ZZn > T;
Y3 = YYn.^(1/3); 

fX = XT .* XXn.^(1/3) + (~XT) .* (7.787 .* XXn + 16/116);
fY = YT .* Y3         + (~YT) .* (7.787 .* YYn + 16/116);
fZ = ZT .* ZZn.^(1/3) + (~ZT) .* (7.787 .* ZZn + 16/116);


%check = fX - fZ;

L = YT .* (116 * Y3 - 16.0) + (~YT) .* (903.3 .* YYn);
a = 500 * (fX - fY);
b = 200 * (fY - fZ);

%write_img2text(L,2);
if nargout < 2
 lab = cat(3,L,a,b);
end


end