load('lab_week3_data/normdist.mat');

% 2.1
figure(1);
p1 = plot(S1, 0, '-bo');
hold on;
p2 = plot(S2, 0, '-ro');
p3 = plot(T, 0, '-ks');
legend([p1(1), p2(1), p3(1)], 'S1', 'S2', 'T');
title('Elements of S1, S2 and T');
xlabel('S1, S2, T');
ylabel('  ');
set(gca, 'fontsize', 8.5, 'fontname', 'Times New Roman');

% 2.2
% maximum estimation
mean1 = mean(S1);
dev1 = std(S1);
mean2 = mean(S2);
dev2 = std(S2);

figure(2);
% x values to calculate the normal distributions
X = [-40:1:100];
% p1 = plot(X, normpdf(X, mean1, dev1), 'color', 'b');
hold on;
p2 = plot(X, normpdf(X, mean2, dev2), 'color', 'r');
p3 = plot(S1, 0, '-bo');
p4 = plot(S2, 0, '-ro');
legend([p1(1), p2(1), p3(1), p4(1)], 'p(x|\omega_1)', 'p(x|\omega_2)', ...
    'S1', 'S2','location', 'northwest');
title('Gaussian functions of S1 and S2');
xlabel('S1, S2');
ylabel('Probability');
set(gca, 'fontsize', 8.5, 'fontname', 'Times New Roman');

% 2.3
total = numel(S1) + numel(S2);
prior_S1 = numel(S1)/total;
prior_S2 = numel(S2)/total;
fprintf('The prior probability of S1 is %f\n', prior_S1);
fprintf('The prior probability of S2 is %f\n', prior_S2);

% 2.4
figure(3);
p1 = plot(X, normpdf(X, mean1, dev1)*prior_S1, 'color', 'b');
hold on;
p2 = plot(X, normpdf(X, mean2, dev2)*prior_S2, 'color', 'r');
p3 = plot(S1, 0, '-bo');
p4 = plot(S2, 0, '-ro');
p5 = plot(T, 0, '-ks');
legend([p1(1), p2(1), p3(1), p4(1), p5(1)], 'P(\omega_1)*p(x|\omega_1)', ... 
    'P(\omega_2)*p(x|\omega_2)', 'S1', 'S2', 'T');
title('Elements of S1, S2 and T');
xlabel('S1, S2, T');
ylabel('Probability');
set(gca, 'fontsize', 8.5, 'fontname', 'Times New Roman');

% 2.5
syms x
eqn = prior_S1*1/(sqrt(2*pi)*dev1)*exp(-0.5*(x-mean1)^2/dev1^2) == ...
prior_S2*1/(sqrt(2*pi)*dev2)*exp(-0.5*(x-mean2)^2/dev2^2);
solx = double(solve(eqn, x));
for i=1:numel(solx)
    fprintf('x(%i) = %f\n', i, solx(i));
end