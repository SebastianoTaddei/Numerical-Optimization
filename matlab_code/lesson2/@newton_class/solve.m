%
% Solve the problem f(x) = 0 starting from point x0
%
function x = solve(self, fun, Dfun, x0)
    self.setup(fun, Dfun);

    self.flag      = false; % by default no convergence
    x              = x0;    % initial approximation
    self.x_history = x0;    % initialize history

    fprintf("<strong>Starting Newton solver.</strong>\n");

    for iter = 1:self.max_iter
        fx   = feval(self.fun, x);   % compute f(x)
        Dfx  = feval(self.Dfun, x);  % compute f'(x)

        top = fx;
        bot = Dfx;

        if abs(bot) == 0 % avoid division by 0
            if self.verbose == 'iter'
                fprintf("Found 2*f'(x)^2 - f(x)*f''(x) = 0.\n");
            end
            break;
        end
        
        % Perform Newton step
        x = x - top./bot;

        % Recompute fx
        fx = feval(self.fun, x);

        % Save iteration
        self.x_history = [self.x_history, x];

        % Check convergence
        if abs(fx) <= self.tol
            if self.verbose == 'iter'
                fprintf('iter=%2d x=%g f(x)=%g\n', iter, x, fx);
                fprintf('Convergenced reached at iter %d.\n', iter);
            end
            self.flag = true;
            break;
        end
        if self.verbose == 'iter'
            fprintf('iter=%2d x=%g f(x)=%g\n', iter, x, fx);
        end
    end
    self.iter = iter;
end

