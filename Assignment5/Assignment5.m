P = 3; % number of examples
% read the files
load('w6_1x.mat');
load('w6_1y.mat');
load('w6_1z.mat');

N = numel(w6_1x); % dimension of input vector

K = 4; % number of prototypes
nu = 0.1; % learning rate
t_max = 3;

