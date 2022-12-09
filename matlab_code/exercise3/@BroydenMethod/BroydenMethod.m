classdef BroydenMethod < handle
    %BROYDENMETHOD Class for the Broyden Method
    %   This class implements the Broyden Method algorithms:
    %    - classical   -> classical implementation;
    %    - alternative -> alternative implementation, but no additions;
    %    - inverse     -> update the inverse directly;
    %    - low_memory  -> low memory usage.
    %
    %   Properties:
    %    - tol      -> convergence tolerance;
    %    - max_iter -> maximum number of allowed iterations.
    %    - verbose  -> if true print all iterations
    
    properties (SetAccess = private, Hidden = true)
        tol      % convergence tolerance
        max_iter % maximum number of allowed iterations
        verbose  % if true print all iterations
    end
    
    methods
        function obj = BroydenMethod()
            %BROYDENMETHOD Construct an instance of this class
            %   Default initialization of the properties
            obj.tol      = 1e-8;
            obj.max_iter = 100;
            obj.verbose  = true;
        end
        
        function set_tol(obj, tol)
            %SET_TOL Set a new convergence tolerance
            obj.tol = tol;
        end

        function set_max_iter(obj, max_iter)
            %SET_MAX_ITER Set a new maximum iterations limit
            obj.max_iter = max_iter;
        end

        function set_verbose(obj, verbose)
            %SET_VERBOSE Set a new verbosity level
            obj.verbose = verbose;
        end

        % Minimize the function using the classical implementation
        [a, b] = minimize_classical(obj, fun, x0, A0);
        
        % Minimize the function using the alternative implementation
        [a, b] = minimize_alternative(obj, fun, x0, A0);

        % Minimize the function using the inverse implementation
        [a, b] = minimize_inverse(obj, fun, x0, A0);

        % Minimize the function using the low memory implementation
        [a, b] = minimize_low_memory(obj, fun, x0, A0);
    end
end

