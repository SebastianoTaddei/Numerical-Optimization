% Define function and its derivative
fun  = @(x) x.*exp(-x.*x) + sin(x);
Dfun = @(x) exp(-x.*x) - 2.*x.^2.*exp(-x.*x) + cos(x);

% Initial guess
x0 = -4;

% Parameters
% tol      = 1e-10;
% max_iter = 100;
% verbose  = 'iter';

NS = newton_class();

x = NS.solve(fun, Dfun, x0);