% Define function
fun = @(x) x.*exp(-x.*x) + sin(x);

% Initial guess
lb = -1;
ub = 2;

% Parameters
% tol      = 1e-10;
% max_iter = 100;
% verbose  = 'iter';

DB = DekkerBrent();

x = DB.solve(fun, lb, ub);