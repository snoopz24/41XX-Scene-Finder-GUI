%% To Do List

% inside the loop::
% get the picture
% convert to grey
% roipoly the image
% mask the image
% sum the image
% mask the image
% then subtract from p taken
% index
% 
% 
% outside the loop::
% initialized shit
% empty masks
% empty sums
% empty pempty

%% Initialize
clc
close all

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
     d
    elseif indexL == [0 0]
    d = 'there is someone here';
    d
    else
     d = 'theres no one here';
     d
    end
    
     %% Output Middle Seat
    if indexM == [1 1]
     d = 'theres no one here';
     d
    elseif indexM == [0 0]
    d = 'there is someone here';
    d
    else
     d = 'theres no one here';
     d
    end
     %% Output Right Seat
        if indexR == [1 1]
     d = 'theres no one here';
     d
    elseif indexR == [0 0]
    d = 'there is someone here';
    d
    else
     d = 'theres no one here';
     d
     
        end
    
    pause(5)
end

