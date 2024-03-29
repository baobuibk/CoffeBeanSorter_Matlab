function varargout = Coffee_bean(varargin)
% COFFEE_BEAN MATLAB code for Coffee_bean.fig
%      COFFEE_BEAN, by itself, creates a new COFFEE_BEAN or raises the existing
%      singleton*.
%
%      H = COFFEE_BEAN returns the handle to a new COFFEE_BEAN or the handle to
%      the existing singleton*.
%
%      COFFEE_BEAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COFFEE_BEAN.M with the given input arguments.
%
%      COFFEE_BEAN('Property','Value',...) creates a new COFFEE_BEAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Coffee_bean_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Coffee_bean_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Coffee_bean

% Last Modified by GUIDE v2.5 22-Aug-2021 00:33:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Coffee_bean_OpeningFcn, ...
                   'gui_OutputFcn',  @Coffee_bean_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Coffee_bean is made visible.
function Coffee_bean_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Coffee_bean (see VARARGIN)

% Choose default command line output for Coffee_bean
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Coffee_bean wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Coffee_bean_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
%==========================================================================%OPEN IMAGE
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

global SAME_POS_MT; 
SAME_POS_MT = zeros(20,3);


function OPEN_IMAGE_button_Callback(hObject, eventdata, handles)
global IMG;


     [IMG,row,col,dir3,name_img] = Load_img();
%     IMG = imresize(IMG,[240 320]);
%     Red = IMG(:,:,1);
%     Green = IMG(:,:,2);
%     Blue = IMG(:,:,3);
     set(handles.name_img,'String',name_img);                              %hien thi ten anh
     row  = num2str(row);  
     col   = num2str(col);  
     dir3   = num2str(dir3);
     set(handles.row,'string',row);                                        %hien thi kich thuoc anh
     set(handles.col,'string',col);    
     set(handles.dir3,'string',dir3); 
     axes(handles.img);   
     imagesc(IMG);
     colormap(gray);  


%{
    ROW = 240;
    COL = 320;
    A1 = zeros(ROW,COL);
    B1 = zeros(ROW,COL);
    C1 = zeros(ROW,COL);
    
    fileA = fopen('D:\B. WORK\1. CODE_PROJECT\MATLAB\matlab_coffee_bean\Text_value\path_bgr1_240.txt','r');
    fileB = fopen('D:\B. WORK\1. CODE_PROJECT\MATLAB\matlab_coffee_bean\Text_value\path_bgr2_240.txt','r');
    fileC = fopen('D:\B. WORK\1. CODE_PROJECT\MATLAB\matlab_coffee_bean\Text_value\path_bgr3_240.txt','r');
    formatSpec = '%d';
    A = fscanf(fileA,formatSpec);
    B = fscanf(fileB,formatSpec);
    C = fscanf(fileC,formatSpec);
    
    
    for r=1:ROW
        for c=1:COL
            A1(r,c) = A((r-1)*COL + c,1);
            B1(r,c) = B((r-1)*COL + c,1);
            C1(r,c) = C((r-1)*COL + c,1);
        end
    end
    
    
    fclose('all');
    
    IMG = zeros(ROW,COL,3);
    
    IMG(:,:,1) = A1;
    IMG(:,:,2) = B1;
    IMG(:,:,3) = C1;
    axes(handles.img1);
    imagesc(uint8(IMG));
   
%}
%==========================================================================PROCESSING OFLINE SINGLE
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
function Processing_offline_Callback(hObject, eventdata, handles)
    BAD = 0;
    GOOD = 1;
    
    background    = imread("D:\B. WORK\1. CODE_PROJECT\MATLAB\matlab_coffee_bean\sample\background.jpg");
    type = GOOD;
    
    addpath('C:\Users\ducan\OneDrive\Desktop\sample\shape');
    listTemplate   = dir('C:\Users\ducan\OneDrive\Desktop\sample\shape');
    [length,~]     = size(listTemplate);
    
    for ADD_BINARY_THR = -17:-11
        nb_eachfor = 0;
        for i=3:length
            IMG = imread(listTemplate(i).name); 
            [IMGBi,~,IMG_sub] = segmentation_RGB(   IMG,...
                                                    background,...
                                                    ADD_BINARY_THR); %Use RGB %-25
    
            [center,~,out_pst_pxl,nb_obj_real,order_lb,img_label] = pre_evaluation(IMGBi);
            if (nb_obj_real ~= 0)
                result = features_evaluation(IMG_sub,...                         %remember to add some broken line into result 
                                            out_pst_pxl,...
                                            order_lb,...,
                                            center,...
                                            img_label,...
                                            nb_obj_real);                      
            end
            resultsum = result(:,3) &result(:,4)& result(:,5)& result(:,6);
            if type == BAD
                nb_eachfor = nb_eachfor + sum(1-resultsum);
            else
                nb_eachfor = nb_eachfor + sum(resultsum);
            end
            fprintf('count: %d\n',i);
        end
        fprintf('THR: %d  nb_ob= %d\n',ADD_BINARY_THR,nb_eachfor);
    end
    
   
