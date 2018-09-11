%temps = [1 0.8 0.5 0.4 0.3 0.2 0.15 0.1 0.075 0.05 0.02 0.01];
% descreasing the temperature too much doesn't allow to accept enough
% increasing lengths and produces worse results.
%temps = [0.05 0.04 0.03 0.02 0.01 0.005 0.001];

% default
temps = [0.5 0.2 0.1 0.05 0.02 0.01];
% low temps
%temps = [0.05 0.02 0.01 0.005 0.0000000001];
% high temps
%temps = [0.1 0.2 0.5 1 2 3 4 5 6 7 8];

iterations = numel(temps);
y = zeros(1, iterations);
e = zeros(1, iterations);

for i = 1:iterations
    [average, variance] = tsp(500, temps(i));
    
    y(i) = average;
    e(i) = sqrt(variance);
end

figure(1); plot(0,0); hold on; 
% Change limits for low temps
%ylim([0.8 1.1])
plot(temps, y, 'ko-');
errorbar(temps, y, e);

xlabel('T','fontsize',16, 'FontName', 'Times New Roman', 'Interpreter', 'tex');
ylabel('\langle \it{l} \rangle','fontsize',16,'rotation', 0, 'Interpreter', 'tex', 'FontName', 'Times New Roman');




