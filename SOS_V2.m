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
% BWstool1 = roipoly(stool1);
% BWstool2 = roipoly(stool2);
% BWstool3    = roipoly(stool3);
% 
% grayStool1 = 255*uint8(BWstool1);
% grayStool2 = 255*uint8(BWstool2);
% grayStool3 = 255*uint8(BWstool3);
% 
% RGBStool1 = cat(3, grayStool1, grayStool1, grayStool1); 
% RGBStool2 = cat(3, grayStool2, grayStool2, grayStool2);
% RGBStool3 = cat(3, grayStool3, grayStool3, grayStool3);
% 
% Substool1 = imsubtract(RGBStool1, sit1);
% Substool1_2 = imsubtract(RGBStool2, sit1); 
% Substool1_3 = imsubtract(RGBStool3, sit1);
% 
% Substool2 = imsubtract(RGBStool1, sit2);
% Substool2_2 = imsubtract(RGBStool2, sit2);
% Substool2_3 = imsubtract(RGBStool3, sit2);
% 
% Substool3 = imsubtract(RGBStool1, sit3);
% Substool3_2 = imsubtract(RGBStool2, sit3);
% Substool3_3 = imsubtract(RGBStool3, sit3);
% 
% figure(1); imshow(Substool1);
% figure(4); imshow(RGBStool1);
% figure(5); imshow(sit1);
% figure(2); imshow(BWcr);
% figure(7); imshow(stool1);
% 
% figure(12); imshow(Substool1_2);
% figure(13); imshow(Substool1_3);
% 
% figure(2); imshow(Substool2);
% figure(22); imshow(Substool2_2);
% figure(23); imshow(Substool2_3);
% 
% figure(3); imshow(Substool3);
% figure(32); imshow(Substool3_2);
% figure(33); imshow(Substool3_3);

%Resize the Image

sstool1=imresize(sstool1,[256 256]);

% Display the Image

imshow(sstool1);

% Get Inputs from Mouse,Select 4 Seed Points in Image

[Col Row]=ginput(4);

c =Col;
r =Row;

% Select polygonal region of interest
BinaryMask = roipoly(sstool1,c,r);
figure, imshow(BinaryMask);title('Selected Region of Interest');

%Create Buffer for ROI
ROI=zeros(256,256);

%Create Buffer for NONROI
NONROI=zeros(256,256);
for i=1:256

for j=1:256

if BinaryMask(i,j)==1
ROI(i,j)=sstool1(i,j);

else
NONROI(i,j)=sstool1(i,j);
end

end

end

%Display ROI and Non ROI
figure;
subplot(1,2,1);imshow(ROI,[]);title('ROI');
subplot(1,2,2);imshow(NONROI,[]);title('NON ROI');

%% Edge Detection
% BW1 = edge(stool1,'sobel');
% BW2 = edge(stool2,'canny');
% figure;
% imshowpair(BW1,BW2,'montage')
% title('Sobel Filter                                   Canny Filter');

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