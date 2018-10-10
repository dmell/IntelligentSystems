function vq = VQ (dataset, K, nu, t_max);

% initial random permutation of the data set to get the prototypes
dataset = dataset(randperm(size(dataset,1)),:);
proto = dataset(1:K, :);

% for every epoch
for t=1:t_max
    % random permutation of the dataset
    dataset = dataset(randperm(size(dataset,1)),:);
    
    % for all elements
    for i=1:size(dataset, 1)
        % for all prototypes, find the closest
        best = Inf;
        winner = zeros(2);
        for j=1:K
            % euclidean distance
            current = (dataset(i, 1) - proto(j, 1))^2 + (dataset(i, 2) - proto(j, 2))^2;
            if (current < best)
                best = current;
                winner = proto(j, :);
            end
        end
        
        % update the winner position
        winner(1) = winner(1) + nu*(dataset(i,1)-winner(1));
        winner(2) = winner(2) + nu*(dataset(i,2)-winner(2));
    end
    
end

scatter(dataset(:,1), dataset(:,2), '.');
hold on;
scatter(proto(:, 1), proto(:, 2));
