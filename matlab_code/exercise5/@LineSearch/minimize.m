function x = minimize(obj, fun, dfun, x0)
%MINIMIZE Minimize using the steepest descent direction and linesearch

% Starting message
if obj.verbose
    fprintf('<strong>Starting minimization with Steepest Descent and linesearch.</strong>\n');
end

% Early exit
fx = feval(fun, x0);
if norm(fx) <= obj.tol
    x = x0;

    if obj.verbose
        fprintf('Minimum found at x0 = [%s].\n', join(string(x0), ', '));
    end
    
    return;
end

% Initial setup
x   = x0;
dfx = feval(dfun, x);
p   = -dfx./norm(dfx);

if obj.verbose
    fprintf('   0: x    = [%s];\n', join(string(x), '; '));
    fprintf('      f(x) = %e.\n', fx);
end


for i = 1:obj.max_iter
    % Compute step size
    alpha = obj.search(fun, dfun, fx, dfx, x, p);

    % Perform step
    x = x + alpha*p;

    % Update variables
    fx  = feval(fun, x);
    dfx = feval(dfun, x);
    p   = -dfx./norm(dfx);

    % Report iteration
    if obj.verbose
        fprintf('%4d: x    = [%s];\n', i, join(string(x), '; '));
        fprintf('      f(x) = %e.\n', fx);
    end

    % Check convergence
    if norm(fx) <= obj.tol
        if obj.verbose
            fprintf('<strong>Minimum found at x = [%s].</strong>\n', ...
                join(string(x), '; '));
        end

        return;
    end
end

% Maximum iterations reached
if obj.verbose
    fprintf('<strong>Maximum number of iterations reached.</strong>\n');
end

end

