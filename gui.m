function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 19-Feb-2018 15:50:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

   

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
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
b = imread('tablealt2.jpg');
axes(handles.axes1);
imshow(b);

SL = imread('snoopsitLeft.jpg');
SM = imread('snoopsitMid.jpg');
SR = imread('snoopsitRight.jpg');

SLR = imrotate(SL, 270);
SMR = imrotate(SM, 270);
SRR = imrotate(SR, 270);

%% Convert RGB to Gray Image
SLG = rgb2gray(SLR);            %Convert 3-plane RGB image into grayscale intensity image (Which is apparently Logical *BW*)
SMG = rgb2gray(SMR);
SRG = rgb2gray(SRR);


SLG = SLG > 55;     %Set intensity of gray scale (255 representing black and 0 as white)
SMG = SMG > 55;     %75 is a good number that fully detects the stool and snoops
SRG = SRG > 55;


%% Empty masks

SLC = [1112 545 500 1073];
SLR = [3014 3038 2000 1988];

SLCempty = [1112 545 500 1073];
SLRempty = [3014 3038 2000 1988];

SMC = [1127 1133 1604 1598];
SMR = [1916 3062 3065 1916];

SRC = [1602.5 2122.5 2146.5 2994.5];
SRR = [1926.5 1926.5 2990.5 2994.5];

SLGemptypoly = roipoly(SMG, SLCempty, SLRempty);
SLemptymask = imsubtract(SLGemptypoly, SMG);

SMGemptypoly = roipoly(SLG,SMC,SMR);
SMemptymask = imsubtract(SMGemptypoly, SLG);

SRGemptypoly = roipoly(SLG,SRC,SRR);
SRemptymask = imsubtract(SRGemptypoly, SLG);

%% Empty Sums and histc

sum(SLemptymask(:) == 55);
sum(SMemptymask(:) == 55);
sum(SRemptymask(:) == 55);

p_emptyR = histc(SRemptymask(:), 0:1);
p_emptyM = histc(SMemptymask(:), 0:1);
p_emptyL = histc(SLemptymask(:), 0:1);


%% Looped captured images
% inside the loop::
% get the picture
% convert to grey
% roipoly the image
% mask the image
% sum the image
% mask the image
% then subtract from p taken
% index

%code for getting pic from camera and rotating it so its usable
%code for converting the image to grey scale


for v = 1.0:-0.2:0
    
    %code for getting pic from camera and rotating it so its usable
    %code for converting the image to grey scale
    %% Roipoly and Mask
    SLGpoly = roipoly(SLG, SLC, SLR);
    SLmask = imsubtract(SLGpoly, SLG);
    
    SMGpoly = roipoly(SLG, SMC, SMR);  %changed to look at snoopsitleft pic mid seat
    SMmask = imsubtract(SMGpoly, SLG);

    SRGpoly = roipoly(SLG, SRC, SRR); %changed to look at snoopsitleft pic right seat
    SRmask = imsubtract(SRGpoly, SLG);
    %% Sum and Histc
    
    sum(SLmask(:) == 55);
    sum(SMmask(:) == 55);
    sum(SRmask(:) == 55);
    
    p_takenL = histc(SLmask(:), 0:1 );
    p_takenM = histc(SMmask(:), 0:1);
    p_takenR = histc(SRmask(:), 0:1);

    %% Index Comparison
    tol = 15000;
    
    indexL = abs(p_takenL - p_emptyL) <tol;
    indexM = abs(p_takenM - p_emptyM) <tol;
    indexR = abs(p_takenR - p_emptyR) <tol;
    
        if indexL == [1 1]
     d = 'theres no one here';
    set(handles.panel1,'Backgroundcolor','g');
    elseif indexL == [0 0]
    d = 'there is someone here';
    set(handles.panel1,'Backgroundcolor','r');
    else
     d = 'theres no one here';
     
    end
    
     %% Output Middle Seat
    if indexM == [1 1]
     d = 'theres no one here';
     set(handles.panel2,'Backgroundcolor','g');
    elseif indexM == [0 0]
    d = 'there is someone here';
    set(handles.panel2,'Backgroundcolor','r');
    else
     d = 'theres no one here';
     
    end
     %% Output Right Seat
        if indexR == [1 1]
     d = 'theres no one here';
     set(handles.panel3,'Backgroundcolor','g');
    elseif indexR == [0 0]
    d = 'there is someone here';
    set(handles.panel3,'Backgroundcolor','r');
    else
     d = 'theres no one here';
          
     end
    
    pause(2)
end

% --- Executes on button press in redbutton.
function redbutton_Callback(hObject, eventdata, handles)
% hObject    handle to redbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get the handles of all pushbuttons and radiobuttons

% Change to red all these buttons

set(handles.panel1,'Backgroundcolor','r');
set(handles.panel2,'Backgroundcolor','r');
set(handles.panel3,'Backgroundcolor','r');

% --- Executes on button press in greenbutton.
function greenbutton_Callback(hObject, eventdata, handles)
% hObject    handle to greenbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel1,'Backgroundcolor','g');
set(handles.panel2,'Backgroundcolor','g');
set(handles.panel3,'Backgroundcolor','g');
