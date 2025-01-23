function J = histeq_custom(I, numBins)
    % histeq_custom: Performs histogram equalization on a grayscale image.
    % I: Input image (grayscale)
    % numBins: Number of bins for histogram (default: 256 for 8-bit images)

    if nargin < 2
        numBins = 256; % Default number of bins
    end
    
    % Ensure the image is of type double for calculations
    I = double(I);
    
    % Normalize the intensity values to range [0, 1]
    minValue = min(I(:));
    maxValue = max(I(:));
    normalizedImage = (I - minValue) / (maxValue - minValue);
    
    % Compute the histogram
    counts = histcounts(normalizedImage(:), numBins);
    
    % Compute the cumulative distribution function (CDF)
    cdf = cumsum(counts) / numel(normalizedImage);
    
    % Map the normalized intensities using the CDF
    equalizedImage = interp1(linspace(0, 1, numBins), cdf, normalizedImage(:));
    
    % Reshape the equalized intensities back into the image size
    J = reshape(equalizedImage, size(I));
    
    % Scale the output image back to the original intensity range
    J = J * (maxValue - minValue) + minValue;
    
    % Convert the result to the same data type as the input image
    J = cast(J, 'like', I);
end
