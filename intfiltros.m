
function varargout = intfiltros(varargin)
% INTFILTROS MATLAB code for intfiltros.fig
%      INTFILTROS, by itself, creates a new INTFILTROS or raises the existing
%      singleton*.
%%
%      INTFILTROS('Property','Value',...) creates a new INTFILTROS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before intfiltros_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to intfiltros_OpeningFcn via varargin.

%      H = INTFILTROS returns the handle to a new INTFILTROS or the handle to
%      the existing singleton*.
%
%      INTFILTROS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTFILTROS.M with the given input arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help intfiltros

% Last Modified by GUIDE v2.5 21-Sep-2016 13:20:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @intfiltros_OpeningFcn, ...
                   'gui_OutputFcn',  @intfiltros_OutputFcn, ...
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


% --- Executes just before intfiltros is made visible.
function intfiltros_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to intfiltros (see VARARGIN)

% Imagen de fondo
ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
bg = imread('FondoInterfaz.png'); imagesc(bg);
set(ah,'handlevisibility','off','visible','off')
uistack(ah, 'bottom');

% Choose default command line output for intfiltros
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global p ft fp1s fp2s fs1s fs2s rps rss
p = 0;
ft = 0;
fp1s = 1;
fp2s = 10;
fs1s = 5;
fs2s = 50;
rps = 2;
rss = 10;

% UIWAIT makes intfiltros wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = intfiltros_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in unob.

% Hint: get(hObject,'Value') returns toggle state of cuatroc


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% opciones
global Fs wp ws p rps rss N Wn a b f mod senalf ft
if (hObject==handles.cero)
    [N,Wn] = buttord(wp,ws,rps,rss)
    if (p == 0)
        [b,a]=butter(N,Wn);
    elseif (p == 1)
        [b,a]=butter(N,Wn,'high');
    elseif (p == 2)
        [b,a]=butter(N,Wn);
    elseif (p == 3)
        [b,a]=butter(N,Wn,'stop');
    end
    ft = 0;
       
elseif (hObject==handles.uno)
    ft= 1;
    [N,Wn] = cheb1ord(wp,ws,rps,rss);
    if (p == 0)
        [b,a]=cheby1(N,rps,Wn);
    elseif (p == 1)
        [b,a]=cheby1(N,rps,Wn,'high');
    elseif (p == 2)
        [b,a]=cheby1(N,rps,Wn);
    elseif (p == 3)
        [b,a]=cheby1(N,rps,Wn,'stop');
    end
    
elseif (hObject==handles.dos)
    ft = 2;
    [N,Wn] = cheb2ord(wp,ws,rps,rss);
    if (p == 0)
        [b,a]=cheby2(N,rss,Wn);
    elseif (p == 1)
        [b,a]=cheby2(N,rss,Wn,'high');
    elseif (p == 2)
        [b,a]=cheby2(N,rss,Wn);
    elseif (p == 3)
        [b,a]=cheby2(N,rss,Wn,'stop');
    end
   
elseif (hObject==handles.tresa)
    ft = 3;
    [N,Wn] = ellipord(wp,ws,rps,rss);
    if (p == 0)
        [b,a]=ellip(N,rps,rss,Wn);
    elseif (p == 1)
        [b,a]=ellip(N,rps,rss,Wn,'high');
    elseif (p == 2)
        [b,a]=ellip(N,rps,rss,Wn);
    elseif (p == 3)
        [b,a]=ellip(N,rps,rss,Wn,'stop');
    end
    
end
senalf=filter(b,a,mod);
    
    Lv=length(senalf);
    Yv = fft(senalf);
    P2v = abs(Yv/Lv);
    P1v = P2v(1:Lv/2+1);
    P1v(2:end-1) = 2*P1v(2:end-1);
    fv = Fs*(0:(Lv/2))/Lv;
    axes(handles.axes2)
    plot(fv,P1v)
    
    f = 0: 1: 4000;
    H = freqz(b,a,f,Fs);
    axes(handles.axes1);
    plot(f,abs(H));

    t=(0:length(senalf)-1)/Fs;
    axes(handles.axes3);
    plot(t,senalf);
   


% --- Executes on slider movement.
function fp1s_Callback(hObject, eventdata, handles)
% hObject    handle to fp1s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fp1s senalf Fs b a f wp ws fs1s fp2s fs2s p ft rps rss N Wn mod 

fp1s=get(hObject,'Value');
fp1s=4000*fp1s;
set(handles.fp1,'String',fp1s);
if (p == 0)
    wp = (2*fp1s)/Fs;
    ws = (2*fs1s)/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss);
            [b,a]=butter(N,Wn);       
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn);    
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn);  
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn);   
        end

