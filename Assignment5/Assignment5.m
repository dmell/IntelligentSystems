% read the files
load('w6_1x.mat');

K = 2; % number of prototypes
nu = 0.001; % learning rate
t_max = 50;

VQ(w6_1x, K, nu, t_max);