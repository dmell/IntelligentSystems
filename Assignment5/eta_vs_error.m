% read the files
load('w6_1x.mat');

K = 2; % number of prototypes
etas = 0.0001: 0.001: 0.1; % learning rates
t_max = 20; % number of epochs
errors = zeros(1, numel(etas));

close all;

for eta = etas
    errors(e) = VQ_epochs(w6_1x, K, eta, t_max);
end

plot(etas, errors);
title(sprintf('Quantization error vs \\eta , k = %d, t_{max} = %d', K, t_max));
xlabel('\eta');
ylabel('H_{VQ}');
set(gca, 'fontsize', 9.5, 'fontname', 'Times New Roman');
