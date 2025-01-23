function [counts, binLocations] = imhist_custom(I, numBins)
    % imhist_custom: Computes the histogram of a grayscale image.
    % I: Input image (grayscale)
    % numBins: Number of bins (default: 256 for 8-bit images)
    
    if nargin < 2
        numBins = 256; % Default number of bins for 8-bit images
    end
    
    % Ensure the image is of type double for calculation
    I = double(I);
    
    % Normalize the intensity values to range [0, 1]
    minValue = min(I(:));
    maxValue = max(I(:));
    normalizedImage = (I - minValue) / (maxValue - minValue);
    
    % Define bin edges and initialize the histogram counts
    binEdges = linspace(0, 1, numBins+1);
    counts = zeros(1, numBins);
    
    % Assign each pixel to a bin
    for i = 1:numBins
        counts(i) = sum(normalizedImage(:) >= binEdges(i) & normalizedImage(:) < binEdges(i+1));
    end
    
    % Include the maximum value in the last bin
    counts(numBins) = counts(numBins) + sum(normalizedImage(:) == binEdges(end));
    
    % Define bin locations for plotting
    binLocations = (binEdges(1:end-1) + binEdges(2:end)) / 2;
end
