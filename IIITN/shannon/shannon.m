clc;
clear all;
close all;



% Example usage:
symbols = {'A', 'B', 'C', 'D', 'E'};
probabilities = [0.4, 0.3, 0.2, 0.07, 0.03];
code_dict = shannon_fano(symbols, probabilities);

% Print Shannon-Fano codes
keys = code_dict.keys();
for i = 1:length(keys)
    fprintf('%s: %s\n', keys{i}, code_dict(keys{i}));
end

function code_dict = shannon_fano(symbols, probabilities, prefix)
    if nargin < 3
        prefix = "";
    end
    
    if length(symbols) == 1
        code_dict = containers.Map(symbols, {prefix});
        return;
    end
    
    % Sort symbols by probability (descending order)
    [probabilities, idx] = sort(probabilities, 'descend');
    symbols = symbols(idx);
    
    % Find partition index
    total_prob = sum(probabilities);
    cumulative_prob = 0;
    split_index = 0;
    for i = 1:length(probabilities)
        cumulative_prob = cumulative_prob + probabilities(i);
        if cumulative_prob >= total_prob / 2
            split_index = i;
            break;
        end
    end
    
    % Recursive Shannon-Fano encoding
    left_dict = shannon_fano(symbols(1:split_index), probabilities(1:split_index), strcat(prefix, "0"));
    right_dict = shannon_fano(symbols(split_index+1:end), probabilities(split_index+1:end), strcat(prefix, "1"));
    
    % Merge dictionaries
    code_dict = [left_dict; right_dict];
end
