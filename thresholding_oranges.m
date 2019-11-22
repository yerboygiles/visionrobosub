%%Morphological Processing
%Threshold along with image (oranges1)
%Dilation and Erosion
%% 
clear; close all;

% % 1. Read an image (oranges)
im = imread('oranges1.bmp'); %oranges1.bmp(300x400): let's change the image to oranges-leaves.jpg (RGB) or oranges-mandarin1.jfif
figure%(1)
imagesc(im)

threshold_simple=256/2;
imth1 = im > threshold_simple;
figure  %% (2)
imagesc(imth1)
colormap(gray)
title('binary image by threshold simple ')


%Threshold: find an appropriate thresholding value; average of pixel values
threshold_avg = sum(sum(im, 1),2)/prod(size(im))%110.4; =13244729/120000;
%sum of all pixel (intensity) values divided by all pixel #s
imth2 = im > threshold_avg;
figure  %% (3)
imagesc(imth2)
colormap(gray)
title('binary image by threshold average')



figure%(4)
h=histogram(im)                 % boundary value = 111 !!!
xy = [(1:h.NumBins)' h.Values'];
maxx = max(h.Values)

count1 = 0;
count2 = 0;
sum1 = 0;
sum2 = 0;

% sum of pixels 
for i = 1:size(im, 1)
    for j = 1:size(im, 2)
        if (im(i,j)<threshold_simple)
            count1 = count1 + 1;    %% 75757
            sum1 = sum1 + double(im(i, j)); %% 6472650
        else
            count2 = count2 + 1;    %% 44243
            sum2 = sum2 + double(im(i, j)); %% 6772079
        end
    end
end

thresholdnew = (sum1/count1 + sum2/count2)/2    %% 119.25

fprintf('%4.1f\n', thresholdnew)

% To make a binary image based on threshold value;

imth3 = im > thresholdnew;

figure  %% (5)
imagesc(imth3)
colormap(gray)
title('binary image by threshold mean2')



imth3 = im<thresholdnew;
figure  %% (6)
imagesc(imth3)
colormap(gray)
title('opposite binary image by thresholding')

%% End