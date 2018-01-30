%% Pics of lab
% I1 = imread('pic1.jpg');
% I2 = imread('pic2.jpg');
% I3 = imread('pic3.jpg');
% I4 = imread('pic4.jpg');
% I5 = imread('pic5.jpg');
% J1 = imsubtract(I1, I2);
% J2 = imsubtract(I3, I4);
% J3 = imsubtract(I4, I5);
% J4 = imsubtract(I1, I5);
%imshow(J1)

Dan1 = imread('deal1.jpg'); %Dan stand
Dan2 = imread('deal2.jpg'); %Dan covering chair
stool1 = imread('stool1.jpg'); 
stool2 = imread('stool2.jpg');
stool3 = imread('stool3.jpg');
sit1 = imread('Snoopsit1.jpg');
sit2 = imread('Snoopsit2.jpg');
sit3 = imread('Snoopsit3.jpg');

%SubDan1 = imsubtract(Dan1, Dan2);
%imshow(F1) 
%SubDan2 = imsubtract(Dan2, Dan1);
%BW1 = roipoly(Dan1);
%grayImage = 255*uint8(BW1); Turn Binary Image into grayscale
%RGBDan = cat(3, grayImage, grayImage, grayImage); %Turn grayscale to RGB image

%imshow(RGBDan)

%BW2 = roipoly(D2);
%SubDan3 = imsubtract(RGBDan, Dan1); 

%imshow (SubDan3)
%disp("DONE"); Make MatLab display DONE in Command Window after code
%reaches here

BWstool1 = roipoly(stool1);
BWstool2 = roipoly(stool2);
BWstool3 = roipoly(stool3);

grayStool1 = 255*uint8(BWstool1);
grayStool2 = 255*uint8(BWstool2);
grayStool3 = 255*uint8(BWstool3);

RGBStool1 = cat(3, grayStool1, grayStool1, grayStool1); 
RGBStool2 = cat(3, grayStool2, grayStool2, grayStool2);
RGBStool3 = cat(3, grayStool3, grayStool3, grayStool3);

Substool1 = imsubtract(RGBStool1, sit1);
Substool1_2 = imsubtract(RGBStool2, sit1); 
Substool1_3 = imsubtract(RGBStool3, sit1);

Substool2 = imsubtract(RGBStool1, sit2);
Substool2_2 = imsubtract(RGBStool2, sit2);
Substool2_3 = imsubtract(RGBStool3, sit2);

Substool3 = imsubtract(RGBStool1, sit3);
Substool3_2 = imsubtract(RGBStool2, sit3);
Substool3_3 = imsubtract(RGBStool3, sit3);

figure(1); imshow(Substool1);
figure(12); imshow(Substool1_2);
figure(13); imshow(Substool1_3);

figure(2); imshow(Substool2);
figure(22); imshow(Substool2_2);
figure(23); imshow(Substool2_3);

figure(3); imshow(Substool3);
figure(32); imshow(Substool3_2);
figure(33); imshow(Substool3_3);

