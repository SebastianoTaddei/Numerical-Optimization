%
% Solve the problem f(x) = 0 starting from point x0
%
function x2 = solve(self, fun, x0, x1)
    self.setup(fun);

    self.flag      = false;    % by default no convergence
    self.x_history = [x0, x1]; % initialize history

    fx0 = feval(self.fun, x0); % compute f(x0)
    fx1 = feval(self.fun, x1); % compute f(x1)

    fprintf("<strong>Starting Newton solver.</strong>\n");

    for iter = 1:self.max_iter
        top = fx1;
        bot = (fx1 - fx0)./(x1 - x0);

        if abs(bot) == 0 % avoid division by 0
            if self.verbose == 'iter'
                fprintf("Found (f(x1) - f(x0))./(x1 - x0) = 0.\n");
            end
            break;
        end
        
        % Perform Secant step
        x2 = x1 - top./bot;

        % Compute f(x2)
        fx2 = feval(self.fun, x2);

        % Save iteration
        self.x_history = [self.x_history, x2];

        % Check convergence
        if abs(fx2) <= self.tol
            if self.verbose == 'iter'
                fprintf('iter=%2d x=%g f(x)=%g\n', iter, x2, fx2);
                fprintf('Convergenced reached at iter %d.\n', iter);
            end
            self.flag = true;
            break;
        end
        if self.verbose == 'iter'
            fprintf('iter=%2d x=%g f(x)=%g\n', iter, x2, fx2);
        end

        % Shift values
        x0  = x1;  x1  = x2;
        fx0 = fx1; fx1 = fx2;
    end
    self.iter = iter;
end

