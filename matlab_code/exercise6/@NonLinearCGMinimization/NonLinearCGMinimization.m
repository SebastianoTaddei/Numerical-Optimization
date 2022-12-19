classdef NonLinearCGMinimization < handle
    %NONLINEARCGMINIMIZATION Class implementing non-linear Conjugate
    %                        Gradient minization using the Fletcher and
    %                        Reeves version
    %   
    %   Properties:
    %    - max_iter -> maximum number of allowed iterations;
    %    - tol      -> convergence tolerance;
    %    - verbose  -> verbosity level:
    %                   - false -> silent;
    %                   - true  -> full report.
    
    properties (SetAccess = private, Hidden = true)
        max_iter % maximum number of allowed iterations
        tol      % convergence tolerance
        verbose  % verbosity level
    end
    
    methods
        function obj = NonLinearCGMinimization()
            %NONLINEARCGMINIMIZATION Construct an instance of this class
            %   Sets the default values for the class properties
            obj.max_iter = 1e2;
            obj.tol      = 1e-8;
            obj.verbose  = true;
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

        % Minimize using the Fletcher and Reeves non-linear Conjugate
        % Gradient minimization
        x = minimize(obj, fun, dfun, x0);
    end
end