%==========================================================================%PROCESSING OFLINE MULTI
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
function Multi_Callback(hObject, eventdata, handles)
global IMG;
global SAME_POS_MT;
   
    GOOD = 1;
    ADD_BINARY_THR = get(handles.Add_binary_THR,'string');
    ADD_BINARY_THR = str2double(ADD_BINARY_THR);
    
    BAD  = 0;
    NUM_PART       = get(handles.number_part,'string');
    THR_convex     = get(handles.THR_convex,'string');
    THR_block      = get(handles.THR_block,'string');
    NUM_PART       = str2double(NUM_PART);
    THR_convex     = str2double(THR_convex);
    THR_block      = str2double(THR_block);
    
    
    THR_Roundness = get(handles.roundness,'string');
    THR_Roundness = str2double(THR_Roundness);
    
    THR_PXL_color = get(handles.Threshold_pxl,'string');
    THR_PXL_color = str2double(THR_PXL_color);
    
    THR_PERCENT_Color = get(handles.percent_color,'string');
    THR_PERCENT_Color = str2double(THR_PERCENT_Color);
   
%    colormap('gray');

   

    background     = imread("D:\HCMUT\14. LUAN VAN THAC SI\MASTER THESIS\MATLAB\matlab_coffee_bean\sample\background.jpg");
%    background     = imresize(background,0.5);
    R = IMG(:,:,1);
    G = IMG(:,:,2);
    B = IMG(:,:,3);

    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-% SEGMENTATION
%    imwrite(IMG, 'D:\IMG.jpg');
    
    [IMGBi,IMG_Seg,IMG_sub] = segmentation_RGB( IMG,...
                                                background,...
                                                ADD_BINARY_THR); %Use RGB %-25
    
 
    [center,out_border_img,out_pst_pxl,nb_obj_real,order_lb,img_label] = pre_evaluation(IMGBi);
    hold on;
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-% find border and calculate result
%    [out_border,pos_pixel,num_object] = find_border(IMGBi); 
    red = IMG_sub(:,:,1);
    blue =IMG_sub(:,:,3);
    axes(handles.img1);
    imagesc(red);
    axes(handles.img2);
    imagesc(blue);
    axes(handles.img3);
    imagesc(IMGBi);
    axes(handles.img4);
    imagesc(out_border_img);
    
    if (nb_obj_real ~= 0)
        result = features_evaluation(   IMG_sub,...                         %remember to add some broken line into result 
                                        out_pst_pxl,...
                                        order_lb,...,
                                        center,...
                                        img_label,...
                                        nb_obj_real,...
                                        NUM_PART,...
                                        THR_convex,...
                                        THR_block,...
                                        THR_Roundness,...
                                        THR_PXL_color,...
                                        THR_PERCENT_Color);
                                      
    end

    
    
    %==================================================END TEST
    axes(handles.img);
    if (nb_obj_real ~= 0)
        for ii=1:nb_obj_real
            roundness   = result(ii,3);
            shape_line  = result(ii,4);
            rs_GLCM     = result(ii,5);
            color       = result(ii,6);
            check =shape_line&roundness&rs_GLCM&color;
            hold on;
            if ( check== BAD) 
                plot(result(ii,2),result(ii,1),'*r');
            end
        end
    end
    %{
    axes(handles.img2);
    if (nb_obj ~= 0)
        for ii=1:nb_obj
            hold on;
            if (result(ii,7) == BAD) 
                plot(result(ii,3),result(ii,2),'*r');
            end
        end
    end
    
    axes(handles.img3);
    if (nb_obj ~= 0)
        for ii=1:nb_obj
            hold on;
            if (result(ii,9) == BAD) 
                plot(result(ii,3),result(ii,2),'*r');
            end
        end
    end

    
    axes(handles.img4);
    if (nb_obj ~= 0)
        for ii=1:nb_obj
            hold on;
            if ((result(ii,5) & result(ii,7) & result(ii,9)) == BAD) 
                plot(result(ii,3),result(ii,2),'*r');
            end
        end
    end
%    SAME_POS_MT = zeros(20,3);
    %}
    %======================================================

