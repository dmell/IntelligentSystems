% array of struct containing the iriscode of the 20 persons
person = repmat(struct('iriscode', []), 20, 1);

% loading files
for i=1:20
    filename = sprintf('lab_week2_data/person%02d.mat', i);
    person(i) = load(filename);
end

S = zeros(1, 1000);
for i=1:1000
    % random person
    random_iriscode = person(randi(20)).iriscode;
    
    % random permutation of rows to be sure that we don't pick the same row
    iriscode_perm = randperm(20);
    
    % the first two rows with the iriscode
    row1 = random_iriscode(iriscode_perm(1), :);
    row2 = random_iriscode(iriscode_perm(2), :);
    
    % normalized hamming distance
    S(i) = sum(xor(row1, row2) == 1) / 30;
end

D = zeros(1, 1000);
for i=1:1000
    person_perm = randperm(20);
    iriscode1 = person(person_perm(1)).iriscode(randi(20), :);
    iriscode2 = person(person_perm(2)).iriscode(randi(20), :);
    
    % normalized hamming distance
    D(i) = sum(xor(iriscode1, iriscode2) == 1) / 30;
end

% 3.3 adjusted version
figure(1);
histogram(S + 1/60, min(S):(1/30):max(S)+1/30);
hold on;
histogram(D + 1/60, min(D):(1/30):max(D)+1/30);
legend('S', 'D');
title('Different Hamming distances for 1000 iterations');
xlabel('Normalized Hamming distance');
ylabel('Occurrences');
set(gca, 'fontsize', 8, 'fontname', 'Times New Roman');

% default version
figure(2);
histogram(S);
hold on;
histogram(D);
legend('S', 'D');
title('Different Hamming distances for 1000 iterations');
xlabel('Normalized Hamming distance');
ylabel('Occurrences');
set(gca, 'fontsize', 8, 'fontname', 'Times New Roman');

S_mean = mean(S);
S_var = var(S, 1);
D_mean = mean(D);
D_var = var(D, 1);

figure(3);
histogram(S + 1/60, min(S):(1/30):max(S)+1/30);
hold on;
x = [0:0.001:1];
f = normpdf(x, mean(S), std(S))*1000/30;
g = normpdf(x, mean(D), std(D))*1000/30;
axis([0 0.8 0 350]);
plot(x, f);
histogram(D + 1/60, min(D):(1/30):max(D)+1/30);
plot(x, g);
legend('S', 'normpdf S', 'D', 'normpdf D');
title('Normal distributions over histograms');
xlabel('Normalized Hamming distance');
ylabel('Occurrences, scaled probability');
set(gca, 'fontsize', 9.5, 'fontname', 'Times New Roman');