function [] = LVQ (dataset, K, eta, t_max)

number_of_classes = 2;
P = size(dataset, 1); % number of samples
% dimension of input vector, the last value is used as class specifier
N = size(dataset, 2) - 1;
% K is the number of prototypes per class, so this is the total number of
% prototypes
num_protos = K*number_of_classes;

% randomly pick prototypes, K per class
protos = zeros(num_protos, N+1);
indices = randperm(50);
indexProto = 1;
for i = 1:number_of_classes
    for j = 1:K
        protos(indexProto, :) = dataset(indices(j) + ((i-1)*50), :);
        indexProto = indexProto + 1;
    end
end


% initial random permutation of the data set
dataset = dataset(randperm(P),:);

% training error for every epoch
E = zeros(1, t_max);

% for every prototype, in every epoch we save the position
trace = zeros(num_protos, t_max + 1, N);

for indexProto=1:num_protos
   trace(indexProto, 1, :) = protos(indexProto, 1:2);
end

% for every epoch
for t=1:t_max
    % random permutation of the dataset
    dataset = dataset(randperm(P),:);

    for i=1:P
        sample_class = dataset(i, 3);
        bestSameClassDistance = Inf;
        bestDifferentClassDistance = Inf;
        
        % for all prototypes, find the closest from the same class and from
        % the other class
        for j=1:num_protos
            proto_class = protos(j, 3);
            % simple Euclidean distance
            distance = pdist([dataset(i, 1:N); protos(j, 1:N)]);
            
            if (sample_class == proto_class)
                if (distance < bestSameClassDistance)
                    bestSameClassDistance = distance;
                    bestSameClassIndex = j;
                end
            else
                if (distance < bestDifferentClassDistance)
                    bestDifferentClassDistance = distance;
                    bestDifferentClassIndex = j;
                end
            end
        end
        
        % the winner is of the same class, I move it closer
        if (bestSameClassDistance < bestDifferentClassDistance)
            psi = 1;
            winnerIndex = bestSameClassIndex;
        else
            % the winner is of a different class, I move it away and I
            % update the error
            psi = -1;
            E(t) = E(t) + 1;
            winnerIndex = bestDifferentClassIndex;
        end
        
        protos(winnerIndex, 1:N) = protos(winnerIndex, 1:N) + psi * eta * (dataset(i,1:N) - protos(winnerIndex, 1:N));
    end
    
    for indexProto=1:num_protos
        trace(indexProto, t + 1, :) = protos(indexProto, 1:2);
    end
    
end

% we sort the rows to display the samples of the two classes
dataset = sortrows(dataset, 3);
figure(1);
% class 1
% scatter(dataset(1:50,1), dataset(1:50,2), '.', 'LineWidth', 2, 'MarkerEdgeColor', 'r');
scatter(dataset(1:50,1), dataset(1:50,2), 'filled', 'k');
hold on;
% class 2
% scatter(dataset(51:100,1), dataset(51:100,2), '.', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
scatter(dataset(51:100,1), dataset(51:100,2), 'MarkerEdgeColor', 'k');
hold on;
scatter(protos(:, 1), protos(:, 2));
for indexProto = 1:num_protos
    positions = zeros(t_max+1, N);

    for epoch = 1:t_max+1
        positions(epoch, :) = trace(indexProto, epoch, :);
    end
    hold on;
    p = plot(positions(:, 1), positions(:, 2), '-', 'LineWidth', 2);
    if (protos(indexProto, 3) == 1)
        set(p, 'Color', 'r');
    else
        set(p, 'Color', 'b');
    end
    hold on;
    s = scatter(protos(indexProto,1), protos(indexProto,2));
    set(s, 'MarkerEdgeColor', get(p, 'Color'), 'LineWidth', 2);
    title(sprintf('Trajectories of prototypes, with sample points k = %d, \\eta = %.4f', K, eta));
    xlabel('x');
    ylabel('y');
    set(gca, 'fontsize', 9, 'fontname', 'Times New Roman');
end

E = E ./ 100;

figure(2);
plot(1:t_max, E);
title(sprintf('Learning curve, k = %d, \\eta = %.4f', K, eta));
xlabel('t');
ylabel('Error');
set(gca, 'fontsize', 13, 'fontname', 'Times New Roman');
