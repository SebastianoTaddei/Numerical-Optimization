function alpha = search(obj, fun, dfun, fx0, dfx0, x0, p)
%SEARCH Linesearch using either:
%        - Armijo backtracking;
%        - Armijo parabolic-cubic;
%        - Wolfe.

% Initial setup
dfx0_p  = dfx0'*p;
fx_prev = fx0;

% Linesearch parameters
alpha = 1.0;

% Perform exact linesearch using the secant method
if obj.level == 3
    alpha = obj.secant(fun, x0, alpha, alpha*0.8, p);
    
    % Report linesearch
    if obj.verbose
        fprintf('      | alpha = %e;\n', alpha);
    end

    return;
end

alpha_prev = alpha;

while alpha >= obj.a_min
    % Compute f(x + alpha*p)
    fx_next = feval(fun, x0 + alpha*p);

    if fx_next <= fx0 + alpha*obj.c1*dfx0_p
        switch obj.level
            case 1
                % Report linesearch
                if obj.verbose
                    fprintf('      | alpha = %e;\n', alpha);
                end

                return;
            case 2
                alpha = obj.zoom(fun, dfun, alpha, p, x0, fx0, dfx0_p, fx_next);

                % Report linesearch
                if obj.verbose
                    fprintf('      | alpha = %e;\n', alpha);
                end

                return;
        end
    % Update step size
    else
        if alpha == 1
            alpha_next = dfx0_p/(2*(fx0 + dfx0_p - fx_next));
        else
            alpha_next = obj.cubic(fx0, dfx0_p, fx_next, alpha, fx_prev, alpha_prev);
        end

        % Update values
        alpha_prev = alpha;
        fx_prev    = fx_next;
        alpha      = obj.range(alpha_next, alpha/10, alpha/2);
    end
end
end

