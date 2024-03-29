load('./lab_week2_data/lab1_2.mat');
x = measurements(:,1);
y = measurements(:,2);

% Plot data
figure(1);
plot(x,y,'.');
title('Height vs hair length of 200 people');
xlabel('Height (cm)');
ylabel('Lenght (cm)');
set(gca,'fontsize', 8, 'fontname', 'Times New Roman');

% Code for the second question
figure(2);
plot(x,y,'.');
title('Height vs hair length of 200 people, with one possible decision criterion');
xlabel('Height (cm)');
ylabel('Lenght (cm)');
set(gca, 'fontsize', 8, 'fontname', 'Times New Roman');
hold on;
plot([165.5 194.5], [0 60]);

p1 = [165.5 0];
p2 = [194.5 60];

% a and b just keep the count of points on the two sides of the line
a = 0;
b = 0;
for i=1:200
    d = (measurements(i,1)-p1(1))*(p2(2)-p1(2)) - (measurements(i,2)-p1(2))*(p2(1)-p1(1));
    if d > 0
        a = a+1;
    else
        b = b+1;
    end
end

fprintf('Persons considered women: %d\nPersons considered men:   %d\n', a, b);