% read the files
load('w6_1x.mat');

K = 2; % number of prototypes
eta = 0.001; % learning rate
t_max = 20;

close all;

% e = VQ_epochs(w6_1x, K, eta, t_max);

etas = 0.0001: 0.001: 0.1;
errors = zeros(1, numel(etas));

for e=1:numel(etas)
    errors(e) = VQ_epochs(w6_1x, K, etas(e), t_max);
end

plot(etas, errors);
title(sprintf('Quantization error vs \\eta , k = %d, t_{max} = %d', K, t_max));
xlabel('\eta');
ylabel('H_{VQ}');
set(gca, 'fontsize', 9.5, 'fontname', 'Times New Roman');