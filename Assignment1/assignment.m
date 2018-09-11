%temps = [1 0.8 0.5 0.4 0.3 0.2 0.15 0.1 0.075 0.05 0.02 0.01];
% descreasing the temperature too much doesn't allow to accept enough
% increasing lengths and produces worse results.
%temps = [0.05 0.04 0.03 0.02 0.01 0.005 0.001];

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
 ylabel('<l>','fontsize',16,'rotation', 0);