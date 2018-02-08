clc 
close all
%% Initialize
I0 = imread('Snoopsit1.jpg');  % Load picture from camera
J0 = imread('stool1.jpg');
Jr = imrotate(J0, 270);
Ir = imrotate(I0, 270);       %Rotate that shit

%% Convert RGB to Gray Image
I = rgb2gray(Ir);            %Convert 3-plane RGB image into grayscale intensity image (Which is apparently Logical *BW*)
J = rgb2gray(Jr);

%% Define Intensity of gray image conversion
I = I > 75;     %Set intensity of gray scale (255 representing black and 0 as white)
J = J > 75;     %75 is a good number that fully detects the stool and snoops

%% ROI STUFF
%% [1084.5 396.5;1100.5 3108.5;1860.5 3092.5;1772.5 388.5] %'Stool1' Stool Position NX2 CONTAINING X & Y COORDINATES
%% [60.5 1324.5;36.5 1932.5;396.5 2108.5;292.5 1588.5] %'Snoopssit1' Snoops hand position NX2 CONTAINING X & Y COORDINATES

Jc = [1084.5 1100.5 1860.5 1772.5]; %column vector for stool ROI
Jr = [396.5 3108.5 3092.5 388.5];   % Row vector for stool ROI
Hc = [60.5 36.5 396.5 292.5];        % Diddo for hand
Hr = [1324.5 1932.5 2108.5 1588.5];  

stoolROI = roipoly(J, Jc, Jr);%Black and white ROI of stool. stool = white = 255
handROI = roipoly(J, Hc, Hr);%Black and white ROI of Hand. hand = white = 255

S_mask = imsubtract(stoolROI, J); %Mask of stool. STOOL IS WHITE IN ROI
H_mask = imsubtract(handROI, J);  % Mask of Hand. HAND IS WHITE, REST OF IMAGE IS BLACK. 

%% Next need to determine sum of pixels in each image.

sum(S_mask(:) == 75);
pixel_stool = histc(S_mask(:), 0:1 ); %

sum(H_mask(:) == 75);
pixel_hand = histc(H_mask(:), 0:1 );

figure(1); imshow(S_mask);      
figure(2); imshow(H_mask); 

pixel_stool
pixel_hand
      



