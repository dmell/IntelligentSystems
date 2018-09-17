load('lab1_1.mat');
%bar(1:100, length_men);
histogram(length_men);
hold on;
histogram(length_women);

title('Men and women lenghts', 'FontName', 'Times New Roman');
xlabel('Height (cm)', 'FontName', 'Times New Roman');
ylabel('Amount of people', 'FontName', 'Times New Roman');
set(gca,'fontsize',8,'FontName', 'Times New Roman');
legend('Men','Women');

short_men = find(length_men < 170);
tall_women = find(length_women >= 170);

best = numel(short_men) + numel(tall_women);

for i = 171:180
    sum = numel(find(length_men < i)) + numel(find(length_women >= i));
    if (sum < best) 
        best = sum;
        thr = i;
    end
end

fprintf('The best decision criterion is at %d.\n',thr);