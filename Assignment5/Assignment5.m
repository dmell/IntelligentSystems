% read the files
load('w6_1x.mat');

K = 2; % number of prototypes
nu = 0.001; % learning rate
t_max = 30;

close all;

VQ_epochs(w6_1x, 4, 0.01, t_max);