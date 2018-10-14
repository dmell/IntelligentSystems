% read the files
load('w6_1x.mat');

K = [2 4]; % number of prototypes
eta = [0.1 0.01 0.001]; % learning rates
t_max = 30; % number of epochs

close all;

for k = K
	for rate = eta
		VQ_epochs(w6_1x, k, rate, t_max);
	end
end
