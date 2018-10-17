% read the files
load('data_lvq.mat');

% K = [1 2]; % number of prototypes
% eta = [0.1 0.01 0.001]; % learning rates
K = 2;
eta = 0.002;
t_max = 200; % number of epochs

close all;

w5_1(1:50, 3) = 1;
w5_1(51:100, 3) = 2;

% for k = K
% 	for rate = eta
% 		VQ_epochs(w6_1x, k, rate, t_max);
% 	end
% end

LVQ(w5_1, K, eta, t_max);