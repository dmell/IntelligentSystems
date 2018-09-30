% What we have to calculate is: knowing that x is the length of the fish,
% give me the probability of that fish to be a seabass (salmon).
% The data we have is: given that this fish is a seabass, p_seabass(i) gives
% the percentage of seabass that have length i.

load('lab_week3_data/lab3_1.mat');
N = numel(p_salmon);
% "Given that sea bass is caught 3 times as often as salmon"
prior_salmon = 0.25;
prior_seabass = 0.75;

posterior_salmon = zeros(N);
posterior_seabass = zeros(N);

for i=1:N
    % evidence
    p_x = p_salmon(i) * prior_salmon + p_seabass(i) * prior_seabass;
    % Bayes formula for both sets
    posterior_salmon(i) = (p_salmon(i) * prior_salmon)/p_x;
    posterior_seabass(i) = (p_seabass(i) * prior_seabass)/p_x;
end

p1 = plot(l, posterior_salmon, 'color', 'r');
hold on;
p2 = plot(l, posterior_seabass, 'color', 'b');
legend([p1(1), p2(1)], 'P(salmon | x)', 'P(seabass | x)');
title('Posterior probabilities');
xlabel('Length (cm)');
ylabel('Probability');
set(gca, 'fontsize', 8.5, 'fontname', 'Times New Roman');

if (posterior_seabass(8) > posterior_salmon(8))
    fprintf(['The fish with length 8 cm can be classified as a seabass, ', ...
        'with a probability of %f\n'], posterior_seabass(8));
else
    fprintf(['The fish with length 8 cm can be classified as a salmon, ', ...
        'with a probability of %f\n'], posterior_salmon(8));
end

if (posterior_seabass(20) > posterior_salmon(20))
    fprintf(['The fish with length 20 cm can be classified as a seabass, ', ...
        'with a probability of %f\n'], posterior_seabass(20));
else
    fprintf(['The fish with length 20 cm can be classified as a salmon, ', ...
        'with a probability of %f\n'], posterior_salmon(20));
end