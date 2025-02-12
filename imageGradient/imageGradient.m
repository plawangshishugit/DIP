img=imread('image.png');
% Read the image


% Display the original image
figure;
imshow(img);
title('Original Image');

% Compute Gx and Gy using imgradientxy
[Gx, Gy] = imgradientxy(img, 'sobel');

% Compute Gmag and Gdir using imgradient
[Gmag, Gdir] = imgradient(Gx, Gy);

% Display the gradient magnitude
figure;
imshow(Gmag, []);
title('Gradient Magnitude (Gmag)');

% Display the gradient direction
figure;
imshow(Gdir, []);
title('Gradient Direction (Gdir)');


 
