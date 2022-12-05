classdef DekkerBrent < handle
    %DEKKERBRENT DekkerBrent method to find a root of a function
    %   Properties:
    %    - 
    %
    %   Output values.
    %    - 
    
    properties (SetAccess = private, Hidden = true)
        max_iter % maximum number of iterations
        tol      % tolerance for the solution
        verbose  % verbosity of the solver:
                 % - 0 -> silent;
                 % - 1 -> show iterations.
        fun      % function to find the root of
        lb       % lower bound of the range to look for the root
        ub       % upper bound of the range to look for the root
        x_last   % last root found
        iter     % last iteration
        flag     % convergence flag
    end
    
    methods
        function obj = DekkerBrent(varargin)
            %DEKKERBRENT Construct an instance of this class
            %   varagin allows to set max_iter, tol, and verbose when
            %   instantiating an object, otherwise use default values.
            
            % Set default values
            obj.max_iter = 100;
            obj.tol      = 1e-8;
            obj.verbose  = 1;

            if nargin > 0
                obj.max_iter = varargin{1};
            end
            if nargin > 1
                obj.tol = varargin{2};
            end
            if nargin > 2
                obj.verbose = varargin{3};
            end
        end
        
        function set_max_iter(obj, max_iter)
            %SET_MAX_ITER Set the max_iter parameter
            obj.max_iter = max_iter;
        end

        function set_tol(obj, tol)
            %SET_TOL Set the tol parameter
            obj.tol = tol;
        end

        function set_verbose(obj, verbose)
            %SET_TOL Set the tol parameter
            obj.verbose = verbose;
        end

        function setup(obj, fun, lb, ub)
            %SETUP Set the fun, lb, and ub parameters
            obj.fun = fun;
            obj.lb  = lb;
            obj.ub  = ub;
        end

        % Declare the method solve without the implementation.
        x = solve(obj, fun, lb, ub)
    end
end

