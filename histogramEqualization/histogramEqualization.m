clc;
clear all;
close all;

% Load image
[file, path] = uigetfile({'*.jpg;*.png;*.bmp', 'Image Files (*.jpg, *.png, *.bmp)'});
if isequal(file, 0)
    error('No file selected');
end
img = imread(fullfile(path, file));
gray_img = rgb2gray(img); % Convert to grayscale
[m, n] = size(gray_img);

% Compute counts (original histogram)
img_array = double(gray_img(:));
counts_original = histcounts(img_array, 0:256);

% Histogram Equalization
cdf = cumsum(counts_original); % Compute cumulative distribution
cdf_min = min(cdf(cdf > 0));   % Minimum non-zero CDF value
L = 256;                       % Intensity levels
h_v = round(((cdf - cdf_min) / ((m * n) - cdf_min)) * (L)); % Mapping function
disp("max(cdf) = " + max(cdf)); % Display maximum CDF value

% Map pixel values
equalized_img = h_v(gray_img + 1); % h_v uses 1-based indexing
counts_equalized = histcounts(equalized_img(:), 0:256); % Equalized histogram

% Plot results
figure;

% Subplot 1: Original Image
subplot(2, 2, 1);
imshow(gray_img);
title('Original Image');

% Subplot 2: Equalized Image
subplot(2, 2, 2);
imshow(uint8(equalized_img));
title('Equalized Image');

% Subplot 3: Original Histogram
subplot(2, 2, 3);
bar(0:255, counts_original, 'FaceColor', 'blue', 'EdgeColor', 'none');
title('Original Histogram');
ylabel('Count');
xlabel('Pixel Intensity');
xlim([0, 255]);

% Subplot 4: Equalized Histogram
subplot(2, 2, 4);
bar(0:255, counts_equalized, 'FaceColor', 'red', 'EdgeColor', 'none');
title('Equalized Histogram');
ylabel('Count');
xlabel('Pixel Intensity');
xlim([0, 255]);
