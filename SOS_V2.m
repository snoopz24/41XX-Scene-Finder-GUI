clc 
close all
%% Initialize
I0 = imread('Snoopsit1.jpg');  % Load picture from camera using snapshot feature
J0 = imread('stool1.jpg');
J01 = imread('stool3.jpg');
Jr = imrotate(J0, 270);
Ir = imrotate(I0, 270);       %Rotate 
J1r = imrotate(J01, 270);

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


Diff_stool = p_snoop - p_stool; 
Diff_hand = p_nohand - p_hand;  % no matter the subtraction order one array is always negative
%% Tolarance comparison LOGICAL 

tol = 7000;

index = abs(p1_stool - p_stool) <tol %Compre Burst shot of an empty stool (used to calibrate tolarance) Should see a value of 1 for index meaning the images match (no object is detected)
index1 = abs(p_nohand - p_hand) <tol %Compare the ROI of Snoops' hand and then without the hand (ie we should see a value of 0 meaning the images do not match (object is detected)

figure(1); imshowpair(S_mask,Sn_mask,'montage')
title('Vacant Stool                                                Taken Stool');
figure(2); imshow(stoolROI)
% figure(2); imshowpair(H_mask,Nh_mask,'montage')
% title('Hand                                          No Hand');

% figure(1); imshow(S_mask);      %STOOL
% figure(2); imshow(H_mask);  %HAND
% figure(3); imshow(Sn_mask); %SNOOP
% figure(4); imshow(Nh_mask);      %NO HAND
% figure(5); imshow(S1_mask);   %Burst shot 2 of Stool (get minimum tolerance range from here) {tol = 7000} 