% read the files
load('w6_1x.mat');

dataset = w6_1x(1:200, :);
K = 2; % number of prototypes
nu = 0.1; % learning rate
t_max = 5;


P = size(dataset,1); % number of samples
N = size(dataset, 2); % dimension of input vector

% initial random permutation of the data set to get the prototypes
dataset = dataset(randperm(P),:);
proto = dataset(1:K, :);

% quantization error for every epoch
H_VQ = zeros(t_max);

% for every element we save the winner prototype
dataWinner = zeros(P);

% for every epoch
for t=1:t_max
    % random permutation of the dataset
    dataset = dataset(randperm(P),:);
    
    % for all elements
    for i=1:P
        best = Inf;
        winner = zeros(N);
        index = 1;
        % for all prototypes, find the closest
        for j=1:K
            % euclidean distance
            current = pdist([dataset(i, :);proto(j, :)], 'squaredeuclidean');
            if (current < best)
                best = current;
                winner = proto(j, :);
                index = j;
            end
        end
        
        % update the winner position
        winner = winner + nu * (dataset(i,:) - winner);
        %winner(1) = winner(1) + nu*(dataset(i,1)-winner(1));
        %winner(2) = winner(2) + nu*(dataset(i,2)-winner(2));
        proto(index, :) = winner;
        
        dataWinner(i) = index;
    end
    
    % quantization error calculation
    for i=1:P
        H_VQ(t) = H_VQ(t) + pdist([dataset(i, :); proto(dataWinner(i), :)], 'squaredeuclidean');
    end
    
    style = [[255 0 0] [0 0 255]];
    figure(t);
    for i=1:P
        scatter(dataset(:,1), dataset(:,2), '.', style(dataWinner(i)));
        hold on;
    end
    scatter(proto(:, 1), proto(:, 2));
end