%% Initialize
clear;
clc;
close all;
tolL = 1000;
tol = 7000;

%% Initial Webcam Pic
cam1 = webcam;
base = snapshot(cam1);
%base = imread('webcamtes6.jpg');

gbase = rgb2gray(base);
gbase = gbase > 50;
%%imshow(gbase);

%% Roi Ploy each chair
%basepoly = roipoly(base)

LChairC = [22.999999999 21.999999999 178 174];
LChairR = [137 434 435 131];

MChairC = [244 242 395 388];
MChairR = [133 450 452 133];

RChairC = [481 480 621 611];
RChairR = [131 442 446 133];

PolyCL = roipoly(gbase,LChairC,LChairR);
MaskL = imsubtract(PolyCL,gbase);

PolyCM = roipoly(gbase,MChairC,MChairR);
MaskM = imsubtract(PolyCM,gbase);

PolyCR = roipoly(gbase,RChairC,RChairR);
MaskR = imsubtract(PolyCR,gbase);

sum(MaskL(:) == 50);
sum(MaskM(:) == 50);
sum(MaskR(:) == 50);

p_baseL = histc(MaskL(:), 0:1);
p_baseM = histc(MaskM(:), 0:1);
p_baseR = histc(MaskR(:), 0:1);

% for i = 10:-1:0
%   
pause(5)
    v=10-i;
    X = ['This is test number ', num2str(v)];
    disp(X)
    
    life = snapshot(cam1);
    glife = rgb2gray(life); 
    glife = glife > 50; 
    
    glifeL = roipoly(glife,LChairC,LChairR);
    lifeMaskL = imsubtract(glifeL, glife);
    imshow(lifeMaskL)
    glifeM = roipoly(glife,MChairC,MChairR);
    lifeMaskM = imsubtract(glifeM, glife);
    
    glifeR = roipoly(glife,RChairC,RChairR);
    lifeMaskR = imsubtract(glifeR, glife);
    
    sum(lifeMaskL(:) == 50);
    sum(lifeMaskM(:) == 50);
    sum(lifeMaskR(:) == 50);

    p_lifeL = histc(lifeMaskL(:), 0:1);
    p_lifeM = histc(lifeMaskM(:), 0:1);
    p_lifeR = histc(lifeMaskR(:), 0:1);

    indexL = abs(p_lifeL - p_baseL) <tol;
    indexM = abs(p_lifeM - p_baseM) <tol;
    indexR = abs(p_lifeR - p_baseR) <tol;
    
    if indexL == [1 1]
         d = 'theres no one L';
         disp(d);
        elseif indexL == [0 0]
        d = 'there is someone L';
        disp(d);
        else
         d = 'theres no one L';
        disp(d);
    end
        
%     if indexM == [1 1]
%      d = 'theres no one M';
%      disp(d);
%     elseif indexM == [0 0]
%     d = 'there is someone M';
%    disp(d);
%     else
%      d = 'theres no one M';
%      disp(d);
%     end
% 
    if indexR == [1 1]
     d = 'theres no one R';
    disp(d);
    elseif indexR == [0 0]
    d = 'there is someone R';
    disp(d);
    else
     d = 'theres no one R';
    disp(d);
    end
    
pause(2);
% end

