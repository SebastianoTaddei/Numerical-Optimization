function alpha = refine(obj, fun, dfun, p, alpha, x0, fx0, dfx0_p, fx_prev, fx_next, dfx_a, alpha_prev)
%REFINE Find an alpha that satisfies the strong Wolfe condition

alpha_o = alpha;
fx_o    = fx_next;
dfx_o   = dfx_a;
delta   = alpha_prev - alpha_o;

while delta > obj.tol
    d_alpha = delta.^2*dfx_o./(2*(fx_o + dfx_o*delta - fx_prev));
    d_alpha = obj.range(d_alpha, 0.2*delta, 0.8*delta);
    alpha   = alpha_o + d_alpha;
    fx_next = feval(fun, x0 + alpha*p);
    
    if fx_next <= fx0 + alpha*obj.c1*dfx0_p
        dfx_next = feval(dfun, x0 + alpha*p)'*p;

        if dfx_next >= obj.c2*dfx0_p
            return;
        end

        % Update values
        alpha_o = alpha;
        fx_o    = fx_next;
        dfx_o   = dfx_a;
        delta   = delta - d_alpha;
    else
        alpha_prev = alpha;
        fx_prev    = fx_next;
        delta      = d_alpha;
    end
end

% Search failed
return;

end

