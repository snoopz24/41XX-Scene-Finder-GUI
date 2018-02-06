clc
close all
clear

%% Initializing Images

% Dan1 = imread('deal1.jpg'); %Dan stand
% Dan2 = imread('deal2.jpg'); %Dan covering chair
stool1 = imread('stool1.jpg'); 
% stool2 = imread('stool2.jpg');
% stool3 = imread('stool3.jpg');
sit1 = imread('Snoopsit1.jpg');
% sit2 = imread('Snoopsit2.jpg');
% sit3 = imread('Snoopsit3.jpg');

%% ROI Stuff 
% SubDan1 = imsubtract(Dan1, Dan2);
% imshow(F1) 
% SubDan2 = imsubtract(Dan2, Dan1);
% BW1 = roipoly(Dan1);
% grayImage = 255*uint8(BW1); Turn Binary Image into grayscale
% RGBDan = cat(3, grayImage, grayImage, grayImage); %Turn grayscale to RGB image
% 
% imshow(RGBDan)
% 
% BW2 = roipoly(D2);
% SubDan3 = imsubtract(RGBDan, Dan1); 
% 
% imshow (SubDan3)
% disp("DONE"); Make MatLab display DONE in Command Window after code
% reaches here
% 
BWstool1 = roipoly(stool1);

grayStool1 = 255*uint8(BWstool1);

RGBStool1 = cat(3, grayStool1, grayStool1, grayStool1); 

Substool1 = imsubtract(RGBStool1, sit1);


figure(1); imshow(Substool1);


%% Start New Stuff
%Resize the Image

%sstool1 = imresize(sstool1,[256 256]);
% 
% % Display the Image
% 
% imshow(sstool1);
% 
% % Get Inputs from Mouse,Select 4 Seed Points in Image
% 
% [Col Row]=ginput(4);
% 
% c =Col;
% r =Row;
% 
% % Select polygonal region of interest
% BinaryMask = roipoly(sstool1,c,r);
% figure, imshow(BinaryMask);title('Selected Region of Interest');
% 
% %Create Buffer for ROI
% ROI=zeros(256,256);
% 
% %Create Buffer for NONROI
% NONROI=zeros(256,256);
% for i=1:256
% 
% for j=1:256
% 
% if BinaryMask(i,j)==1
% ROI(i,j)=sstool1(i,j);
% 
% else
% NONROI(i,j)=sstool1(i,j);
% end
% 
% end
% 
% end
% 
% %Display ROI and Non ROI
% figure;
% subplot(1,2,1);imshow(ROI,[]);title('ROI');
% subplot(1,2,2);imshow(NONROI,[]);title('NON ROI');

%% Edge Detection
BW1 = edge(stool1,'sobel');
BW2 = edge(stool2,'canny');
figure;
imshowpair(BW1,BW2,'montage')
title('Sobel Filter                                   Canny Filter');

%% Background Subtraction

% %Display Background and Foreground
% subplot(2,2,1);imshow(stool1);title('Background');
% subplot(2,2,2);imshow(sit1);title('Foreground');
% 
% %Convert RGB 2 HSV Color conversion
% [stool1_hsv]=round(rgb2hsv(stool1));
% [sit1_hsv]=round(rgb2hsv(sit1));
% Out = bitxor(stool1_hsv,sit1_hsv);
% 
% %Convert RGB 2 GRAY
% Out=rgb2gray(Out);
% 
% %Read Rows and Columns of the Image
% [rows columns]=size(Out);
% 
% %Convert to Binary Image
% for i=1:rows
% for j=1:columns
% 
% if Out(i,j) >0
% 
% BinaryImage(i,j)=1;
% 
% else
% 
% BinaryImage(i,j)=0;
% 
% end
% 
% end
% end
% 
% %Apply Median filter to remove Noise
% FilteredImage=medfilt2(BinaryImage,[5 5]);
% 
% %Boundary Label the Filtered Image
% [L num]=bwlabel(FilteredImage);
% 
% STATS=regionprops(L,'all');
% cc=[];
% removed=0;
% 
% %Remove the noisy regions
% for i=1:num
% dd=STATS(i).Area;
% 
% if (dd < 500)
% 
% L(L==i)=0;
% removed = removed + 1;
% num=num-1;
% 
% else
% 
% end
% 
% end
% 
% [L2 num2]=bwlabel(L);
% 
% % Trace region boundaries in a binary image.
% 
% [B,L,N,A] = bwboundaries(L2);
% 
% %Display results
% 
% subplot(2,2,3),  imshow(L2);title('BackGround Detected');
% subplot(2,2,4),  imshow(L2);title('Blob Detected');
% 
% hold on;
% 
% for k=1:length(B),
% 
% if(~sum(A(k,:)))
% boundary = B{k};
% plot(boundary(:,2), boundary(:,1), 'r','LineWidth',2);
% 
% for l=find(A(:,k))'
% boundary = B{l};
% plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
% end
% 
% end
% 
% end

%% Another Working Card Dectection 



%For TEST IMAGE

imshow(J)
    [B,L] = bwboundaries(J, 'noholes');

    figure; imshow(J); hold on;

    for k = 1;length(B),
        boundary = B{k};
        plot(boundary(:,2),boundary(:,1),'g','LineWidth',2);
end