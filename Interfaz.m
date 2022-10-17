function varargout = Interfaz(varargin)
% INTERFAZ MATLAB code for Interfaz.fig
%      INTERFAZ, by itself, creates a new INTERFAZ or raises the existing
%      singleton*.
%
%      H = INTERFAZ returns the handle to a new INTERFAZ or the handle to
%      the existing singleton*.
%
%      INTERFAZ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFAZ.M with the given input arguments.
%
%      INTERFAZ('Property','Value',...) creates a new INTERFAZ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interfaz_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interfaz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interfaz

% Last Modified by GUIDE v2.5 22-Sep-2016 19:45:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interfaz_OpeningFcn, ...
                   'gui_OutputFcn',  @Interfaz_OutputFcn, ...
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


% --- Executes just before Interfaz is made visible.
function Interfaz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Interfaz (see VARARGIN)

% Imagen de fondo
ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
bg = imread('FondoInterfaz.png'); imagesc(bg);
set(ah,'handlevisibility','off','visible','off')
uistack(ah, 'bottom');

% Choose default command line output for Interfaz
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Iconos
imageplay=imread('Play.png');
icoplay=imresize(imageplay,[51 51]);
set(handles.pushbutton1,'CData',icoplay);
set(handles.pushbutton3,'CData',icoplay);
imagerec=imread('Rec.png');
icorec=imresize(imagerec,[51 51]);
set(handles.pushbutton4,'CData',icorec);

global tem
tem=5;

% global mod tr Fs
% Fs=8000;
% mod(1:3)=0;
% axes(handles.axes2);
% tr=(0:length(mod)-1)/Fs;
% plot(tr,mod);


% UIWAIT makes Interfaz wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Interfaz_OutputFcn(hObject, eventdata, handles) 
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
global voz Fs
sound(voz,Fs);
set(handles.text1,'String','Now playing');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Reproducir la señal modificada
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mod Fs
sound(mod,Fs);
set(handles.text1,'String','Now playing');


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Menu Grafico/Time---------------------------------------------------
% --------------------------------------------------------------------
function Untitled_13_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs t voz tr mod
t=(0:length(voz)-1)/Fs;
axes(handles.axes1);
plot(t,voz);
tr=(0:length(mod)-1)/Fs;
axes(handles.axes2);
plot(tr,mod);
set(handles.text1,'String','Time signal');


% Menu Grafico/FFT----------------------------------------------------
% --------------------------------------------------------------------
function Untitled_14_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global voz Fs mod
Lv=length(voz);
Yv = fft(voz);
P2v = abs(Yv/Lv);
P1v = P2v(1:Lv/2+1);
P1v(2:end-1) = 2*P1v(2:end-1);
fv = Fs*(0:(Lv/2))/Lv;
axes(handles.axes1)
plot(fv,P1v)
% title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
Lm=length(mod);
Ym = fft(mod);
P2m = abs(Ym/Lm);
P1m = P2m(1:Lm/2+1);
P1m(2:end-1) = 2*P1m(2:end-1);
fm = Fs*(0:(Lm/2))/Lm;
axes(handles.axes2)
plot(fm,P1m)
% title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
set(handles.text1,'String','FFT signal');


% Menu Tools/Edit-----------------------------------------------------
% --------------------------------------------------------------------
function Untitled_11_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global voz Fs mod tr
set(handles.text1,'String','Select first breakpoit');
[x0,y] = ginput(1); %Punto inicial para recortar la señal
set(handles.text1,'String','Select second breakpoit');
[x1,y] = ginput(1); %Punto final para recortar la señal
set(handles.text1,'String','Select where you want to edit');
[x2,y] = ginput(1); %Donde se desea copiar la señal recortada
set(handles.text1,'String','OK');
x0=round(x0*Fs);
x1=round(x1*Fs);
x2=round(x2*Fs);
mod(x2:(x1-x0)+x2)=voz(x0:x1);
axes(handles.axes2)
tr=(0:length(mod)-1)/Fs;
plot(tr,mod)


