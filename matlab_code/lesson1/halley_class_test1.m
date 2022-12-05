% Define function and its derivative
fun   = @(x) x.*exp(-x.*x) - sin(x);
Dfun  = @(x) exp(-x.*x) - 2.*x.^2.*exp(-x.*x) - cos(x);
DDfun = @(x) -2.*x.*exp(-x.*x) - 4.*x.*exp(-x.*x) + 4.*x.^3.*exp(-x.*x) + sin(x);

% Initial guess
x0 = 1.0;

% Parameters
% tol      = 1e-10;
% max_iter = 100;
% verbose  = 'iter';

HS = halley_class();

x = HS.solve(fun, Dfun, DDfun, x0);