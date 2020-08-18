function [IMGBi,label,num_obj] = segmentation_RGB(RGB)

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
    IMGGreen        = (RGB(:,:,2));
    IMGBlue         = (RGB(:,:,3));
    
    [row,col]       = size(IMGRed);
%    IMGBi           = zeros(row,col);
 
    IMGSeg_RGB      = [];
    IMGSeg_CIE      = [];
    IMGRedSeg       = zeros(row,col);
    IMGGreenSeg     = zeros(row,col);
    IMGBlueSeg      = zeros(row,col);

    msk             =   fspecial('gaussian',3,2.5);
    for i=1:3
        IMGBlue     =   imfilter(IMGBlue,msk);
    end

    IMGBi           =   imextendedmin(IMGBlue,40);       %40
    
    
    
    %{
    IMGBi_min       =   imimposemin(IMGBlue,IMGBi_min);
    
    THRBlue         =   graythresh(IMGBlue1)*255;
    Canny           =   edge(IMGBlue1,'Canny',[0.35*THRBlue/255 (0.8*(THRBlue/255))]);
    
    IMGBi(:,:)      =  (IMGBlue1(:,:)>= THRBlue + ADD_BINARY_THR);
    
    IMGBi_min       = IMGBi_min|(Canny);
    
    IMGBi_min       = bwareaopen(IMGBi_min, 500);
   IMGBi_min       = ~bwareaopen(~IMGBi_min, 500);
    
    %}
    
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
%    imagesc(IMGBi);
%    msk     = fspecial('gaussian',5,3);
%    IMGBi   = Gaussian_new(msk, IMGBi); 
    

    IMGBi(1:5,:)        = 1;                                    
    IMGBi(:,1:5)        = 1;
    IMGBi(row -4:row,:) = 1;
    IMGBi(:,col -4:col) = 1;
    label               =   bwlabel(IMGBi);
    label(label==1)     =   0;
    IMGBi               =  (label ~= 0);
    IMGBi               =   bwareaopen(IMGBi, 200);
    IMGBi               =   ~bwareaopen(~IMGBi, 200);
    [label,num_obj]     =   bwlabel(IMGBi);

    %{
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
    IMGRedSeg            = IMGRed   .*IMGBi;
    IMGGreenSeg          = double(IMGGreen) .*IMGBi;
    IMGBlueSeg           = double(IMGBlue)  .*IMGBi;
    
    IMGSeg_CIE(:,:,1)    = IMGRedSeg;
    IMGSeg_CIE(:,:,2)    = IMGGreenSeg;
    IMGSeg_CIE(:,:,3)    = IMGBlueSeg;
    
    IMGSeg_CIE           = uint8(IMGSeg_CIE);
    IMGBi                = uint8(IMGBi);
   %}
%    write_img2text(IMGBlueSeg,2);
end

