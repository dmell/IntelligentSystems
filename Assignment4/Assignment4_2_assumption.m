load('lab_4_data/dataAEX.mat');
load('lab_4_data/labelsAEX.mat');

indexAEX = find(strcmp(labels, 'AEX'), 1);
indexRDS = find(strcmp(labels, 'RDS'), 1);
indexAEG = find(strcmp(labels, 'AEG'), 1);

plot(data(indexAEX, :));
hold on;
plot(data(indexRDS, :));
legend('AEX', 'RDS');
title('Stock values for AEX and RDS');
xlabel('Time series');
ylabel('Value');
set(gca, 'fontsize', 9.5, 'fontname', 'Times New Roman');

figure(2);
plot(data(indexAEX, :));
hold on;
plot(data(indexAEG, :));
legend('AEX', 'AEG');
title('Stock values for AEX and AEG');
xlabel('Time series');
ylabel('Value');
set(gca, 'fontsize', 9.5, 'fontname', 'Times New Roman');