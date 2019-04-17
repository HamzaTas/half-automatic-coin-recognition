function varargout = ParaSayma(varargin)
% PARASAYMA MATLAB code for ParaSayma.fig
%      PARASAYMA, by itself, creates a new PARASAYMA or raises the existing
%      singleton*.
%
%      H = PARASAYMA returns the handle to a new PARASAYMA or the handle to
%      the existing singleton*.
%
%      PARASAYMA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARASAYMA.M with the given input arguments.
%
%      PARASAYMA('Property','Value',...) creates a new PARASAYMA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ParaSayma_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ParaSayma_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ParaSayma

% Last Modified by GUIDE v2.5 11-Apr-2019 19:22:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ParaSayma_OpeningFcn, ...
                   'gui_OutputFcn',  @ParaSayma_OutputFcn, ...
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


% --- Executes just before ParaSayma is made visible.
function ParaSayma_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ParaSayma (see VARARGIN)

% Choose default command line output for ParaSayma
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ParaSayma wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ParaSayma_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.jpg';'*.bmp';'*.png'},'File Selector');
resim = strcat(pathname,filename);
axes(handles.axes1)
imshow(resim)
set(handles.edit1,'string',filename);
set(handles.edit2,'string',pathname);

secim = get(handles.popupmenu1,'Value');

r=uint8(255*ones(370));
g=uint8(255*ones(370));
b=uint8(255*ones(370));

sonuc(:,:,1)=r;
sonuc(:,:,2)=g;
sonuc(:,:,3)=b;

%parlaklýk resmine dönüþüm
%imshow(para1Gray);

para1=imread(resim);%imread('para2.png');
para1=para1*1.5;
axes(handles.axes2)
imshow(para1);
para1 = rgb2gray(para1);
ek=min(para1(:));
eb=max(para1(:));
tresh=ek+(eb-ek)/2; 
ParaJ=para1>=tresh;
ParaJ=uint8(ParaJ*255);
lvl=graythresh(ParaJ);
bw=im2bw(ParaJ,lvl);
axes(handles.axes3)
imshow(bw);

[Bilgi Number]=bwlabel(ParaJ);
prop=regionprops(Bilgi,'Area','Centroid');
total1=0;
total50=0;
total25=0;
total10=0;
total5=0;


axes(handles.axes4)
imshow(imread(resim));hold on
for n=1:size(prop,1)
    para=prop(n).Centroid;
    X=round(para(1));Y=round(para(2));
    if prop(n).Area>1900
        text(X-10,Y,'1 TL') 
        total1=total1+1;       
        if secim==2
            rr = floor(sqrt((prop(n).Area)/pi)); 
            a =  imcrop(imread(resim),[X-rr Y-rr 2*rr 2*rr]);
            for i=X-rr:X+rr
           for j=Y-rr:Y+rr
            r(i,j)=a(i-(X-rr-1),j-(Y-rr-1),1);
            g(i,j)=a(i-(X-rr-1),j-(Y-rr-1),2);
            b(i,j)=a(i-(X-rr-1),j-(Y-rr-1),3);
           end
            end  
        end
        
    elseif prop(n).Area<1900 && prop(n).Area>1590
        text(X-10,Y,'50 Kr') 
        total50=total50+1; 
        
         if secim==3
            rr = floor(sqrt((prop(n).Area)/pi)); 
            a =  imcrop(imread(resim),[X-rr Y-rr 2*rr 2*rr]);
            for i=X-rr:X+rr
           for j=Y-rr:Y+rr
            r(i,j)=a(i-(X-rr-1),j-(Y-rr-1),1);
            g(i,j)=a(i-(X-rr-1),j-(Y-rr-1),2);
            b(i,j)=a(i-(X-rr-1),j-(Y-rr-1),3);
           end
            end  
        end
    elseif prop(n).Area<1590 && prop(n).Area>1230
        text(X-10,Y,'25 Kr') 
        total25=total25+1;
        
         if secim==4
            rr = floor(sqrt((prop(n).Area)/pi)); 
            a =  imcrop(imread(resim),[X-rr Y-rr 2*rr 2*rr]);
            for i=X-rr:X+rr
           for j=Y-rr:Y+rr
            r(i,j)=a(i-(X-rr-1),j-(Y-rr-1),1);
            g(i,j)=a(i-(X-rr-1),j-(Y-rr-1),2);
            b(i,j)=a(i-(X-rr-1),j-(Y-rr-1),3);
           end
            end  
        end
   elseif prop(n).Area<1230 && prop(n).Area>1050
        text(X-10,Y,'10 Kr') 
        total10=total10+1;
        
         if secim==5
            rr = floor(sqrt((prop(n).Area)/pi)); 
            a =  imcrop(imread(resim),[X-rr Y-rr 2*rr 2*rr]);
            for i=X-rr:X+rr
           for j=Y-rr:Y+rr
            r(i,j)=a(i-(X-rr-1),j-(Y-rr-1),1);
            g(i,j)=a(i-(X-rr-1),j-(Y-rr-1),2);
            b(i,j)=a(i-(X-rr-1),j-(Y-rr-1),3);
           end
            end  
        end
    else
        total5=total5+10;
        text(X-10,Y,'5 kr') 
        
         if secim==6
            rr = floor(sqrt((prop(n).Area)/pi)); 
            a =  imcrop(imread(resim),[X-rr Y-rr 2*rr 2*rr]);
            for i=X-rr:X+rr
           for j=Y-rr:Y+rr
            r(i,j)=a(i-(X-rr-1),j-(Y-rr-1),1);
            g(i,j)=a(i-(X-rr-1),j-(Y-rr-1),2);
            b(i,j)=a(i-(X-rr-1),j-(Y-rr-1),3);
           end
            end  
        end
    end
end
       sonuc(:,:,1)=r';
       sonuc(:,:,2)=g';
       sonuc(:,:,3)=b';
       axes(handles.axes6);
       imshow(sonuc);       
hold on
if secim==2
set(handles.text9,'string',total1);
set(handles.text10,'string','Adet 1 TL Bulunmaktadýr.');
elseif secim==3
set(handles.text9,'string',total50);
set(handles.text10,'string','Adet 50 Kuruþ Bulunmaktadýr.');
elseif secim==4
set(handles.text9,'string',total25);
set(handles.text10,'string','Adet 25 Kuruþ Bulunmaktadýr.');
elseif secim==5
set(handles.text9,'string',total10);
set(handles.text10,'string','Adet 10 Kuruþ Bulunmaktadýr.');
else secim==6
set(handles.text9,'string',total5);
set(handles.text10,'string','Adet 5 Kuruþ Bulunmaktadýr.');
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
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


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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