% Insertar una senal en la señal modificada
% --------------------------------------------------------------------
function Untitled_12_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global voz Fs mod
set(handles.text1,'String','Select first breakpoit');
[x0,y] = ginput(1); %Punto inicial para recortar la señal
set(handles.text1,'String','Select second breakpoit');
[x1,y] = ginput(1); %Punto final para recortar la señal
set(handles.text1,'String','Select where you want to insert');
[x2,y] = ginput(1); %Donde se desea copiar la señal recortada
set(handles.text1,'String','OK');
x0=round(x0*Fs);
x1=round(x1*Fs);
x2=round(x2*Fs);
senal1=voz(x0:x1);
senal2=mod(x2:end);
mod(x2:end)=0;
mod(x2:x2+(x1-x0))=senal1';
mod(x2+(x1-x0):x2+(x1-x0)+length(senal2)-1)=senal2;
axes(handles.axes2)
tr=(0:length(mod)-1)/Fs;
plot(tr,mod)


% Mezclar señales-----------------------------------------------------
% --------------------------------------------------------------------
function Untitled_15_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global voz Fs mod
set(handles.text1,'String','Select first breakpoit');
[x0,y] = ginput(1); %Punto inicial para recortar la señal
set(handles.text1,'String','Select second breakpoit');
[x1,y] = ginput(1); %Punto final para recortar la señal
set(handles.text1,'String','Select where you want to mix');
[x2,y] = ginput(1); %Donde se desea copiar la señal recortada
set(handles.text1,'String','OK');
x0=round(x0*Fs);
x1=round(x1*Fs);
x2=round(x2*Fs)+1;
senal1=voz(x0:x1);
% a1=length(mod);
a=length(mod(x2:end));
b=length(voz(x0:x1));
if (length(mod(x2:end))<length(voz(x0:x1)))
    mod(x2:x2+(x1-x0))=0;
end
senal2=mod(x2:x2+(x1-x0));
senalt=senal1'+senal2;
mod(x2:x2+(x1-x0))=senalt;
axes(handles.axes2)
tr=(0:length(mod)-1)/Fs;
plot(tr,mod)


% --------------------------------------------------------------------
function Untitled_20_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_21_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_22_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_23_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs t voz mod

intfiltros

uiwait

% Menu File/grabar----------------------------------------------------
% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs t voz
Fs=8000;
recObj = audiorecorder (Fs,16,1);
set(handles.text1,'String','Start speaking.');
recordblocking(recObj, 5);
set(handles.text1,'String','End of Recording.');
voz = getaudiodata(recObj);
t=(0:length(voz)-1)/Fs;
axes(handles.axes1);
plot(t,voz);


% Menu File/Import MP3------------------------------------------------
% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global voz Fs t
[FileName Path]=uigetfile({'*.mp3;*.wav'},'Escoger audio');
[voz,Fs] = audioread(strcat(Path,FileName));
t=(0:length(voz)-1)/Fs;
axes(handles.axes1);
plot(t,voz);
set(handles.text1,'String','Importing');


% Guardar la señal modificada-----------------------------------------
% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mod Fs
[file,path] = uiputfile('Senal.wav','Save file name');
audiowrite(strcat(path,file),mod,Fs);
set(handles.text1,'String',strcat('Saved as ',file));


% Salir del programa--------------------------------------------------
% --------------------------------------------------------------------
function Untitled_10_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
clc;
clear all;


% Boton de grabar---------------------------------------------------------
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs t voz tem
Fs=8000;
recObj = audiorecorder (Fs,16,1);
set(handles.text1,'String','Start speaking.');
recordblocking(recObj, tem);
set(handles.text1,'String','End of Recording.');
voz = getaudiodata(recObj);
t=(0:length(voz)-1)/Fs;
axes(handles.axes1);
plot(t,voz);


% --- Executes during object creation, after setting all properties.
function pushbutton4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


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


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
clear;
clear all;
% set(handles.text1,'String','All data deleted');


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global tem
tem=get(hObject,'value');
set(handles.text5,'string',tem);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function uitoggletool4_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
clear all;
close all;
