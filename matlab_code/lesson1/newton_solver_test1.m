% Define function and its derivative
fun  = @(x) x.*exp(-x.*x) - sin(x);
Dfun = @(x) exp(-x.*x) - 2.*x.^2.*exp(-x.*x) - cos(x);

% Initial guess
x0 = 1.0;

% Parameters
tol      = 1e-10;
max_iter = 100;
verbose  = 'iter';

[x, iter, flag] = newton_solver(fun, Dfun, x0, tol, max_iter, verbose);