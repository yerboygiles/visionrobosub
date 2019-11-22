%%To test Erosion and Dilation for VIP persons (Video and Image Processing)
%Digital Image Processing - Morphological Processing

%% 
clear all; close all;

%%1.Create an 8x8 original image (pixel)-evaluate MATLAB code below and see the figure (Morphological Op)
%%Erosion: an approach to operate erosion on the original image(pixel matrix)

imth = [zeros(1,8); zeros(1,8); zeros(1,3),ones(1,3), zeros(1,2); zeros(2,2), ones(2,4), ones(2,1), zeros(2,1);zeros(1,2), ones(1,4), zeros(1,2);zeros(2,3), [ones(1,2);zeros(1,2)], zeros(2,3)]
figure%(1) let's see it as an scaled (8bit) gray image
imagesc(imth)
colormap(gray)
title('an original image without any morphological processing')


%% I. Opening (two processes combined; erosion and then dilation)
%create 4 images from an original image (imth); shift to the left (erodeR; 
%shift one column to the left and fill 0 to the last col on the right)
% assume the image has size of nxm; n (# of rows) by m (# of col) dimension

erodeR = [imth(:, 2:end), zeros(size(imth,1),1)] %shift to the left for "2nd to last col of all rows", imth(:, 2:end) and erode right by "adding mx1 column vector to the righ", zeros(size(imth,1),1); 
erodeL = [zeros(size(imth,1),1), imth(:,1:end-1)]%erode Left by "adding nx1 zero vector to the left", zeros(size(imth,1),1) and shift "first col to (m-1) col of all rows" to the right, imth(:,1:end-1)
erodeU = [zeros(1,size(imth,2));imth(1:end-1,:)] %erode Up; shift to the bottom
erodeD = [imth(2:end,:); zeros(1,size(imth,2))]  %erode Down; shift to the top

% new imth: intersection (AND) of the above four eroded matrices 
erodimth = imth & erodeR & erodeL & erodeU & erodeD %any 0 at a pixel in 4 images, the output pixel is zero(0)

figure%(2) %automatically, assign the figure #, but I want to know # in the code
imagesc(erodimth)
colormap(gray)
title('new (eroded) image using erosion')

%% followed by Dilation: based on new imth (erodimth)
%shift Left/Right/Down/Up again

dilateR = [erodimth(:,2:end),zeros(size(erodimth,1),1)]
dilateL = [zeros(size(erodimth,1),1), erodimth(:,1:end-1)] 
dilateU = [zeros(1,size(erodimth,2));erodimth(1:end-1,:)] 
dilateD = [erodimth(2:end,:); zeros(1,size(erodimth,2))]

% any pixel has 1 at a pixel among four above images, the ouput pixel is 1
openimth = (erodimth | dilateL | dilateR | dilateU | dilateD) % or, union

figure%(3)
imagesc(openimth)
colormap(gray)
title('Opening: dilation after erosion process') %see word file for the plot

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Practice raises your strength; practiced enough? %%%%%%%%%%%%%%
%%%%%%%%%%%%%% Let's solve a problem below %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%II. Create a new image using "Closing" operation from the original image
clear
imth1 = [zeros(2,8); zeros(5,2), [0;ones(3,1);0], ones(5,2), [ones(4,1);0], [0;1;1;0;0],zeros(5,1);zeros(1,8)] %same to imth

%%Dilation: evaluate each process - see MATLAB command window

DilationRt = [imth1(:,2:end), zeros(size(imth1,1),1)] %
DilationLt = [zeros(size(imth1,1),1), imth1(:,1:end-1)]
DilationUp = [zeros(1, size(imth1,2)); imth1(1:end-1,:)]
DilationDn = [imth1(2:end,:); zeros(1,size(imth1,2))]

dilatedimth1 = DilationRt | DilationLt | DilationUp | DilationDn

figure%(4)
imagesc(dilatedimth1)
colormap(gray)
title('1. Dilation process for Closing operation')

%%%%%and then, your turn to create eroded image of the dilatedimth1



%% III. This utilizes image processing toolbox (requirement) and may relate to computer vision as well
%1.Opening: Morphological structuring element using 3x3 window and scan using operating algorithm
clear; close all

imth = [zeros(2,8); zeros(5,2), [0;ones(3,1);0], ones(5,2), [ones(4,1);0], [0;1;1;0;0],zeros(5,1);zeros(1,8)] %same to imth

SE = strel('square', 3)         % create a strunctural element
seo = SE.Neighborhood           % extract the 3x3 square matrix from the SE
imthopen = imopen(imth, seo) % enable opening and operate it using seq to the imth image
figure%(5)
imagesc(imthopen)
colormap(gray)
title('Opening image using 3x3 Sq strel')

%%2.Closing: Dilation followed by Erosion

SEC = strel('square', 3)        % change square to sphere, cube, diamond, cuboid, etc. and also size!
sec = SE.Neighborhood
imthclose = imclose(imth, sec)
figure%(6)
imagesc(imthclose)
colormap(gray)
title('Closing image using 3x3 Sq strel')

