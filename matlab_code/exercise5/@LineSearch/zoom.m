function alpha = zoom(obj, fun, dfun, alpha, p, x0, fx0, dfx0_p, fx_next)
%ZOOM Find an alpha that satisfies the strong Wolfe condition

dfx_a = feval(dfun, x0 + alpha*p)'*p;

if abs(dfx_a) >= abs(obj.c2*dfx0_p)
    return;
elseif alpha == 1
    while alpha <= obj.a_max
        alpha_prev = alpha;
        fx_prev    = fx_next;
        alpha      = 2*alpha;
        fx_next    = feval(fun, x0 + alpha*p);

        if fx_next > fx0 + alpha*obj.c1*dfx0_p
            % Swap values
            alpha_supp = alpha_prev;
            alpha_prev = alpha;
            alpha      = alpha_supp;
            fx_supp    = fx_prev;
            fx_prev    = fx_next;
            fx_next    = fx_supp;

            % Refine
            alpha = obj.refine(fun, dfun, p, alpha, x0, fx0, dfx0_p, fx_prev, fx_next, dfx_a, alpha_prev);
        end

        % Update values
        dfx_a = feval(dfun, x0 + alpha*p)'*p;

        % Check strong Wolfe condition
        if abs(dfx_a) >= abs(obj.c2*dfx0_p)
            return;
        end
    end
    
    % Search failed
    alpha = obj.a_max;
    return;
end

