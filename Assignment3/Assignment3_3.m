% 3
syms x

mean1 = 1;
mean2 = -3;
dev1 = sqrt(2);
dev2 = sqrt(2);
prior_S1 = 0.5;
prior_S2 = 0.5;

eqn = prior_S1*1/(sqrt(2*pi)*dev1)*exp(-0.5*(x-mean1)^2/dev1^2) == ...
prior_S2*1/(sqrt(2*pi)*dev2)*exp(-0.5*(x-mean2)^2/dev2^2);
solx = double(solve(eqn, x));
for i=1:numel(solx)
    fprintf('x(%i) = %f\n', i, solx(i));
end
