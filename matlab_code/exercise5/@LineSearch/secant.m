function alpha = secant(obj, fun, x0, alpha0, alpha1, p)
%SECANT Exact linesearch using the secant method

% Initialise values
fx_prev    = feval(fun, x0 + alpha0*p);
fx_next    = feval(fun, x0 + alpha1*p);
alpha_prev = alpha0;
alpha_next = alpha1;

% Early convergence
if abs(fx_prev) <= obj.tol
    alpha = alpha_prev;
    return;
elseif abs(fx_next) <= obj.tol
    alpha = alpha_next;
    return;
end

for i = 1:obj.max_iter
    % Approximate the derviative
    num = fx_next - fx_prev;
    den = alpha_next - alpha_prev;
    dfx = num/den;

    if den == 0
        if obj.verbose
            fprintf('Found den = 0.\n');
        end
        
        alpha = alpha_next;
        return;
    end

    % Update values
    fx_prev    = fx_next;
    alpha_prev = alpha_next;

    % Compute step
    alpha_next = alpha_next - fx_next/dfx;

    % Compute the f(x + alpha*p)
    fx_next = feval(fun, x0 + alpha_next*p);

    % Check convergence
    if alpha_next > 0
        if abs(fx_next) <= obj.tol
            alpha = alpha_next;
            return;
        end
    end
end

% Failed to converge
if alpha_next > 0 && alpha_prev > 0
    if abs(fx_next) <= abs(fx_prev)
        alpha = alpha_next;
        return;
    else
        alpha = alpha_prev;
        return;
    end
elseif alpha_prev > 0
    alpha = alpha_prev;
    return;
elseif alpha_next > 0
    alpha = alpha_next;
    return;
else
    alpha = obj.a_min;
end

end

