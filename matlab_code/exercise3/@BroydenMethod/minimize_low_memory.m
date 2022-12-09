function x = minimize_low_memory(obj, fun, x0, A0)
%MINIMIZE Minimize a function using the low memory Broyden Method.
%   Parameters:
%    - fun -> function to be minimized;
%    - x0  -> initial guess;
%    - A0  -> initial guess of the Jacobian.
%

fprintf('<strong>Starting Low Memory Broyden Method</strong>.\n');

% Evaluate the function
f = feval(fun, x0);

% Early stopping
if norm(f) < obj.tol
    x = x0;
    
    if obj.verbose
        % Print the result
        fprintf('-------------------------------------------------\n')
        fprintf('The minimum is in:     [%s].\n', join(string(x), ', '));
        fprintf('The function value is: [%s].\n', ...
            join(string(feval(fun, x)), ', '));
        fprintf('-------------------------------------------------\n')
    end

    return;
end

% Initialize the variables
x = x0;
H = inv(A0);
d = -H*f;
l = d'*d;

for i = 1:obj.max_iter
    % Update the estimate
    x = x + d;
    f = feval(fun, x);

    % Check for convergence
    if norm(f) < obj.tol
        if obj.verbose
            % Print the result
            fprintf('-------------------------------------------------\n')
            fprintf('The minimum is in:     [%s].\n', join(string(x), ', '));
            fprintf('The function value is: [%s].\n', ...
                join(string(feval(fun, x)), ', '));
            fprintf('-------------------------------------------------\n')
        end
        return;
    end

    if obj.verbose
        % Print the iteration
        fprintf('iter = %d, x = [%s], f(x) = [%s].\n', ...
            i, join(string(x), ', '), join(string(feval(fun, x)), ', '));
    end

    % Update the variables
    z = H*f;
    for j = 1:i
        z = z + ((d'*z)/l)*d;
    end
    d = -(l/(l + d'*z))*z;
    l = d'*d;
end

if obj.verbose
    % Maximum number of iterations reached
    fprintf('-------------------------------------------------\n')
    fprintf('<strong>Maximum number of iterations reached.</strong>\n');
    fprintf('The minimum is in:     [%s].\n', join(string(x), ', '));
    fprintf('The function value is: [%s].\n', ...
        join(string(feval(fun, x)), ', '));
    fprintf('-------------------------------------------------\n')
end

end

