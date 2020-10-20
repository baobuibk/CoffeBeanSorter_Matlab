function [IMGBi,IMG_Seg] = segmentation_RGB(RGB,background,ADD_BINARY_THR)


%=========================================================================%
% This funtion segmentate image and return two value:
% The one is binarry image and another is segmentation image with black
% background
% Background: 0 (Black)
% Foreground: 1 (White)
% IMGSeg_dis use for display image in GUI, 
% IMGSeg use for continous steps (have back ground is '0', others are
% density + 1
%=========================================================================%
    
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= explore threshold
    
    IMG        = (RGB+40) - background;
    
    IMGBlue    = double(IMG(:,:,3));
    [row,col]  = size(IMGBlue);
%    IMGBi           = zeros(row,col);   
%    IMG_Gray        = rgb2gray(RGB);

    msk      = fspecial('gaussian',7,1.5);
    IMG_Gray = imfilter(IMGBlue,msk,'symmetric','same');         %using Blue channel for gray image   
    IMG_Gray = imfilter(IMG_Gray,msk,'symmetric','same');
    IMG_Gray = imfilter(IMG_Gray,msk,'symmetric','same');
     
    THR_Gray = np_otsus_process(IMG_Gray);
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= binary image
    
    IMGBi(:,:)   =  (IMG_Gray(:,:)>= (THR_Gray+ADD_BINARY_THR));      
%    IMGBi       = bwareaopen(IMGBi, 110);
%    IMGBi       = ~bwareaopen(~IMGBi, 30);
 
%    msk     = fspecial('gaussian',5,3);
%    IMGBi   = Gaussian_new(msk, IMGBi); 

    IMGBi(1:5,:) = 1;                                    
    IMGBi(:,1:5) = 1;
    IMGBi(row -4:row,:) = 1;
    IMGBi(:,col -4:col) = 1;
        
%    [IMGBi_label]   = bwlabel(IMGBi,8);
%    IMGBi           = (IMGBi_label(:,:)==1);
%    IMGBi           = 1-IMGBi;

    IMG_Seg = RGB(:,:,:).*(1-uint8(IMGBi));
    
    
end

