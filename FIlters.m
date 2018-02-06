clc 
close all
clear all

I = imread('Snoopsit1.jpg');
J = imread('stool1.jpg');
 I = imrotate(I, 270);   
 J = imrotate(J, 270);
 I = rgb2gray(I);
 J = rgb2gray(J);
 
%BW1 = edge(I,'sobel'); %Crummy Filter
 BW2 = edge(I,'canny'); %Much nicer filter
% HW1 = edge(J, 'sobel');
 HW2 = edge(J, 'canny');
% figure(1); imshowpair(BW1,BW2,'montage')
% title('Sobel Filter                                   Canny Filter');
% 
% figure(2); imshowpair(HW1, HW2, 'montage')
% title('Sobel Filter                                   Canny Filter');

BW = BW2;
cc = bwconncomp(BW); 
stats = regionprops(cc, 'Area','Eccentricity'); 
idx = find([stats.Area] > 80 & [stats.Eccentricity] < 0.8); 
BW2 = ismember(labelmatrix(cc), idx); 
imshow(BW2)