elseif (p == 1)
    wp = (2*fp1s)/Fs;
    ws = (2*fs1s)/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss)
            [b,a]=butter(N,Wn,'high');      
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn,'high');   
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn,'high');
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn,'high');
        end
    
elseif (p == 2)
    wp = [2*fp1s, 2*fp2s]/Fs;
    ws = [2*fs1s, 2*fs2s]/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss)
            [b,a]=butter(N,Wn);       
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn);    
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn);
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn);
        end
elseif (p == 3)
    wp = [2*fp1s, 2*fp2s]/Fs;
    ws = [2*fs1s, 2*fs2s]/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss);
            [b,a]=butter(N,Wn,'stop');
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn,'stop');   
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn,'stop');
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn,'stop');
        end
    

end

senalf=filter(b,a,mod);
    
    Lv=length(senalf);
    Yv = fft(senalf);
    P2v = abs(Yv/Lv);
    P1v = P2v(1:Lv/2+1);
    P1v(2:end-1) = 2*P1v(2:end-1);
    fv = Fs*(0:(Lv/2))/Lv;
    axes(handles.axes2)
    plot(fv,P1v)
    
    f = 0: 1: 4000;
    H = freqz(b,a,f,Fs);
    axes(handles.axes1);
    plot(f,abs(H));

    t=(0:length(senalf)-1)/Fs;
    axes(handles.axes3);
    plot(t,senalf);

    

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fp1s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fp1s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fp2s_Callback(hObject, eventdata, handles)
% hObject    handle to fp2s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fp1s senalf Fs b a f wp ws fs1s fp2s fs2s p ft rps rss N Wn mod t

fp2s=get(hObject,'Value');
fp2s=4000*fp2s;
set(handles.fp2,'String',fp2s);

if (p == 0)
    wp = (2*fp1s)/Fs;
    ws = (2*fs1s)/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss);
            [b,a]=butter(N,Wn);       
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn);    
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn);  
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn);   
        end

elseif (p == 1)
    wp = (2*fp1s)/Fs;
    ws = (2*fs1s)/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss)
            [b,a]=butter(N,Wn,'high');      
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn,'high');   
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn,'high');
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn,'high');
        end
    
elseif (p == 2)
    wp = [2*fp1s, 2*fp2s]/Fs;
    ws = [2*fs1s, 2*fs2s]/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss)
            [b,a]=butter(N,Wn);       
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn);    
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn);
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn);
        end
elseif (p == 3)
    wp = [2*fp1s, 2*fp2s]/Fs;
    ws = [2*fs1s, 2*fs2s]/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss);
            [b,a]=butter(N,Wn,'stop');
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn,'stop');   
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn,'stop');
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn,'stop');
        end
    

end

senalf=filter(b,a,mod);
    
    Lv=length(senalf);
    Yv = fft(senalf);
    P2v = abs(Yv/Lv);
    P1v = P2v(1:Lv/2+1);
    P1v(2:end-1) = 2*P1v(2:end-1);
    fv = Fs*(0:(Lv/2))/Lv;
    axes(handles.axes2)
    plot(fv,P1v)
    
    f = 0: 1: 4000;
    H = freqz(b,a,f,Fs);
    axes(handles.axes1);
    plot(f,abs(H));

    t=(0:length(senalf)-1)/Fs;
    axes(handles.axes3);
    plot(t,senalf);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fp2s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fp2s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fs1s_Callback(hObject, eventdata, handles)
% hObject    handle to fs1s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fp1s senalf Fs b a f wp ws fs1s fp2s fs2s p ft rps rss N Wn mod t

% set(hObject,'Min',(fp1s/4000));
fs1s=get(hObject,'Value');
fs1s=4000*fs1s;
set(handles.fs1,'String',fs1s);

if (p == 0)
    wp = (2*fp1s)/Fs;
    ws = (2*fs1s)/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss);
            [b,a]=butter(N,Wn);       
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn);    
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn);  
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn);   
        end

elseif (p == 1)
    wp = (2*fp1s)/Fs;
    ws = (2*fs1s)/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss)
            [b,a]=butter(N,Wn,'high');      
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn,'high');   
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn,'high');
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn,'high');
        end
    
elseif (p == 2)
    wp = [2*fp1s, 2*fp2s]/Fs;
    ws = [2*fs1s, 2*fs2s]/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss)
            [b,a]=butter(N,Wn);       
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn);    
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn);
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn);
        end
elseif (p == 3)
    wp = [2*fp1s, 2*fp2s]/Fs;
    ws = [2*fs1s, 2*fs2s]/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss);
            [b,a]=butter(N,Wn,'stop');
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn,'stop');   
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn,'stop');
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn,'stop');
        end
    

