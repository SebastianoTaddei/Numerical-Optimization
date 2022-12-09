classdef GoldenSectionMinimization < handle
    %GOLDENSECTIONMINIMIZATION Class for the Golden Section Minimization
    %   This class implements the Golden Section Minimization algorithm.
    %   Properties:
    %    - tol      -> convergence tolerance;
    %    - tau      -> reduction factor;
    %    - max_iter -> maximum number of allowed iterations;
    %    - history  -> interval history.
    
    properties (SetAccess = private, Hidden = true)
        tol      % convergence tolerance
        tau      % reduction factor
        max_iter % maximum number of allowed iterations
        history  % interval history
    end
    
    methods
        function obj = GoldenSectionMinimization()
            %GOLDENSECTIONMINIMIZATION Construct an instance of this class
            %   Default initialization of the properties
            obj.tol      = 1e-8;
            obj.tau      = (sqrt(5) - 1)/2;
            obj.max_iter = 10;
            obj.history  = [];
        end
        
        function set_tol(obj, tol)
            %SET_TOL Set a new convergence tolerance
            obj.tol = tol;
        end

        function set_tau(obj, tau)
            %SET_TAU Set a new reduction factor
            obj.tau = tau;
        end

        function set_max_iter(obj, max_iter)
            %SET_MAX_ITER Set a new maximum iterations limit
            obj.max_iter = max_iter;
        end
        
        % Minimize the function
        [a, b] = minimize(obj, fun, a, b);

        % Plot the interval history
        plot_history(obj, y0, dy);
    end
end

