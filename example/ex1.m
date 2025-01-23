clc
clear all;
close all;
I = imread('f14.tif');
imshow(I)
whos



% Compute the histogram using the custom function
[counts, binLocations] = imhist_custom(I);

% Plot the histogram
figure;
bar(binLocations, counts);
xlabel('Intensity Values');
ylabel('Pixel Count');
title('Custom Histogram of original image');

J = histeq_custom(I); % Default number of bins (256)
[counts_eq, binLocations_eq] = imhist_custom(J);
% Plot the histogram
figure;
bar(binLocations_eq, counts_eq);
xlabel('Intensity Values');
ylabel('Pixel Count');
title('Custom Histogram of equalized image');

figure;
imshow(J)

