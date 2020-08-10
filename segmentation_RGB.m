function [IMGBi,IMGSeg_CIE,IMGSeg_RGB,Canny] = segmentation_RGB(RGB,ADD_BINARY_THR)

%=========================================================================%
% This funtion segmentates image and reture two value:
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
    IMGBlue         = (RGB(:,:,3));
    
    [row,col]       = size(IMGRed);
%    IMGBi           = zeros(row,col);
 
    IMGSeg_RGB      = [];
    IMGSeg_CIE      = [];
    IMGRedSeg       = zeros(row,col);
    IMGGreenSeg     = zeros(row,col);
    IMGBlueSeg      = zeros(row,col);
%    gray1            = zeros(row,col);
   
    BLK             = 64;
    BLOCK_ROW       = floor(row/BLK);
    BLOCK_COL       = floor(col/BLK);
%    IMGBlue_his     = zeros(row,col);

%{
    gray        =   double(rgb2gray(RGB));
    THRgray     =   np_otsus_process(gray);
    gray(:,:)   =  (gray(:,:)>= (THRgray-20));   
%}    
    
  %{  
   for r = 0:BLOCK_ROW-1
       for c = 0:BLOCK_COL-1
        block       = gray(r*BLK+1:r*BLK+BLK,c*BLK+1:c*BLK+BLK);
        his_block   = histeq(uint8(block));
        IMGBlue_his(r*BLK+1:r*BLK+BLK,c*BLK+1:c*BLK+BLK) = his_block;
       end
   end
  %}  
    
%    imagesc(IMGBlue_his);

%{
    RPart1    = floor(row/3);
    RPart2    = floor(2*row/3);
    RPart3    = row; 
    CPart1    = floor(col/3);
    CPart2    = floor(2*col/3);  
    CPart3    = col;
    THRBlue1         = np_otsus_process(IMGBlue(1:RPart1,1:CPart1));
    THRBlue2         = np_otsus_process(IMGBlue(1:RPart1,CPart1+1:CPart2));
    THRBlue3         = np_otsus_process(IMGBlue(1:RPart1,CPart2+1:CPart3));
    
    THRBlue4         = np_otsus_process(IMGBlue(RPart1+1:RPart2,1:CPart1));
    THRBlue5         = np_otsus_process(IMGBlue(RPart1+1:RPart2,CPart1+1:CPart2));
    THRBlue6         = np_otsus_process(IMGBlue(RPart1+1:RPart2,CPart2+1:CPart3));
    
    THRBlue7         = np_otsus_process(IMGBlue(RPart2+1:RPart3,1:CPart1));
    THRBlue8         = np_otsus_process(IMGBlue(RPart2+1:RPart3,CPart1+1:CPart2));
    THRBlue9         = np_otsus_process(IMGBlue(RPart2+1:RPart3,CPart2+1:CPart3));
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= binary image
%    IMGBi(:,:)   = (IMGRed(:,:)>= (THRRed+ADD_BINARY_THR));
%    IMGBi(:,:)   =  (IMGGreen(:,:)>= (THRGreen+ADD_BINARY_THR));
    THR1 = -20;
    THR2 = -30;
    THR3 = -35;
    THR4 = -20;
    THR5 = 0;
    THR6 = 0;
    THR7 = -30;
    THR8 = 0;
    THR9 = 0;
    
    IMGBi(1:RPart1,1:CPart1)            =  (IMGBlue(1:RPart1,1:CPart1)>= THRBlue1+THR1); 
    IMGBi(1:RPart1,CPart1+1:CPart2)     =  (IMGBlue(1:RPart1,CPart1+1:CPart2)>= THRBlue2+THR2);
    IMGBi(1:RPart1,CPart2+1:CPart3)     =  (IMGBlue(1:RPart1,CPart2+1:CPart3)>= THRBlue3+THR3);
    
    IMGBi(RPart1+1:RPart2,1:CPart1)             =  (IMGBlue(RPart1+1:RPart2,1:CPart1)>= THRBlue4+THR4);
    IMGBi(RPart1+1:RPart2,CPart1+1:CPart2)      =  (IMGBlue(RPart1+1:RPart2,CPart1+1:CPart2)>= THRBlue5+THR5);
    IMGBi(RPart1+1:RPart2,CPart2+1:CPart3)      =  (IMGBlue(RPart1+1:RPart2,CPart2+1:CPart3)>= THRBlue6+THR6);
    
    IMGBi(RPart2+1:RPart3,1:CPart1)             =  (IMGBlue(RPart2+1:RPart3,1:CPart1)>= THRBlue7+THR7);
    IMGBi(RPart2+1:RPart3,CPart1+1:CPart2)      =  (IMGBlue(RPart2+1:RPart3,CPart1+1:CPart2)>= THRBlue8+THR8);
    IMGBi(RPart2+1:RPart3,CPart2+1:CPart3)      =  (IMGBlue(RPart2+1:RPart3,CPart2+1:CPart3)>= THRBlue9+THR9);
    
    %}
     
%    write_img2text(IMGBi,2);
%    IMGBi(:,:) = (IMGRed(:,:)>= THR) | (IMGGreen(:,:)>= THR) | (IMGBlue(:,:)>= THR);
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
%    msk     = fspecial('gaussian',7,2);  
%    IMGBlue = imfilter(IMGBlue,msk);
%    IMGBlue = imfilter(IMGBlue,msk);
%    IMGBlue         =   histeq(IMGBlue);
    IMGBlue         =   medfilt2(IMGBlue,[7 7]);
    IMGBlue         =   medfilt2(IMGBlue,[7 7]);
    IMGBlue         =   medfilt2(IMGBlue,[7 7]);
%    IMGBlue = imfilter(IMGBlue,msk);
%    IMGBlue        = 
    imagesc(IMGBlue);

    THRBlue         =   graythresh(IMGBlue)*255;
    
%    THRBlue         =   np_otsus_process(IMGBlue);
    Canny           =   edge(IMGBlue,'Canny',[0.35*THRBlue/255 (THRBlue/255-0.12)]);

    
    
    
%    THRRed          =   np_otsus_process(IMGRed);
%    THRGreen        =   np_otsus_process(IMGGreen);
    
    IMGBi(:,:)      =  (IMGBlue(:,:)>= THRBlue + ADD_BINARY_THR);
%    IMGBlue         =  IMGBi;
%    IMGRed(:,:)     =  (IMGRed(:,:)>= THRRed-20);
%    IMGGreen(:,:)   =  (IMGGreen(:,:)>= THRGreen-20);
    
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
%    imagesc(IMGBi);
%    msk     = fspecial('gaussian',5,3);
%    IMGBi   = Gaussian_new(msk, IMGBi); 
    

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
    IMGBlueSeg              = double(IMGBlue)  .*IMGBi;
    
    IMGSeg_CIE(:,:,1)    = IMGRedSeg;
    IMGSeg_CIE(:,:,2)    = IMGGreenSeg;
    IMGSeg_CIE(:,:,3)    = IMGBlueSeg;
    
    IMGSeg_CIE           = uint8(IMGSeg_CIE);
    IMGBi                = uint8(IMGBi);
   
%    write_img2text(IMGBlueSeg,2);
end

