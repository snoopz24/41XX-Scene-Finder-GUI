%% Initial Shit
clear;
clc
close all;

%% Webcam initialize
cam1=webcam;
base = imread('webcamtest3.jpg');
    
    tol = 2000;
gbase = rgb2gray(base);

gbase = gbase >75;

%imshow(gewall);
%ewallpoly = roipoly(gbase)

ewallC = [50.9999999 456 452 52.999];
ewallR = [421 426 88.9999 82.9999];

basePoly = roipoly(gbase,ewallC,ewallR);
baseMask = imsubtract(basePoly,gbase);

sum(baseMask(:) == 75);

p_base = histc(baseMask(:), 0:1 );

      
for v = 1:-0.2:0
    ewall = snapshot(cam1);
    gewall = rgb2gray(ewall); 
    gewall = gewall > 75; 
    
    ewallPoly = roipoly(gewall,ewallC,ewallR);
    ewallMask = imsubtract(ewallPoly, gewall);
    
    sum(ewallMask(:) == 75);
    p_cam = histc(ewallMask(:), 0:1);


indexL = abs(p_cam - p_base) <tol;
    
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
pause(5);
end


