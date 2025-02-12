clc;
clear all;
close all;

% Load the indexed GIF image
[img, map] = imread('digital_images_week2_quizzes_lena.gif');

% Convert indexed image to grayscale manually
img_gray = uint8(img(:,:,1)); % Extract first channel (since GIF is indexed)

% Convert to double for processing
img_double = double(img_gray);  

% Define a 5×5 Low-pass filter
lp_filter = ones(5,5) / 25; 

% Apply low-pass filter manually using convolution
filtered_img = conv2(img_double, lp_filter, 'same'); 

% Compute Mean Squared Error (MSE)
mse = mean((img_double - filtered_img).^2, 'all'); 

% Compute Peak Signal-to-Noise Ratio (PSNR)
psnr_value = 10 * log10((255^2) / mse); 

% Display PSNR value
fprintf('PSNR: %.2f\n', psnr_value);
