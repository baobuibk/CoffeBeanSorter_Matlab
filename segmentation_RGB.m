function [IMGBi,IMG_Seg,IMG] = segmentation_RGB(RGB,background,ADD_BINARY_THR)


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
    IMG                 = double((double(RGB)+40) - double(background));   %+40
    IMG(IMG(:,:,:)>255) = 255;
    IMG(IMG(:,:,:)<0)   = 0;
    IMG                 = uint8(IMG);
    IMGBlue             = double(IMG(:,:,3));
    [row,col]           = size(IMGBlue);
%    IMGBi           = zeros(row,col);   
%    IMG_Gray        = rgb2gray(RGB);

%===================================== Using later, now convert first***


    msk      = fspecial('gaussian',5,1.2);  %7,1.5
    IMG_Gray = imfilter(IMGBlue,msk,'symmetric','same');         %using Blue channel for gray image   
%    IMG_Gray = imfilter(IMG_Gray,msk,'symmetric','same');
%    IMG_Gray = imfilter(IMG_Gray,msk,'symmetric','same');

    
%    IMG_Gray  = IMGBlue;
    THR_Gray  = np_otsus_process(IMG_Gray);
    
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= binary image
    IMGBi(:,:)      =  (IMG_Gray(:,:) < (THR_Gray + ADD_BINARY_THR));      
%    IMGBi           = 1-IMGBi;
    %=====================================

    %{
    se              = strel('square',2);
    IMGBi1           = imerode(IMGBi,se);
    IMGBi1           = imerode(IMGBi1,se);
    IMGBi1           = imerode(IMGBi1,se); 
    %}
    IMGBi(1:5,:) = 0;                                    
    IMGBi(:,1:5) = 0;
    IMGBi(row -4:row,:) = 0;
    IMGBi(:,col -4:col) = 0;
    
    
    IMGBi          = rm_border_obj(IMGBi);
    
    IMGBi          = erosion_square2x2(IMGBi);
    IMGBi          = erosion_square2x2(IMGBi);
    IMGBi          = erosion_square2x2(IMGBi);
    
%    a = sum(sum(abs(IMGBi1-IMGBi)));

    
    
    %Should use Cclabel together
    IMGBi          = remove_sm_obj(~IMGBi,570,5);  %remove hole in each bean
    IMGBi          = remove_sm_obj(~IMGBi,30,5);   %remove small bean
  
   
    RGB     = uint8(RGB);
    
    
    
    %{
    [img_lb,~] =  CC_label(img,5);
    %==================================== Remove objects that lie on border
    for i=6:row-5
        if (img_lb(r,6)~= 0) && img_lb(r,6)~= img_lb(r-1,6)
            rm_label = [rm_label;img_lb(r,6)];
        end
        
        if (img_lb(r,col-5)~= 0) && img_lb(r,col-5)~= img_lb(r-1,col-5)
            rm_label = [rm_label;img_lb(r,6)];
        end
    end
    %}
    
    

%    IMG1            = IMGBi;

   %{  
    se              = strel('square',2);
    IMGBi           = imerode(IMGBi,se);
    
    
    IMGBi           = imerode(IMGBi,se);
    IMGBi           = imerode(IMGBi,se); 
    


    
    IMGBi           = ~bwareaopen(~IMGBi, 570);
    IMGBi           = bwareaopen(IMGBi, 30);
   %}
    
%    msk     = fspecial('gaussian',5,3);
%    IMGBi   = Gaussian_new(msk, IMGBi); 

%    [IMGBi_label]   = bwlabel(IMGBi,8);
%    IMGBi           = (IMGBi_label(:,:)==1);
    IMG_Seg = RGB(:,:,:).*(uint8(IMGBi));         %Be used for imshow, don't implement
end

