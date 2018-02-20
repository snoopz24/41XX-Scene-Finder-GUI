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
b = imread('tablealt.jpg');
axes(handles.axes1);
imshow(b);

I0 = imread('Snoopsit1.jpg');  % Load picture from camera using snapshot feature
J0 = imread('stool1.jpg');
J01 = imread('stool3.jpg');
Jr = imrotate(J0, 270);
Ir = imrotate(I0, 270);       %Rotate 
J1r = imrotate(J01, 270);
tol = 7000;
%% Convert RGB to Gray Image
I = rgb2gray(Ir);            %Convert 3-plane RGB image into grayscale intensity image (Which is apparently Logical *BW*)
J = rgb2gray(Jr);
J1 = rgb2gray(J1r);

%% Define Intensity of gray image conversion
I = I > 75;     %Set intensity of gray scale (255 representing black and 0 as white)
J = J > 75;     %75 is a good number that fully detects the stool and snoops
J1 = J1 > 75;
%% ROI STUFF
%% [1084.5 396.5;1100.5 3108.5;1860.5 3092.5;1772.5 388.5] %'Stool1' Stool Position NX2 CONTAINING X & Y COORDINATES
%% [60.5 1324.5;36.5 1932.5;396.5 2108.5;292.5 1588.5] %'Snoopssit1' Snoops hand position NX2 CONTAINING X & Y COORDINATES

Jc = [1084.5 1100.5 1860.5 1772.5]; %column vector for stool ROI
Jr = [396.5 3108.5 3092.5 388.5];   % Row vector for stool ROI

Hc = [60.5 36.5 396.5 292.5];        % Diddo for hand
Hr = [1324.5 1932.5 2108.5 1588.5];  

stoolROI = roipoly(J, Jc, Jr);%Black and white ROI of stool. stool = white = 255   
snoopROI = stoolROI;
handROI = roipoly(J, Hc, Hr);%Black and white ROI of Hand. hand = white = 255
nohandROI = handROI;

S_mask = imsubtract(stoolROI, J); %Mask of stool. STOOL IS WHITE IN ROI
H_mask = imsubtract(handROI, J);  % Mask of Hand. HAND IS WHITE, REST OF IMAGE IS BLACK. 

S1_mask = imsubtract(stoolROI, J1);

Sn_mask = imsubtract(snoopROI, I); %Shows snoops on the stool
Nh_mask = imsubtract(nohandROI, I); %No hand in second ROI

%% Next need to determine sum of pixels in each image.

sum(S_mask(:) == 75);
sum(H_mask(:) == 75);
sum(Sn_mask(:) == 75);
sum(Nh_mask(:) == 75);
sum(S1_mask(:) == 75);

p_snoop = histc(Sn_mask(:), 0:1 );
p_stool = histc(S_mask(:), 0:1 ); 
p1_stool = histc(S1_mask(:), 0:1 );
p_hand = histc(H_mask(:), 0:1 );
p_nohand = histc(Nh_mask(:), 0:1 );

index3 = abs(p_stool -p_stool) <tol
index2 = abs(p_snoop - p_stool) <tol

if index2 == [1 1]
     d = 'theres no one here';
     d
     set(handles.panel1,'Backgroundcolor','r');
elseif index2 == [0 0]
    d = 'there is someone here';
    d
    set(handles.panel1,'Backgroundcolor','g');
else
     d = 'theres no one here';
     d
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

% --- Executes on button press in greenbutton.
function greenbutton_Callback(hObject, eventdata, handles)
% hObject    handle to greenbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel1,'Backgroundcolor','g');
set(handles.panel2,'Backgroundcolor','g');
