function x = minimize(obj, fun, dfun, x0)
%MINIMIZE Using the Fletcher and Reeves non-linear Conjugate Gradient 
%         minimization

% Starting message
if obj.verbose
    fprintf('<strong>Starting minimization with Fletcher and Reeves NL CG.</strong>\n');
end

% Early check
fx = feval(fun, x0);
if abs(fx) <= obj.tol
    if obj.verbose
        fprintf('Minimum found at x0 = [%s].\n', join(string(x0), ', '));
    end
    
    x = x0;

    return;
end

% Initialise values
x   = x0;
dfx = feval(dfun, x0);
p   = -dfx;

% Intantiate linesearch object
LS = LineSearch();
LS.set_verbose(false);

for i = 1:obj.max_iter
    % Conjugate direction method
    alpha    = LS.search(fun, dfun, fx, dfx, x, p);
    x        = x + alpha*p;
    fx       = feval(fun, x);
    dfx_next = feval(dfun, x);

    % Report iteration
    if obj.verbose
        fprintf('%4d: x    = [%s];\n', i, join(string(x), '; '));
        fprintf('      f(x) = %e.\n', fx);
    end

    % Convergence check
    if norm(dfx_next) <= obj.tol
        if obj.verbose
            fprintf('<strong>Minimum found at x = [%s].</strong>\n', ...
                join(string(x), '; '));
        end

        return;
    end

    % Residual orthogonalization
    beta = (dfx_next'*dfx_next)/(dfx'*dfx);
    p    = -dfx_next + beta*p;

    % Update values
    dfx = dfx_next;
end

% Maximum iterations reached
if obj.verbose
    fprintf('<strong>Maximum number of iterations reached.</strong>\n');
end

end

