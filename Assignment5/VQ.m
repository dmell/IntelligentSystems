function [] = VQ (dataset, K, eta, t_max)

P = size(dataset, 1); % number of samples
N = size(dataset, 2); % dimension of input vector

% initial random permutation of the data set to get the prototypes
dataset = dataset(randperm(P),:);
proto = dataset(1:K, :);

% quantization error for every epoch
H_VQ = zeros(1, t_max);

% for every element we save the winner prototype
dataWinner = zeros(1, P);

% for every prototype, in every epoch, for every iteration we save the
% position
trace = zeros(K, t_max+1, P, N);

for indexProto=1:K
    for point=1:P
        trace(indexProto, 1, point, :) = proto(indexProto, :);
    end
end

% for every epoch
for t=1:t_max
    % random permutation of the dataset
    dataset = dataset(randperm(P),:);
    
    % for all elements
    for i=1:P
        best = Inf;
        winner = zeros(1, N);
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
        winner = winner + eta * (dataset(i,:) - winner);
        proto(index, :) = winner;
        
        for indexProto=1:K
            trace(indexProto, t+1, i, :) = proto(indexProto, :);
        end

        dataWinner(i) = index;
    end
    
    % quantization error calculation
    for i=1:P
        H_VQ(t) = H_VQ(t) + pdist([dataset(i, :); proto(dataWinner(i), :)], 'squaredeuclidean');
    end
end

figure(1);
scatter(dataset(:,1), dataset(:,2), '.');
hold on;
scatter(proto(:, 1), proto(:, 2));
for indexProto = 1:K
    positions = zeros((t_max+1)*P, N);
    
    for epoch = 1:t_max
        for point = 1:P
            positions((epoch-1)*P+point, :) = trace(indexProto, epoch, point, :);
        end
    end
    hold on;
    plot(positions(:, 1), positions(:, 2), '-');
end

figure(2);
plot(1:t_max, H_VQ);
title(sprintf('Learning curve, k = %d, \\eta = %.4f', K, eta));
xlabel('t');
ylabel('H_{VQ}');
set(gca, 'fontsize', 9.5, 'fontname', 'Times New Roman');