end

senalf=filter(b,a,mod);
    
    Lv=length(senalf);
    Yv = fft(senalf);
    P2v = abs(Yv/Lv);
    P1v = P2v(1:Lv/2+1);
    P1v(2:end-1) = 2*P1v(2:end-1);
    fv = Fs*(0:(Lv/2))/Lv;
    axes(handles.axes2)
    plot(fv,P1v)
    
    f = 0: 1: 4000;
    H = freqz(b,a,f,Fs);
    axes(handles.axes1);
    plot(f,abs(H));

    t=(0:length(senalf)-1)/Fs;
    axes(handles.axes3);
    plot(t,senalf);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fs1s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fs1s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fs2s_Callback(hObject, eventdata, handles)
% hObject    handle to fs2s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fp1s senalf Fs b a f wp ws fs1s fp2s fs2s p ft rps rss N Wn mod t

fs2s=get(hObject,'Value');
fs2s=4000*fs2s;
set(handles.fs2,'String',fs2s);

if (p == 0)
    wp = (2*fp1s)/Fs;
    ws = (2*fs1s)/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss);
            [b,a]=butter(N,Wn);       
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn);    
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn);  
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn);   
        end

elseif (p == 1)
    wp = (2*fp1s)/Fs;
    ws = (2*fs1s)/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss)
            [b,a]=butter(N,Wn,'high');      
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn,'high');   
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn,'high');
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn,'high');
        end
    
elseif (p == 2)
    wp = [2*fp1s, 2*fp2s]/Fs;
    ws = [2*fs1s, 2*fs2s]/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss)
            [b,a]=butter(N,Wn);       
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn);    
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn);
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn);
        end
elseif (p == 3)
    wp = [2*fp1s, 2*fp2s]/Fs;
    ws = [2*fs1s, 2*fs2s]/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss);
            [b,a]=butter(N,Wn,'stop');
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn,'stop');   
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn,'stop');
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn,'stop');
        end
    

end

senalf=filter(b,a,mod);
    
    Lv=length(senalf);
    Yv = fft(senalf);
    P2v = abs(Yv/Lv);
    P1v = P2v(1:Lv/2+1);
    P1v(2:end-1) = 2*P1v(2:end-1);
    fv = Fs*(0:(Lv/2))/Lv;
    axes(handles.axes2)
    plot(fv,P1v)
    
    f = 0: 1: 4000;
    H = freqz(b,a,f,Fs);
    axes(handles.axes1);
    plot(f,abs(H));

    t=(0:length(senalf)-1)/Fs;
    axes(handles.axes3);
    plot(t,senalf);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fs2s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fs2s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function rps_Callback(hObject, eventdata, handles)
% hObject    handle to rps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fp1s senalf Fs b a f wp ws fs1s fp2s fs2s p ft rps rss N Wn mod t
rps=get(hObject,'Value');
rps=40*rps;
set(handles.rp,'String',rps);

if (p == 0)
    wp = (2*fp1s)/Fs;
    ws = (2*fs1s)/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss);
            [b,a]=butter(N,Wn);       
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn);    
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn);  
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn);   
        end

elseif (p == 1)
    wp = (2*fp1s)/Fs;
    ws = (2*fs1s)/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss)
            [b,a]=butter(N,Wn,'high');      
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn,'high');   
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn,'high');
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn,'high');
        end
    
elseif (p == 2)
    wp = [2*fp1s, 2*fp2s]/Fs;
    ws = [2*fs1s, 2*fs2s]/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss)
            [b,a]=butter(N,Wn);       
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn);    
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn);
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn);
        end
elseif (p == 3)
    wp = [2*fp1s, 2*fp2s]/Fs;
    ws = [2*fs1s, 2*fs2s]/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss);
            [b,a]=butter(N,Wn,'stop');
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn,'stop');   
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn,'stop');
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn,'stop');
        end
    

end

senalf=filter(b,a,mod);
    
    Lv=length(senalf);
    Yv = fft(senalf);
    P2v = abs(Yv/Lv);
    P1v = P2v(1:Lv/2+1);
    P1v(2:end-1) = 2*P1v(2:end-1);
    fv = Fs*(0:(Lv/2))/Lv;
    axes(handles.axes2)
    plot(fv,P1v)
    
    f = 0: 1: 4000;
    H = freqz(b,a,f,Fs);
    axes(handles.axes1);
    plot(f,abs(H));

    t=(0:length(senalf)-1)/Fs;
    axes(handles.axes3);
    plot(t,senalf);


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function rps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function rss_Callback(hObject, eventdata, handles)
% hObject    handle to rss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fp1s senalf Fs b a f wp ws fs1s fp2s fs2s p ft rps rss N Wn mod t
rss=get(hObject,'Value');
rss=40*rss;
set(handles.rs,'String',rss);


