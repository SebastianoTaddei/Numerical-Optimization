%
% Declare the new class 'halley_class' that implements the Newton
% method.
% Properties:
%  - fun      = 'pointer' to the function f(x);
%  - Dfun     = 'pointer to the function f'(x) (the derivative);
%  - DDfun    = 'pointer to the function f''(x) (the second derivative);
%  - x0       = starting approximation of alpha [f(alpha) = 0];
%  - tol      = tolerance for the stopping criteria |f(x)| <= TOL -> STOP;
%  - max_iter = maximum number of iterations;
%  - verbose  = 'none' --> no message,
%               'iter' --> print a message at each iteration.
%
% Output values:
%  - x    = the computed approximation;
%  - iter = number of iteration done;
%  - flag = true  --> converged,
%           false --> not converged.
%
% Inheriting from handle allows you to modify properties of the class
classdef halley_class < handle

    % Properties set to read only and hid from the user
    properties (SetAccess = private, Hidden = true)
        fun
        Dfun
        DDfun
        tol
        max_iter
        verbose
        iter     % final iteration
        flag     % convergence flag
        x_last   % last computed value
    end
    
    methods
        %
        % Class constructor
        % self = this for C++ users (more or less)
        %
        % Use 'varargin' to initialize objects in many ways
        %
        % obj = halley_class();
        % obj = halley_class(tol);
        % obj = halley_class(tol, max_iter);
        % obj = halley_class(tol, max_iter, verbose);
        %
        function self = halley_class(varargin)
            % Set default values
            self.tol      = 1e-8;
            self.max_iter = 100;
            self.verbose  = 'iter';

            if nargin > 0
                %
                % We should require to check the input to be correct, 1
                % real number > 0, etc.
                %
                self.tol = varargin{1};
            end
            if nargin > 1
                self.max_iter = varargin{2};
            end
            if nargin > 2
                self.verbose = varargin{3};
            end
        end
        %
        function set_tolerance(self, tol)
            self.tol = tol;
        end
        %
        function set_max_iter(self, max_iter)
            self.tol = max_iter;
        end
        %
        function set_verbose(self, verbose)
            self.tol = verbose;
        end
        %
        function iter = get_iter(self)
            iter = self.iter;
        end
        %
        % Store the function f and its derivative in the class
        %
        function setup(self, fun, Dfun, DDfun)
            self.fun   = fun;
            self.Dfun  = Dfun;
            self.DDfun = DDfun;
        end
        %
        % Declare the methods solver without implementation.
        % The implementation is in the file solve.m in the same directory.
        %
        x = solve(self, fun, Dfun, DDfun, x0)
    end
end

