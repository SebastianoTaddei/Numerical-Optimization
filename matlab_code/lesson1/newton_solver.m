%
% Declare the new function 'newton_solver' that implements the Newton
% method.
% Input arguments:
%  - fun      = 'pointer' to the function f(x);
%  - Dfun     = 'pointer to the function f'(x) (the derivative);
%  - x0       = starting approximation of alpha [f(alpha) = 0];
%  - tol      = tolerance for the stopping criteria |f(x)| <= TOL -> STOP;
%  - max_iter = maximum number of iterations;
%  - verbose  = 'none' --> no message,
%               'iter' --> print a message at each iteration.
%
% Output values:
%  - x    = the computed approximation;
%  - iter = number of iteration done;
%  - flag = true  --> converged,
%           false --> not converged.
%
function [x, iter, flag] = newton_solver(fun, Dfun, x0, tol, max_iter,...
                                         verbose)
    x    = x0;    % initial approximation
    flag = false; % by default no convergence

    for iter = 1:max_iter
        fx  = feval(fun, x);  % compute f(x)
        Dfx = feval(Dfun, x); % compute f'(x)

        if abs(Dfx) == 0 % avoid division by 0
            if verbose == 'iter'
                fprintf("Found f'(x) = 0.\n");
            end
            flag = false;
            return;
        end
        
        % Perform Newton step
        x = x - fx/Dfx;

        % Check convergence
        if abs(fx) <= tol
            if verbose == 'iter'
                fprintf('Convergenced reached at iter %d\n', iter);
                fprintf('x=%g\n', x);
            end
            flag = true;
            return;
        end
        if verbose == 'iter'
            fprintf('iter=%2d x=%g f(x)%g\n', iter, x, fx);
        end
    end
end

