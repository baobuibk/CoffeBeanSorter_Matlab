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

% Last Modified by GUIDE v2.5 29-Jul-2020 20:31:59

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
     IMG = imresize(IMG,[240 320]);
     imagesc(IMG);
     colormap(gray); 
  
    


%==========================================================================PROCESSING OFLINE SINGLE
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
function Processing_offline_Callback(hObject, eventdata, handles)
global IMG;
    IMG = read_imgtxt();
    IMG = uint8(IMG);
    axes(handles.img);
    imagesc(IMG);
%    IMG = imresize(IMG,[240 320]);
    colormap(gray);
%{
    number_part    = get(handles.number_part,'string');
    THR_convex     = get(handles.THR_convex,'string');
    THR_block      = get(handles.THR_block,'string');
    num_part       = str2double(number_part);
    THR_convex     = str2double(THR_convex);
    THR_block      = str2double(THR_block);

    RGB = imresize(IMG,[480 640]);
    imagesc(RGB);
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-% SEGMENTATION
    
    [IMGBi,IMGSeg_CIE,~] = segmentation_RGB(RGB);
    axes(handles.img1);
    imagesc(IMGBi);
    axes(handles.img2);
    imagesc(IMGSeg_CIE);
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-% find border and calculate result
    [out_border,pos_px,num_object,er_find_line] = find_border(IMGBi); 
    axes(handles.img3);
    imagesc(out_border);
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-% check shape
    if er_find_line == 0
        [result_shape] = check_shape(pos_px,num_object,num_part,THR_convex,THR_block); 
    else
        result_shape = 0;
    end
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-% check color
    result_color = check_color(IMGSeg_CIE);   %IMGSeg
    
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-%
  %{ 
 if result_shape == 0 
        set(handles.RESULT,'String','BAD');
    else
        set(handles.RESULT,'String','GOOD');
end
%}
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-% display
    
%    axes(handles.img3);
%    plot(xO,yO,'*b');
    %======================================================
    if result_color==1
        set(handles.RESULT,'String','GOOD');
    else
        set(handles.RESULT,'String','BADs');
    end
  %}      
%==========================================================================%PROCESSING OFLINE MULTI
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
function Multi_Callback(hObject, eventdata, handles)
global IMG;
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
    
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-% SEGMENTATION
%    imwrite(IMG, 'D:\IMG.jpg');
    [IMGBi,IMGSeg_CIE,~] = segmentation_RGB(IMG,ADD_BINARY_THR); %Use RGB %-25
    axes(handles.img2);
    imagesc(IMGSeg_CIE);

    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-% find border and calculate result
     [~,pos_pixel,num_object] = find_border(IMGBi); 
    
    %==================================================END TEST
     if (num_object ~= 0)
        [out_result] = check_shape_color(IMGSeg_CIE,pos_pixel,num_object,num_part,THR_convex,THR_block);
     else
         out_result = 0;
%         SAME_POS_MT = zeros(20,3);
     end
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-% display

%    axes(handles.img3);
    if (num_object ~= 0)
        for ii=1:num_object
            hold on;
            if out_result(ii,3) == BAD 
                plot(out_result(ii,2),out_result(ii,1),'*r');
            end
        end
    end
%    SAME_POS_MT = zeros(20,3);
    %======================================================


%==========================================================================%GET THR
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
function GET_THR_Callback(hObject, eventdata, handles)

    GOOD = 1;
    BAD  = 0;
    count = 0;
    sum_object =0;
    number_shape = 0;
    TP   = 0;
    FN   = 0;
    
    
    ADD_BINARY_THR = get(handles.Add_binary_THR,'string');
    ADD_BINARY_THR = str2double(ADD_BINARY_THR);
    
    number_part    = get(handles.number_part,'string');
    THR_convex     = get(handles.THR_convex,'string');
    THR_block      = get(handles.THR_block,'string');
    num_part       = str2double(number_part);
    THR_convex     = str2double(THR_convex);
    THR_block      = str2double(THR_block);
    

    Review_bad       = fopen('D:\B. WORK\1. CODE_PROJECT\MATLAB\matlab_coffee_bean\Data_paper\Result_good.txt','w');

    addpath('D:\B. WORK\1. CODE_PROJECT\MATLAB\matlab_coffee_bean\Data_paper\GOOD_COFFEE\test');
    listTemplate   = dir('D:\B. WORK\1. CODE_PROJECT\MATLAB\matlab_coffee_bean\Data_paper\GOOD_COFFEE\test');
    [length,~]     = size(listTemplate);
    %====================================================================== start
    axes(handles.img); 
    for i=3:length
        set(handles.name_img,'String',listTemplate(i).name);   
        IMG = imread(listTemplate(i).name);
        RGB = imresize(IMG,[240 320]);
    %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-% segmentation
        fprintf('%d \n',i);
        [IMGBi,IMGSeg_CIE,~] = segmentation_RGB(RGB,ADD_BINARY_THR);
        imagesc(IMGSeg_CIE);
        pause(0.1);
             %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-% find border and calculate result
        [~,pos_pixel,num_object] = find_border(IMGBi); 

            if (num_object ~= 0)
                [out_result] = check_shape_color(IMGSeg_CIE,pos_pixel,num_object,num_part,THR_convex,THR_block);
            else
                out_result = 0;
            end
            %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-% Plot
            if (num_object~=0)
            for ii=1:num_object
                hold on;
                if out_result(ii,3) == BAD 
                    plot(out_result(ii,2),out_result(ii,1),'*r');
                    pause(0.1);
                end
            end
            end
            %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-% Write the result into txt
            for obj=1:num_object
                if (out_result(obj,3) == GOOD)
                    fprintf(Review_bad,'row:%d   col:%d   result:%d  GOOD \n',out_result(obj,1),out_result(obj,2),out_result(obj,3));
                    TP = TP + 1;
                else
                    fprintf(Review_bad,'row:%d   col:%d   result:%d  BAD \n',out_result(obj,1),out_result(obj,2),out_result(obj,3));
                    FN = FN + 1;
                end
            end
    end
        %---------------------------------------------------------------------------------------------
%fprintf(Review_bad,'FP: %d    TN: %d \n',FP,TN);
fprintf(Review_bad,'TP: %d    FN: %d \n',TP,FN);
fclose('all');
%Tn = 618    fp=33




%write_img2text();
%==========================================================================%OPEN CAMERA
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
function Open_Camera_Callback(hObject, eventdata, handles)
global cam;
global i;
i=44;
axes (handles.img);
cam = webcam(2);
hImage = image(handles.img, zeros(480,640,3)); %384  512
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

outputFileName = fullfile(strcat('D:\B. WORK\LAB\REPORT + PAPER\Coffee_shap_color\Data\shape\',num2str(i),'shape.jpg'));
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



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
