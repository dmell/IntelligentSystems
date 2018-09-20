load('./lab_week2_data/lab1_1.mat');

% Plot histograms
histogram(length_men);
hold on;
histogram(length_women);

% Add title, axis labels and legend
title('Men and women lenghts');
xlabel('Height (cm)');
ylabel('Amount of people');
set(gca, 'fontsize', 8, 'fontname', 'Times New Roman');
legend('Men', 'Women');

% Find the best decision criterion with the least amount of misjudgements
best = Inf;
for i = 170:180
    sum = numel(find(length_women > i)) + numel(find(length_men <= i));
    
    if (sum < best) 
        best = sum;
        thr = i;
    end
end

fprintf('The best decision criterion is at %d.\n',thr);