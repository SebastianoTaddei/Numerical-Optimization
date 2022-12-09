function compute_fib(obj, a0, b0)
%COMPUTE_FIB Compute the Fibonacci sequence up to n+1
%   Compute the Fibonacci sequence up to n+1 such that
%   F_(n+1) >= (b0 - a0)/tol

% Compute the stopping criteria
stop_criteria = (b0 - a0)/obj.tol;

% The stop_criteria should never be negative if the interval [a, b] is
% correctly formed (i.e., a < b).
if 0 >= stop_criteria
    error("Badly formed interval, a > b!")
else
    % Start looking for the correct n+1 Fibonacci number
    while obj.fib(end) < stop_criteria
        obj.fib = [obj.fib, obj.fib(end) + obj.fib(end - 1)];
    end
end

% Ensure that max_iter < length(obj.fib) - 2
if obj.max_iter == 0
    % Dynamically set max_iter based on the length of the Fibonacci
    % sequence
    obj.max_iter = length(obj.fib) - 3;
else
    % The user has manually set max_iter, simply check if it is feasible
    if obj.max_iter >= length(obj.fib) - 2
        error("The maximum number of iterations is too high.")
    end
end
end

