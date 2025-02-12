clc;
clear all;
close all;
% Step 1: Load and convert the image
originalImage = imread('digital_images_week3_quizzes_original_quiz.jpg'); % Load the image
originalImage = double(originalImage) / 255; % Convert to double and normalize to [0, 1]

% Step 2: Low-pass filtering
% Create a 3x3 low-pass filter with all coefficients equal to 1/9
lowPassFilter = (1/9) * ones(3);

% Apply the low-pass filter using convolution
filteredImage = conv2(originalImage, lowPassFilter, 'same');

% Step 3: Down-sampling the image
% Remove every other row and column
downSampledImage = filteredImage(1:2:end, 1:2:end);

% Step 4: Up-sampling the image
% Create an all-zero array of the original size
upSampledImage = zeros(size(originalImage));

% Insert the down-sampled image values into the appropriate positions
upSampledImage(1:2:end, 1:2:end) = downSampledImage;

% Step 5: Bilinear interpolation
% Define the bilinear interpolation filter
bilinearFilter = [0.25, 0.5, 0.25; 0.5, 1, 0.5; 0.25, 0.5, 0.25];

% Apply the bilinear interpolation filter using convolution
interpolatedImage = conv2(upSampledImage, bilinearFilter, 'same');

% Step 6: Compute the PSNR manually
% PSNR formula: PSNR = 10 * log10(MAX^2 / MSE)
% MAX is the maximum possible pixel value (1 for normalized images)
% MSE is the mean squared error between the original and interpolated images
MAX = 1; % Since the image is normalized
MSE = mean((originalImage(:) - interpolatedImage(:)).^2); % Mean squared error
PSNR = 10 * log10(MAX^2 / MSE); % PSNR in decibels

% Display the PSNR value to two decimal points
fprintf('PSNR: %.2f dB\n', PSNR);