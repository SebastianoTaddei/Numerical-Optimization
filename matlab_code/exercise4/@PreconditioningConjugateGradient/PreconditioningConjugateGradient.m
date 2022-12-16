classdef PreconditioningConjugateGradient < handle
    %PRECONDITIONINGCONJUGATEGRADIENT Class for the Preconditioning 
    % Conjugate Gradient method.
    %
    %   Properties:
    %    - tol      -> convergence tolerance;
    %    - max_iter -> maximum number of allowed iterations;
    %    - prec     -> preconditioner type;
    %                   - Jacobi -> M = diag(A).
    %                   - SSOR   -> M = (D/w + L)*w/(2 - w)*D^-1*(D/w +
    %                   L^T) where A = L + D + L^T.
    %    - verbose  -> if true print all iterations.
    %
    
    properties (SetAccess = private, Hidden = true)
        tol      % convergence tolerance
        max_iter % maximum number of allowed iterations
        prec     % preconditioner type, 'Jacobi' or 'SSOR'
        verbose  % if true print all iterations
    end
    
    methods
        function obj = PreconditioningConjugateGradient()
            %PRECONDITIONINGCONJUGATEGRADIENT Construct an instance of this
            % class.
            %
            %   Default initialization of the properties
            %
            obj.tol      = 1e-8;
            obj.max_iter = 100;
            obj.prec     = 'Jacobi';
            obj.verbose  = true;
        end
        
        function set_tol(obj, tol)
            %SET_TOL Set a new convergence tolerance
            obj.tol = tol;
        end

        function set_max_iter(obj, max_iter)
            %SET_MAX_ITER Set a new maximum number of iterations
            obj.max_iter = max_iter;
        end

        function set_prec(obj, prec)
            %SET_TOL Set a new preconditioner type
            obj.prec = prec;
        end

        function set_verbose(obj, verbose)
            %SET_VERBOSE Set a new verbosity level
            obj.verbose = verbose;
        end

        % Minimize a linear system using the PCG method
        [a, b] = minimize(obj, A, b, x0);
    end
end

