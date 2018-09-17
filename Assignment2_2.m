load('lab1_2.mat');
x = measurements(:,1);
y = measurements(:,2);

plot(x,y,'.');
title('Height vs hair length of 200 people', 'FontName', 'Times New Roman');
xlabel('Height (cm)', 'FontName', 'Times New Roman');
ylabel('Lenght (cm)', 'FontName', 'Times New Roman');
set(gca,'fontsize',8,'FontName', 'Times New Roman');