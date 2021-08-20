function [IMGBi,IMGSeg_CIE,IMGSeg_RGB,IMG_Gray] = segmentation_RGB(RGB,ADD_BINARY_THR)


%=========================================================================%
% This funtion segmentate image and reture two value:
% The one is binarry image and another is segmentation image with black
% background
% Background: 0 (Black)
% Foreground: 1 (White)
% IMGSeg_dis use for display image in GUI, 
% IMGSeg use for continous steps (have back ground is '0', others are
% density + 1
%=========================================================================%
    
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= explore threshold
    IMGRed          = double(RGB(:,:,1));
    IMGGreen        = double(RGB(:,:,2));
    IMGBlue         = double(RGB(:,:,3));
    IMG_Gray        = IMGBlue;
    [row,col]       = size(IMGRed);
%    IMGBi           = zeros(row,col);
 
    IMGSeg_RGB      = [];
    IMGSeg_CIE      = [];
    IMGRedSeg       = zeros(row,col);
    IMGGreenSeg     = zeros(row,col);
    IMGBlueSeg      = zeros(row,col);
    %{
    for i=0:14
        for j=0:19
            img_calRED      = IMGRed(i*15+1:(i+1)*15,j*15+1:(j+1)*15);
            img_calGreen    = IMGGreen(i*15+1:(i+1)*15,j*15+1:(j+1)*15);
            img_calBlue     = IMGBlue(i*15+1:(i+1)*15,j*15+1:(j+1)*15);
            THRRed   =  np_otsus_process(img_calRED)+25;
            THRGreen =  np_otsus_process(img_calGreen)+25;
            THRBlue  =  np_otsus_process(img_calBlue)+25;
            
            IMGBi(i*15+1:(i+1)*15,j*15+1:(j+1)*15) = (img_calRED>= THRRed)| ( img_calGreen >= THRGreen) | (img_calBlue >= THRBlue);
        end
    end
    %}
 
    
%    THRRed          = np_otsus_process(IMGRed)   ;
%    THRGreen        = np_otsus_process(IMGGreen) ;
    THRBlue          = np_otsus_process(IMGBlue);
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= binary image
%    IMGBi(:,:)   = (IMGRed(:,:)>= (THRRed-50));
%    IMGBi(:,:)   = IMGBi(:,:)|(IMGGreen(:,:)>= (THRGreen-15));
    IMGBi(:,:)   =  (IMGBlue(:,:)>= (THRBlue+ADD_BINARY_THR));      
%    write_img2text(IMGBi,2);
%    IMGBi(:,:) = (IMGRed(:,:)>= THR) | (IMGGreen(:,:)>= THR) | (IMGBlue(:,:)>= THR);
 %   write_img2text(IMGRed,2);
     
    msk     = fspecial('gaussian',5,3);
    IMGBi   = Gaussian_new(msk, IMGBi); 

    IMGBi(1:5,:) = 1;                                    
    IMGBi(:,1:5) = 1;
    IMGBi(row -4:row,:) = 1;
    IMGBi(:,col -4:col) = 1;
    
%    write_img2text(IMGBi,2);  
    [IMGBi_label]   = bwlabel(IMGBi,8);
    IMGBi           = (IMGBi_label(:,:)==1);
    IMGBi           = 1-IMGBi;
    
    
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= RGB Segmentation 
    for ii=1:row
        for jj=1:col
            %----------------------------
            if IMGBi_label(ii,jj)== 1
                IMGRedSeg(ii,jj)    = 0;
                IMGGreenSeg(ii,jj)  = 0;
                IMGBlueSeg(ii,jj)   = 0;
            else
                IMGRedSeg(ii,jj)    = IMGRed(ii,jj)  + 1;       % density = density +1
                IMGGreenSeg(ii,jj)  = IMGGreen(ii,jj) + 1;      % to avoid '0' value
                IMGBlueSeg(ii,jj)   = IMGBlue(ii,jj)+ 1;        % adjust in Histogram later
            end
            %---------------------------- 
        end
    end
    IMGSeg_RGB(:,:,1)    = IMGRedSeg;
    IMGSeg_RGB(:,:,2)    = IMGGreenSeg;
    IMGSeg_RGB(:,:,3)    = IMGBlueSeg;
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= CIE Segmentation
    IMGRedSeg               = IMGRed   .*IMGBi;
    IMGGreenSeg             = IMGGreen .*IMGBi;
    IMGBlueSeg              = IMGBlue  .*IMGBi;
    
    IMGSeg_CIE(:,:,1)    = IMGRedSeg;
    IMGSeg_CIE(:,:,2)    = IMGGreenSeg;
    IMGSeg_CIE(:,:,3)    = IMGBlueSeg;
    
    IMGSeg_CIE           = uint8(IMGSeg_CIE);
    IMGBi                = uint8(IMGBi);
   
%    write_img2text(IMGBlueSeg,2);
end

