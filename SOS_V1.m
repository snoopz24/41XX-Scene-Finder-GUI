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
SubDan1 = imsubtract(Dan1, Dan2);
%imshow(F1) 
SubDan2 = imsubtract(Dan2, Dan1);
BW1 = roipoly(Dan1);
grayImage = 255*uint8(BW1);
RGBDan = cat(3, grayImage, grayImage, grayImage);

%imshow(RGBDan)

%BW2 = roipoly(D2);
SubDan3 = imsubtract(RGBDan, Dan1); 

imshow (SubDan3)
disp("DONE");