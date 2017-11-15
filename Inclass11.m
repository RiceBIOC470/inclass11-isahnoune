% Inclass11
%GB comments
1) 100
2) 100
3) 100
4) 100
overall: 100


% You can find a multilayered .tif file with some data on stem cells here:
% https://www.dropbox.com/s/83vjkkj3np4ehu3/011917-wntDose-esi017-RI_f0016.tif?dl=0

I = imread('ExampleImage.tif');
imshow(I)

figure
imhist(I)

I2 = histeq(I);
figure
imshow(I2)

figure
imhist(I2)

file1 = 'ExampleImage.tif';
reader = bfGetReader(file1);


% 1. Find out (without reading  the entire file) -  (a) the size of the image in
% x and y, (b) the number of z-slices, (c) the number of time points, and (d) the number of
% channels.

%a: x = 1024, y = 1024
%b: z-slices = 1
%c: time points = 68
%d: channels = 2

% 2. Write code which reads in all the channels from the 30th time point
% and displays them as a multicolor image.

%channel = 1-2, time = 30, zplane = 1

iplane = reader.getIndex(1-1, 1-1,30-1) + 1;
iplane2 = reader.getIndex(1-1, 2-1, 30-1) + 1;
image = bfGetPlane(reader,iplane);
image2 = bfGetPlane(reader,iplane2);

image2show = cat(3, imadjust(image),imadjust(image2),zeros(size(image)));
imshow(image2show);


% 3. Use the images from part (2). In one of the channels, the membrane is
% prominently marked. Determine the best threshold and make a binary
% mask which marks the membranes and displays this mask. 

imshow(imadjust(image));
image_bw = image > 1000;
imshow(image_bw)

% 4. Run and display both an erosion and a dilation on your mask from part
% (3) with a structuring element which is a disk of radius 3. Explain the
% results.

imshow(imerode(image_bw,strel('disk',3)));

%By definition, erosion involves taking the minimum values of all the
%pixels in the input pixel surroundings. In this image, the structures
%virtually disappeared, since the black surroundings were zero and so the
%sum of surrounding pixels yielded outputs of zero.

imshow(imdilate(image_bw,strel('disk',3)));

%Dilation is the opposite of erosion, in that the output is the maximum
%values of all the pixels in the input pixel surroundings. In this image
%display, the structures were much more emphasized and outlined.