%==========================================================================%GET THR
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
function GET_THR_Callback(hObject, eventdata, handles)
        
    BAD     = 0;
    GOOD    = 1;
    
    text_F1_score  = fopen('C:\Users\ducan\OneDrive\Desktop\MASTER THESIS\MATLAB\matlab_coffee_bean\sample\F1_score.txt','w');
    
    %---------------------------------Shape line 
    text_shapeline = fopen('C:\Users\ducan\OneDrive\Desktop\MASTER THESIS\MATLAB\matlab_coffee_bean\sample\get_THRshapeline.txt','w');
    addpath('C:\Users\ducan\OneDrive\Desktop\sample\shape');
    listTemplate   = dir('C:\Users\ducan\OneDrive\Desktop\sample\shape');
    [length,~]     = size(listTemplate);
    
    [TP,FN]        = get_THR_shape(text_shapeline,length,listTemplate,BAD);
   
    
    %--------------------------------- Normal
    text_normal     = fopen('C:\Users\ducan\OneDrive\Desktop\MASTER THESIS\MATLAB\matlab_coffee_bean\sample\get_THRnormal.txt','w');
    addpath('C:\Users\ducan\OneDrive\Desktop\MASTER THESIS\MATLAB\matlab_coffee_bean\sample\good');
    listTemplate   = dir('C:\Users\ducan\OneDrive\Desktop\MASTER THESIS\MATLAB\matlab_coffee_bean\sample\good');
    [length,~]     = size(listTemplate);
    [TN,FP]        = get_THR_shape(text_normal,length,listTemplate,GOOD);
    
    Precision = TP(:,5) ./(TP(:,5) + FN(:,5));
    Recall    = TP(:,5) ./(TP(:,5) + FP(:,5));
    
    F1_score  = 2* (Precision.*Recall)./ (Precision + Recall);
    lenobj  = size(F1_score,1);
    
    max_value = 0;
    for len=1:lenobj
        if (F1_score(len) > max_value)
            max_value = F1_score(len);
            fprintf(text_F1_score,'==================== MAX HERE \n');
        end
        fprintf(text_F1_score,'add_thres_otsu: %d    num_part: %d  THR_convex = %d THR_block = %d  Precision = %d Recall = %d F1_score = %.2f\n',...
                TN(len,1),TN(len,2),TN(len,3),TN(len,4),Precision(len),Recall(len),F1_score(len));
    end
    fclose('all');
        
%write_img2text();
%==========================================================================%OPEN CAMERA
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
function Open_Camera_Callback(hObject, eventdata, handles)
global cam;
global i;
i=44;
axes (handles.img);
cam = webcam(1);
hImage = image(handles.img, zeros(480,640,3)); %384  512 %480,640
preview (cam, hImage);
%pause;

%==========================================================================% CAPTURE IMAGE
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
function capture_Callback(hObject, eventdata, handles)
global cam;
global i;
global IMG;
axes(handles.img1);
IMGcam = snapshot(cam);
IMG = IMGcam;
imagesc(IMGcam);
i=i+1;

