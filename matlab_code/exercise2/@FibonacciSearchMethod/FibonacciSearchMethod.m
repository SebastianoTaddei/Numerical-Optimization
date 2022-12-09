classdef FibonacciSearchMethod < handle
    %FIBONACCISEARCHMETHOD Class for the Fibonacci Search Method
    %   This class implements the Fibonacci Search Method algorithm.
    %   Properties:
    %    - tol      -> convergence tolerance;
    %    - fib      -> Fibonacci sequence up to n+1;
    %    - max_iter -> maximum number of allowed iterations;
    %    - history  -> interval history.
    
    properties (SetAccess = private, Hidden = true)
        tol      % convergence tolerance
        fib      % Fibonacci sequence up to n+1
        max_iter % maximum number of allowed iterations
        history  % interval history
    end
    
    methods
        function obj = FibonacciSearchMethod()
            %FIBONACCISEARCHMETHOD Construct an instance of this class
            %   Default initialization of the properties
            obj.tol      = 1e-8;
            obj.fib      = [0, 1]; % initialize to the first two Fibonacci
                                   % numbers
            obj.max_iter = 0;      % 0 is used as a flag in compute_fib()
            obj.history  = [];
        end
        
        function set_tol(obj, tol)
            %SET_TOL Set a new convergence tolerance
            obj.tol = tol;
        end

        function set_max_iter(obj, max_iter)
            %SET_MAX_ITER Set a new maximum iterations limit
            obj.max_iter = max_iter;
        end
        
        % Compute the Fibonacci sequence up to n+1
        compute_fib(obj, a0, b0);

        % Minimize the function
        [a, b] = minimize(obj, fun, a, b);

        % Plot the interval history
        plot_history(obj, y0, dy);
    end
end