if (p == 0)
    wp = (2*fp1s)/Fs;
    ws = (2*fs1s)/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss);
            [b,a]=butter(N,Wn);       
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn);    
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn);  
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn);   
        end

elseif (p == 1)
    wp = (2*fp1s)/Fs;
    ws = (2*fs1s)/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss)
            [b,a]=butter(N,Wn,'high');      
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn,'high');   
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn,'high');
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn,'high');
        end
    
elseif (p == 2)
    wp = [2*fp1s, 2*fp2s]/Fs;
    ws = [2*fs1s, 2*fs2s]/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss)
            [b,a]=butter(N,Wn);       
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn);    
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn);
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn);
        end
elseif (p == 3)
    wp = [2*fp1s, 2*fp2s]/Fs;
    ws = [2*fs1s, 2*fs2s]/Fs;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss);
            [b,a]=butter(N,Wn,'stop');
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn,'stop');   
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn,'stop');
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn,'stop');
        end
    

end

senalf=filter(b,a,mod);
    
    Lv=length(senalf);
    Yv = fft(senalf);
    P2v = abs(Yv/Lv);
    P1v = P2v(1:Lv/2+1);
    P1v(2:end-1) = 2*P1v(2:end-1);
    fv = Fs*(0:(Lv/2))/Lv;
    axes(handles.axes2)
    plot(fv,P1v)
    
    f = 0: 1: 4000;
    H = freqz(b,a,f,Fs);
    axes(handles.axes1);
    plot(f,abs(H));

    t=(0:length(senalf)-1)/Fs;
    axes(handles.axes3);
    plot(t,senalf);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function rss_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes when selected object is changed in uibuttongroup2.
function uibuttongroup2_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup2 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fp1s Fs wp ws fs1s fp2s fs2s p N Wn rps rss b a t senalf f mod ft
if (hObject==handles.cerop)
    wp = (2*fp1s)/Fs;
    ws = (2*fs1s)/Fs;
    p = 0;
         if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss);
            [b,a]=butter(N,Wn);       
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn);    
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn);  
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn);   
        end
            
elseif (hObject==handles.unop)
    wp = (2*fp1s)/Fs;
    ws = (2*fs1s)/Fs;
    p = 1;
    
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss)
            [b,a]=butter(N,Wn,'high');      
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn,'high');   
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn,'high');
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn,'high');
        end
elseif (hObject==handles.dosp)
    wp = [2*fp1s, 2*fp2s]/Fs;
    ws = [2*fs1s, 2*fs2s]/Fs;
    p = 2;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss)
            [b,a]=butter(N,Wn);       
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn);    
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn);
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn);
        end
    
elseif (hObject==handles.tresp)
    wp = [2*fp1s, 2*fp2s]/Fs;
    ws = [2*fs1s, 2*fs2s]/Fs;
    p = 3;
        if (ft == 0)
            [N,Wn] = buttord(wp,ws,rps,rss);
            [b,a]=butter(N,Wn,'stop');
        elseif (ft == 1)
            [N,Wn] = cheb1ord(wp,ws,rps,rss);
            [b,a]=cheby1(N,rps,Wn,'stop');   
        elseif (ft == 2)
            [N,Wn] = cheb2ord(wp,ws,rps,rss);
            [b,a]=cheby2(N,rss,Wn,'stop');
        elseif (ft == 3)
            [N,Wn] = ellipord(wp,ws,rps,rss);
            [b,a]=ellip(N,rps,rss,Wn,'stop');
        end
end
senalf=filter(b,a,mod);
    
    Lv=length(senalf);
    Yv = fft(senalf);
    P2v = abs(Yv/Lv);
    P1v = P2v(1:Lv/2+1);
    P1v(2:end-1) = 2*P1v(2:end-1);
    fv = Fs*(0:(Lv/2))/Lv;
    axes(handles.axes2)
    plot(fv,P1v)
    
    f = 0: 1: 4000;
    H = freqz(b,a,f,Fs);
    axes(handles.axes1);
    plot(f,abs(H));

    t=(0:length(senalf)-1)/Fs;
    axes(handles.axes3);
    plot(t,senalf);
% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Close.
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close intfiltros


% --- Executes on button press in cero.
function cero_Callback(hObject, eventdata, handles)
% hObject    handle to cero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cero


% --- Executes on button press in uno.
function uno_Callback(hObject, eventdata, handles)
% hObject    handle to uno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of uno
