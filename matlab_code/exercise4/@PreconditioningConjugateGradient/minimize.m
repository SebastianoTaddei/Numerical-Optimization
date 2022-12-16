function x = minimize(obj, A, b, x0)
%MINIMIZE Minimize a linear system using the PCG method.

fprintf('<strong>Starting minimization with PCG method.</strong>\n')

% Initial step
k     = 0;
x     = x0;
r     = b - A*x;
q     = r;

% Compute predictioner
if strcmp(obj.prec, 'Jacobi')
    M_inv = inv(diag(diag(A), 0));
elseif strcmp(obj.prec, 'SSOR')
    L     = tril(A, -1);      % strictly lower part of A
    D     = diag(diag(A), 0); % diagonal of A
    M_inv = inv((D + L)*(D\(D + L')));
end

z     = M_inv*r;

% Print first iteration
if obj.verbose
    fprintf('%d: x = [%s], f(x) = [%s].\n', k, join(string(x), ','), ...
        join(string(A*x - b), ','));
end

while norm(z) > obj.tol
    % Increase iter counter
    k = k + 1;

    % Conjugate direction method
    alpha  = (r'*z)/(q'*A*q);
    x      = x + alpha*q;
    r_next = r + - alpha*A*q;

    if obj.verbose
        fprintf('%d: x = [%s], f(x) = [%s].\n', k, ...
            join(string(x), ','), join(string(A*x - b), ','));
    end

    % Preconditioning
    z_next = M_inv*r_next;

    % Residual orthogonalization
    beta = (r_next'*z_next)/(r'*z);
    q    = z_next + beta*q;

    % Check for divergence
    if norm(z_next) > norm(z)
        fprintf('<strong>Method started to diverge, stopping.</strong>\n')
        break;
    end

    % Update variables
    r = r_next;
    z = z_next;
end

if norm(z) <= obj.tol
    fprintf('Found minimum at iter = %d with x = [%s].\n', k, ...
        join(string(x), ','));
end

