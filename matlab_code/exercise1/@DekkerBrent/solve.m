function x = solve(obj, fun, lb, ub)
%SOLVE Find the root of fun in the range [lb; ub] using DekkerBrent.
%   Use the DekkerBrent method to find a root of the function fun know to
%   be in the range [lb; ub].

fprintf('<strong>Starting DekkerBrent solver.</strong>\n')

obj.setup(fun, lb, ub);

x        = 0;     % default value for errors
obj.flag = false; % by default no convergence

a  = obj.lb;
fa = feval(obj.fun, a);

% Check for root on the lb
if fa == 0
    x = a;
    
    if obj.verbose == 1
        fprintf('Iter: %5d   x = %+3.2e   f(x) = %+3.2e.\n', 0, x, fa);
    end

    fprintf('Root found on the lower bound at %3.2e.\n', x);

    obj.x_last = x;
    obj.iter   = 0;

    return;
end

b  = obj.ub;
fb = feval(obj.fun, b);

% Check for root on the ub
if fb == 0
    x = b;

    if obj.verbose == 1
        fprintf('Iter: %5d   x = %+3.2e   f(x) = %+3.2e.\n', 0, x, fb);
    end

    fprintf('Root found on the upper bound at %3.2e.\n', x);

    obj.x_last = x;
    obj.iter   = 0;
    return;
end

% Check for a non-proper range
if fa * fb > 0
    fprintf(['Root is not bracketed! [lb: %3.2e, ub: %3.2e] -> ' ...
             '[f(lb) = %3.2e; f(ub) = %3.2e]\n'], a, b, fa, fb);
    return;
end

c = (a + b)/2;

% Start iterating
for iter = 1:obj.max_iter
    fc = feval(obj.fun, c);

    if abs(fc) < obj.tol
        x = c;
        
        if obj.verbose == 1
            fprintf('Iter: %5d   x = %+3.2e   f(x) = %+3.2e.\n', iter, x, fc);
        end

        break;
    end

    % Tighten brackets on the root
    if fa*fc < 0
        b = c;
    else
        a = c;
    end

    if b - a < obj.tol*max(abs(b), 1)
        x = (a + b)/2;
        
        if obj.verbose == 1
            fprintf('Iter: %5d   x = %+3.2e   f(x) = %+3.2e.\n', iter, x, ...
                    feval(obj.fun, x));
        end

        break;
    end

    % Try quadratic interpolation
    denom = (fb - fa)*(fc - fa)*(fb - fc);
    numer = c*(fa - fb)*(fb - fc + fa) + fb*obj.lb*(fb - fc) + ...
            fa*obj.ub*(fc - fa);
    
    % If denom = 0 push x out of bracket to force bisection
    if denom == 0
        dx = b - a;
    else
        dx = fc*numer/denom;
    end

    x = c + dx;

    % If interpolation goes out of bracket use bisection
    if (b - x)*(x - a) < 0
        dx = (b - a)/2;
        x  = a + dx;
    end

    % Change bounds
    if obj.lb < c
        obj.ub = c;
        fb     = fc;
    else
        obj.lb = c;
        fa     = fc;
    end

    if abs(x - c) < obj.tol
        if obj.verbose == 1
            fprintf('Iter: %5d   x = %+3.2e   f(x) = %+3.2e.\n', iter, x, ...
                    feval(obj.fun, x));
        end

        break;
    end

    c = x;

    if obj.verbose == 1
        fprintf('Iter: %5d   x = %+3.2e   f(x) = %+3.2e.\n', iter, x, ...
                feval(obj.fun, x));
    end
end

if iter >= obj.max_iter
    fprintf('WARNING: maximum number of iterations reached.\n');
else
    fprintf('Root found at %3.2e.\n', x);
end

obj.x_last = x;
obj.iter   = iter;

end

