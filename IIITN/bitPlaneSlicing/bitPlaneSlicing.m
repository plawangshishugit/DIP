% Bit Plane Slicing for 8-bit Image
clc
close all;
clear all;
% Read the grayscale image
image = imread('poseinmumbai.jpg'); % Replace 'input_image.png' with your image file name
if size(image, 3) == 3
    image = rgb2gray(image); % Convert to grayscale if the image is RGB
end

% Get the dimensions of the image
[rows, cols] = size(image);

% Initialize a cell array to store bit planes
bit_planes = cell(1, 8);

% Loop through each bit plane
for bit = 1:8
    % Extract the bit plane using bitwise operations
    bit_planes{bit} = bitget(image, bit);
end

% Display the original image
figure;
subplot(3, 3, 1);
imshow(image, []);
title('Original Image');

% Display each bit plane
for bit = 1:8
    subplot(3, 3, bit + 1);
    imshow(logical(bit_planes{bit}));
    title(['Bit Plane ', num2str(bit)]);
end

% Optional: Save individual bit planes as images
for bit = 1:8
    filename = sprintf('pose_plane_%d.png', bit);
    imwrite(logical(bit_planes{bit}), filename);
end