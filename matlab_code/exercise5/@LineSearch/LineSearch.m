classdef LineSearch < handle
    %LINESEARCH Class implementing various linesearch algorithms
    %   This class implements the following linesearch algorithms:
    %    - Armijo Parabolic-Cubic;
    %    - Wolfe;
    %    - Exact search.
    %   
    %   Properties:
    %    - level    -> the level of condition that the candidate to be 
    %                  minimum point should satisfy:
    %                   - 1 -> Armijio condition;
    %                   - 2 -> Wolfe condition;
    %                   - 3 -> is a minimum point along the search direction.
    %    - max_iter -> maximum number of allowed iterations;
    %    - tol      -> convergence tolerance;
    %    - verbose  -> verbosity level:
    %                   - false -> silent;
    %                   - true  -> full report.
    %    - a_min    -> minimum allowed step size
    %    - a_max    -> maximum allowed step size
    %    - c1       -> first linesearch hyperparameter
    %    - c2       -> second linesearch hyperparameter
    
    properties (SetAccess = private, Hidden = true)
        level    % the level of condition that the candidate to be minimum 
                 % point should satisfy
        max_iter % maximum number of allowed iterations
        tol      % convergence tolerance
        verbose  % verbosity level
        a_min    % minimum allowed step size
        a_max    % maximum allowed step size
        c1       % first linesearch hyperparameter
        c2       % second linesearch hyperparameter
    end
    
    methods
        function obj = LineSearch()
            %LINESEARCH Construct an instance of this class
            %   Sets the default values for the class properties
            obj.level    = 1;
            obj.max_iter = 1e2;
            obj.tol      = 1e-8;
            obj.verbose  = true;
            obj.a_min    = 1e-4;
            obj.a_max    = 0.99;
            obj.c1       = 1e-3;
            obj.c2       = 1e-4;
        end

        function set_level(obj, level)
            %SET_LEVEL Set a new level
            obj.level = level;
        end

        function set_max_iter(obj, max_iter)
            %SET_MAX_ITER Set a new max_iter
            obj.max_iter = max_iter;
        end

        function set_tol(obj, tol)
            %SET_TOL Set a new tol
            obj.tol = tol;
        end

        function set_verbose(obj, verbose)
            %SET_VERBOSE Set a new verbose
            obj.verbose = verbose;
        end

        function set_a_min(obj, a_min)
            %SET_A_MIN Set a new a_min
            obj.a_min = a_min;
        end

        function set_a_max(obj, a_max)
            %SET_A_MAX Set a new a_max
            obj.a_max = a_max;
        end

        function set_c1(obj, c1)
            %SET_C1 Set a new c1
            obj.c1 = c1;
        end

        function set_c2(obj, c2)
            %SET_C2 Set a new c2
            obj.c2 = c2;
        end
        
        % Cubic interpolation
        alpha = cubic(obj, fx0, dfx0_p, fx_next, al, fx_prev, al_prev);

        % Range check
        alpha = range(obj, al, a, b);

        % Zoom
        alpha = zoom(obj, fun, dfun, alpha, p, x0, fx0, dfx0_p, fx_next);

        % Refine
        alpha = refine(obj, fun, dfun, p, alpha, x0, fx0, dfx0_p, fx_prev, fx_next, dfx_a, alpha_prev);

        % Search for the best step size
        alpha = search(obj, fun, dfun, fx0, dfx0, x0, p);

        % Secant method
        alpha = secant(obj, fun, x0, alpha0, alpha1, p);

        % Minimize using the steepest descent direction and linesearch
        x = minimize(obj, fun, dfun, x0);
    end
end

