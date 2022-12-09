function x = minimize_classical(obj, fun, x0, A0)
%MINIMIZE Minimize a function using the classical Broyden Method.
%   Parameters:
%    - fun -> function to be minimized;
%    - x0  -> initial guess;
%    - A0  -> initial guess of the Jacobian.
%

fprintf('<strong>Starting Classical Broyden Method</strong>.\n');

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
A = A0;

for i = 1:obj.max_iter
    % Solve the linear system A_k*s_k + f_k = 0;
    s = linsolve(A, -f);
    
    % Update the estimate
    x      = x + s;
    f_next = feval(fun, x);

    % Check for convergence
    if norm(f_next) < obj.tol
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
    y      = f_next - f;
    A      = A + ((y - A*s)*s')/(s'*s);
    f      = f_next;
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

