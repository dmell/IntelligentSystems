function [] = LVQ (dataset, K, eta, t_max, smart_init)

number_of_classes = 2;
P = size(dataset, 1); % number of samples
% dimension of input vector, the last value is used as class specifier
N = size(dataset, 2) - 1;
% K is the number of prototypes per class, so this is the total number of
% prototypes
num_protos = K*number_of_classes;

protos = zeros(num_protos, N+1);

if (smart_init)
    % class conditional mean vectors
    class_mean = zeros(number_of_classes, N+1);
    class_mean(1, :) = [mean(dataset(1:50, 1:2)), 1];
    class_mean(2, :) = [mean(dataset(51:100, 1:2)), 2];
    indexProto = 1;
    for i = 1:number_of_classes
        for j = 1:K
            protos(indexProto, :) = class_mean(i, :);
            indexProto = indexProto + 1;
        end
    end
else            
    % randomly pick prototypes, K per class
    indices = randperm(50);
    indexProto = 1;
    for i = 1:number_of_classes
        for j = 1:K
            protos(indexProto, :) = dataset(indices(j) + ((i-1)*50), :);
            indexProto = indexProto + 1;
        end
    end
end

%fprintf("Proto1: (%f, %f), Proto2: (%f, %f)\n", protos(1, 1), protos(1, 2), protos(2, 1), protos(2, 2));

% initial random permutation of the data set
dataset = dataset(randperm(P),:);

% training error for every epoch
E = zeros(1, t_max);

initial_error = 0;
% for every sample
for i=1:P
    sample_class = dataset(i, 3);
    bestDistance = Inf;

    % for all prototypes, find the winner
    for j=1:num_protos
        % simple Euclidean distance
        distance = pdist([dataset(i, 1:N); protos(j, 1:N)]);

        if (distance < bestDistance)
            bestDistance = distance;
            winner_index = j;
            winner_class = protos(j, 3);
        end
    end

    % the winner is of the same class, I move it closer
    if (winner_class ~= sample_class)
        initial_error = initial_error + 1;
    end
end

fprintf("Initial error: %d\n", initial_error);

% for every prototype, in every epoch we save the position
trace = zeros(num_protos, t_max + 1, N);

for indexProto=1:num_protos
    % initial positions of prototypes
   trace(indexProto, 1, :) = protos(indexProto, 1:2);
end

% for every epoch
for t=1:t_max
    % random permutation of the dataset
    dataset = dataset(randperm(P),:);

    % for every sample
    for i=1:P
        sample_class = dataset(i, 3);
        bestDistance = Inf;
        
        % for all prototypes, find the winner
        for j=1:num_protos
            % simple Euclidean distance
            distance = pdist([dataset(i, 1:N); protos(j, 1:N)]);
            
            if (distance < bestDistance)
                bestDistance = distance;
                winner_index = j;
                winner_class = protos(j, 3);
            end
        end
        
        % the winner is of the same class, I move it closer
        if (winner_class == sample_class)
            psi = 1;
        else
            % the winner is of a different class, I move it away and I
            % update the error
            psi = -1;
            E(t) = E(t) + 1;
        end
        
        protos(winner_index, 1:N) = protos(winner_index, 1:N) + psi * ...
            eta * (dataset(i,1:N) - protos(winner_index, 1:N));
    end
    
    % record the steps of each prototype
    for indexProto=1:num_protos
        trace(indexProto, t + 1, :) = protos(indexProto, 1:2);
    end
    
end

% we sort the rows to display the samples of the two classes 
dataset = sortrows(dataset, 3);
figure(1);
% class 1
p1 = scatter(dataset(1:50,1), dataset(1:50,2), 'filled', 'r');
hold on;
% class 2
p2 = scatter(dataset(51:100,1), dataset(51:100,2), 's', 'MarkerEdgeColor', 'b');
% prototypes
for indexProto = 1:num_protos
    if (protos(indexProto, 3) == 1)
        hold on;
        p3 = scatter(protos(indexProto, 1), protos(indexProto, 2), 'p', ...
            'MarkerEdgeColor', 'r', 'LineWidth', 1.8);
    end
end
for indexProto = 1:num_protos
    if (protos(indexProto, 3) == 2)
        hold on;
        p4 = scatter(protos(indexProto, 1), protos(indexProto, 2), 'p', ... 
            'MarkerEdgeColor', 'b', 'LineWidth', 1.8);
    end
end
title('Label and prototypes at the end of the training process');
xlabel('x');
ylabel('y');
set(gca, 'fontsize', 9, 'fontname', 'Times New Roman');
legend([p1(1), p2(1), p3(1), p4(1)], ...
'Class 1', 'Class 2', 'Prototypes 1', 'Prototypes 2', 'location', 'best');

figure(2);
% class 1
% scatter(dataset(1:50,1), dataset(1:50,2), '.', 'LineWidth', 2, 'MarkerEdgeColor', 'r');
class_1 = scatter(dataset(1:50,1), dataset(1:50,2), 'filled', 'r');
hold on;
% class 2
% scatter(dataset(51:100,1), dataset(51:100,2), '.', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
class_2 = scatter(dataset(51:100,1), dataset(51:100,2), 's', 'MarkerEdgeColor', 'b');
% hold on;
% scatter(protos(:, 1), protos(:, 2));
for indexProto = 1:num_protos
    positions = zeros(t_max+1, N);

    for epoch = 1:t_max+1
        positions(epoch, :) = trace(indexProto, epoch, :);
    end
    hold on;
    p = plot(positions(:, 1), positions(:, 2), '-', 'LineWidth', 1.5);
    if (protos(indexProto, 3) == 1)
        set(p, 'Color', 'r');
        hold on;
        proto_class_1 = scatter(protos(indexProto,1), protos(indexProto,2), 'p');
        set(proto_class_1, 'MarkerEdgeColor', 'r', 'LineWidth', 1.8);
    else
        set(p, 'Color', 'b');
        hold on;
        proto_class_2 = scatter(protos(indexProto,1), protos(indexProto,2), 'p');
        set(proto_class_2, 'MarkerEdgeColor', 'b', 'LineWidth', 1.8);
    end
end
title(sprintf('Trajectories of prototypes, with sample points. epochs = %d, \\eta = %.4f', t_max, eta));
xlabel('x');
ylabel('y');
set(gca, 'fontsize', 11, 'fontname', 'Times New Roman');
legend([class_1(1), class_2(1), proto_class_1(1), proto_class_2(1)], ...
'Class 1', 'Class 2', 'Prototypes 1', 'Prototypes 2', 'location', 'best');

E = E ./ 100;
figure(3);
plot(1:t_max, E);
title(sprintf('Learning curve, k = %d, \\eta = %.4f', K, eta));
xlabel('t');
ylabel('Error');
set(gca, 'fontsize', 11, 'fontname', 'Times New Roman');