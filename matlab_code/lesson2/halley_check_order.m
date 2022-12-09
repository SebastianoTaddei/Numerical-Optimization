% Define function and its derivative
fun   = @(x) (x - 1).*(cos(x) + 1 + exp(-x));
Dfun  = @(x) cos(x) + 1 + exp(-x) + (x - 1).*(-sin(x) - exp(-x));
DDfun = @(x) -sin(x) - exp(-x) - sin(x) - exp(-x) + (x - 1).*(-cos(x) + exp(-x));

% Initial guess
x0 = -1;

% Parameters
% tol      = 1e-10;
% max_iter = 100;
% verbose  = 'iter';

HS = halley_class();

% Solve
x = HS.solve(fun, Dfun, DDfun, x0);

% Get history
xh = HS.get_history();

% Compute error
sol = 1;
err = abs(xh - x);
% log(e(k+2)/e(k+1)) / log(e(k+1)/e(k))
% Remove the last sample because it is not consistent (it gets inf)
p = log(err(3:end-1)./err(2:end-2)) ./ log(err(2:end-2)./err(1:end-3));