function [error] = VQ_epochs (dataset, K, eta, t_max)

P = size(dataset, 1); % number of samples
N = size(dataset, 2); % dimension of input vector

% initial random permutation of the data set to get the prototypes
% dataset = dataset(randperm(P),:);
proto = dataset(1:K, :);
proto(1, :) = dataset(2, :);
proto(2, :) = dataset(560, :);

% quantization error for every epoch
H_VQ = zeros(1, t_max);

% for every element we save the winner prototype
dataWinner = zeros(1, P);

% for every prototype, in every epoch, for every iteration we save the
% position
trace = zeros(K, t_max + 1, N);

for indexProto=1:K
    trace(indexProto, 1, :) = proto(indexProto, :);
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
        
        dataWinner(i) = index;
    end
    
    for indexProto=1:K
        trace(indexProto, t + 1, :) = proto(indexProto, :);
    end
    
    % quantization error calculation
    for i=1:P
        H_VQ(t) = H_VQ(t) + pdist([dataset(i, :); proto(dataWinner(i), :)], 'squaredeuclidean');
    end
end

% we return the quantization error of the last epoch
error = H_VQ(t_max);

% figure(1);
% scatter(dataset(:,1), dataset(:,2), '.', 'LineWidth', 1.5);
% hold on;
% scatter(proto(:, 1), proto(:, 2));
% for indexProto = 1:K
%     positions = zeros(t_max+1, N);
%     
%     for epoch = 1:t_max+1
%         positions(epoch, :) = trace(indexProto, epoch, :);
%     end
%     hold on;
%     p = plot(positions(:, 1), positions(:, 2), '-', 'LineWidth', 2);
%     hold on;
%     s = scatter(proto(indexProto,1), proto(indexProto,2));
%     set(s, 'MarkerEdgeColor', get(p, 'Color'), 'LineWidth', 2);
%     title(sprintf('Trajectories of prototypes, with sample points k = %d, \\eta = %.4f', K, eta));
%     xlabel('x');
%     ylabel('y');
%     set(gca, 'fontsize', 9, 'fontname', 'Times New Roman');
% end
% 
figure(2);
plot(1:t_max, H_VQ);
title(sprintf('Learning curve, k = %d, \\eta = %.4f', K, eta));
xlabel('t');
ylabel('H_{VQ}');
set(gca, 'fontsize', 13, 'fontname', 'Times New Roman');