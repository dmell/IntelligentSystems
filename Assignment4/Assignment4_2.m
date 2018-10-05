load('lab_4_data/dataAEX.mat');
load('lab_4_data/labelsAEX.mat');

% euclidean (default) distances between the time series
distances = pdist(data);
% to visualize better the matrix
distance_matrix = squareform(distances);

% to create a hierarchical binary cluster tree
tree = linkage(distances);
% to compute the best order of leaves
leafOrder = optimalleaforder(tree, distances);

% we use introduce the labels in the plot
[H,T] = dendrogram(tree, 'Reorder', leafOrder, 'Labels', labels, 'Orientation', 'right');