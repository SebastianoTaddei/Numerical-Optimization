function [a, b] = minimize(obj, fun, a, b)
%MINIMIZE Minimize a function using the Golden Section Minimization
%   This function reduces the interval [a, b] until a certain tolerance in
%   the value of the function is reached.

% Make sure a < b
if a > b
    c = a;
    a = b;
    b = c;
end

% Initialize the interval history
obj.history = [a, b];

% Early convergence check.
% This check also ensures that if b - a <= tol then the Fibonacci sequence
% always has at least 3 elements. This is because:
%  - if F_(n+1) = 1 then (b - a) <= tol;
%  - else F_(n+1) > 1 and length(F) > 2.
if b - a <= obj.tol
    return;
end

% Compute the Fibonacci sequence up to n+1
obj.compute_fib(a, b);

% Compute tau
tau = obj.fib(end - 1)/obj.fib(end);

% Compute inner values of the interval
lambda = b - tau*(b - a);
mu     = a + tau*(b - a);

% Evaluate f(a), f(b), f(lambda), and f(mu)
fl = feval(fun, lambda);
fm = feval(fun, mu);

% Reduce the interval until convergence is reached (or the maximum number
% of iterations is reached
for i = 1:obj.max_iter
    if fl > fm
        if b - lambda <= obj.tol
            % Update interval
            b = mu;

            break;
        else
            % Update interval
            a      = lambda;
            lambda = mu;
            fl     = fm;

            % Compute the new mu
            mu = a + tau*(b - a);
            fm = feval(fun, mu);
        end
    else
        if mu - a <= obj.tol
            % Update interval
            a = lambda;

            break;
        else
            % Update interval
            b  = mu;
            mu = lambda;
            fm = fl;

            % Compute the new lambda
            lambda = b - tau*(b - a);
            fl     = feval(fun, lambda);
        end
    end

    % Update tau
    tau = obj.fib(end - 1 - i)/obj.fib(end - i);

    % Update the history
    obj.history = [obj.history; [a, b]];
end

if i < obj.max_iter
    % Update the history
    obj.history = [obj.history; [a, b]];
end
end

