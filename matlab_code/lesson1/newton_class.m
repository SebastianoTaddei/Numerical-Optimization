%
% Declare the new class 'newton_class' that implements the Newton
% method.
% Properties:
%  - fun      = 'pointer' to the function f(x);
%  - Dfun     = 'pointer to the function f'(x) (the derivative);
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
classdef newton_class < handle

    % Properties set to read only and hid from the user (unless they know
    % their names and that they exist)
    properties (SetAccess = private, Hidden = true)
        fun
        Dfun
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
        % obj = newton_class();
        % obj = newton_class(tol);
        % obj = newton_class(tol, max_iter);
        % obj = newton_class(tol, max_iter, verbose);
        %
        function self = newton_class(varargin)
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
        function setup(self, fun, Dfun)
            self.fun  = fun;
            self.Dfun = Dfun;
        end
        %
        % Solve the problem f(x) = 0 starting from point x0
        %
        function x = solve(self, fun, Dfun, x0)
            self.setup(fun, Dfun);

            self.flag = false; % by default no convergence
            x         = x0;    % initial approximation

            fprintf("<strong>Starting Newton solver.</strong>\n");
        
            for iter = 1:self.max_iter
                fx  = feval(self.fun, x);  % compute f(x)
                Dfx = feval(self.Dfun, x); % compute f'(x)
        
                if abs(Dfx) == 0 % avoid division by 0
                    if self.verbose == 'iter'
                        fprintf("Found f'(x) = 0.\n");
                    end
                    break;
                end
                
                % Perform Newton step
                x = x - fx/Dfx;
        
                % Check convergence
                if abs(fx) <= self.tol
                    if self.verbose == 'iter'
                        fprintf('iter=%2d x=%g f(x)%g\n', iter, x, fx);
                        fprintf('Convergenced reached at iter %d.\n', iter);
                    end
                    self.flag = true;
                    break;
                end
                if self.verbose == 'iter'
                    fprintf('iter=%2d x=%g f(x)%g\n', iter, x, fx);
                end
            end
            self.iter   = iter;
            self.x_last = x;
        end
    end
end

