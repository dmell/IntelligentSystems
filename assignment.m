temps = [0.5 0.2 0.1 0.05 0.02 0.01];


iterations = numel(temps);
y = zeros(1, iterations);
e = zeros(1, iterations);

for i = 1:iterations
    [average, variance] = tsp(50, temps(i));
    
    y(i) = average;
    e(i) = sqrt(variance);
end

figure(1); plot(0,0); hold on; 
plot(temps, y, 'ko-');
errorbar(temps, y, e);

title('n = 50','fontsize',16);
 xlabel('T','fontsize',16)
 ylabel('<l>','fontsize',16);