%outputFileName = fullfile(strcat('D:\B. WORK\LAB\REPORT + PAPER\Coffee_shap_color\Data\shape\',num2str(i),'shape.jpg'));
outputFileName = fullfile(strcat('D:\',num2str(i),'shape.jpg'));
imwrite(IMGcam, outputFileName);



%==========================================================================% PROCESSING ONLINE
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
function Processing_Callback(hObject, eventdata, handles)
global cam;
global SAME_POS_MT;
    GOOD = 1;
    BAD  = 0;
    
    
    ADD_BINARY_THR = get(handles.Add_binary_THR,'string');
    ADD_BINARY_THR = str2double(ADD_BINARY_THR);
    
    number_part    = get(handles.number_part,'string');
    THR_convex     = get(handles.THR_convex,'string');
    THR_block      = get(handles.THR_block,'string');
    num_part       = str2double(number_part);
    THR_convex     = str2double(THR_convex);
    THR_block      = str2double(THR_block);
    
    
    L_THR          = get(handles.L,'string');
    L_THR          = str2double(L_THR);
    b_THR          = get(handles.b,'string');
    b_THR          = str2double(b_THR);
    Chroma_THR     = get(handles.Chroma,'string');
    Chroma_THR     = str2double(Chroma_THR);
%    Mask            = ones(240,640);
    IMGcam  = snapshot(cam);
    axes(handles.img1);
    a = IMGcam(:,:,1);
    RGB     = imresize(IMGcam,[240 320]);
    
%    RGB     = RGB(61:180,:,:);
    imagesc(RGB);

    [IMGBi,IMGSeg_CIE,~] = segmentation_RGB(RGB,ADD_BINARY_THR);
    
    axes(handles.img2);
    imagesc(IMGBi);
    axes(handles.img3);
    imagesc(IMGSeg_CIE);
 
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-% find border and calculate result
     [img_border,pos_pixel,num_object] = find_border(IMGBi); 
     axes(handles.img4);
     imagesc(img_border);
     if (num_object ~= 0)
        [out_result] = check_shape_color(IMGSeg_CIE,pos_pixel,num_object,num_part,THR_convex,THR_block,L_THR,b_THR,Chroma_THR);
     else
         out_result = 0;
     end
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-% display
    axes(handles.img3);
    if (size(out_result,2) ~= 1)
        for ii=1:num_object
            hold on;
            if out_result(ii,3) == BAD 
                plot(out_result(ii,2),out_result(ii,1),'*r');
            end
        end
    end

 
    
 %==========================================================================% 
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
function name_img_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function name_img_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function THR_convex_Callback(hObject, eventdata, handles)
% hObject    handle to THR_convex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of THR_convex as text
%        str2double(get(hObject,'String')) returns contents of THR_convex as a double


% --- Executes during object creation, after setting all properties.
function THR_convex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to THR_convex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function THR_block_Callback(hObject, eventdata, handles)
% hObject    handle to THR_block (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of THR_block as text
%        str2double(get(hObject,'String')) returns contents of THR_block as a double


% --- Executes during object creation, after setting all properties.
function THR_block_CreateFcn(hObject, eventdata, handles)
% hObject    handle to THR_block (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function number_part_Callback(hObject, eventdata, handles)
% hObject    handle to number_part (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of number_part as text
%        str2double(get(hObject,'String')) returns contents of number_part as a double


% --- Executes during object creation, after setting all properties.
function number_part_CreateFcn(hObject, eventdata, handles)
% hObject    handle to number_part (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
clear all;
close all;


% --- Executes on button press in capture.



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Multi.



function L_Callback(hObject, eventdata, handles)
% hObject    handle to L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L as text
%        str2double(get(hObject,'String')) returns contents of L as a double


% --- Executes during object creation, after setting all properties.
function L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_Callback(hObject, eventdata, handles)
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b as text
%        str2double(get(hObject,'String')) returns contents of b as a double


% --- Executes during object creation, after setting all properties.
function b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Chroma_Callback(hObject, eventdata, handles)
% hObject    handle to Chroma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Chroma as text
%        str2double(get(hObject,'String')) returns contents of Chroma as a double


% --- Executes during object creation, after setting all properties.
function Chroma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Chroma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Add_binary_THR_Callback(hObject, eventdata, handles)
% hObject    handle to Add_binary_THR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Add_binary_THR as text
%        str2double(get(hObject,'String')) returns contents of Add_binary_THR as a double


% --- Executes during object creation, after setting all properties.
function Add_binary_THR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Add_binary_THR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function roundness_Callback(hObject, eventdata, handles)
% hObject    handle to roundness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roundness as text
%        str2double(get(hObject,'String')) returns contents of roundness as a double


% --- Executes during object creation, after setting all properties.
function roundness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roundness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Threshold_pxl_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold_pxl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Threshold_pxl as text
%        str2double(get(hObject,'String')) returns contents of Threshold_pxl as a double


% --- Executes during object creation, after setting all properties.
function Threshold_pxl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Threshold_pxl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function percent_color_Callback(hObject, eventdata, handles)
% hObject    handle to percent_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of percent_color as text
%        str2double(get(hObject,'String')) returns contents of percent_color as a double


% --- Executes during object creation, after setting all properties.
function percent_color_CreateFcn(hObject, eventdata, handles)
% hObject    handle to percent_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
