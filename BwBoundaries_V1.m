clc 
close all

I = imread('Snoopsit1.jpg');  % Load picture from camera
    I = imrotate(I, 270);       %Rotate that shit
    I = rgb2gray(I);            %Convert 3-plane RGB image into grayscale intensity image (Which is apparently Logical *BW*)
    grayImage = 255*uint8(I);
    I = I > 200;                %Set intensity of gray scale (255 representing black and 0 as white)
    figure (1); imshow(I)       % Display the image
    
J = imread('stool1.jpg');
    J = imrotate(J, 270);
    J = rgb2gray(J);
    J = J > 200;   
    figure (2); imshow(J)
       BW = imbinarize(I);
       [B,L] = bwboundaries(BW,'noholes');
       imshow(label2rgb(L, @jet, [.5 .5 .5]))
       hold on
       for k = 1:length(B)
           boundary = B{k};
           plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
       end