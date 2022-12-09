% Define some test functions
TESTS = {
  {[ 0.1;  0.1], [ 0.2, 0; 0, 0.2], @(x) x.^2}, ...
  {[-0.1;  0.1], [ 0.2, 0; 0, 0.2], @(x) x.^2}, ...
  {[-0.1;  0.1], [-0.2*cos(0.2^2), 0; 0,  0.2*cos(0.2^2)], @(x) sin(x.^2)}, ...
  {[ 0.1; -0.1], [ 0.2*cos(0.2^2), 0; 0, -0.2*cos(0.2^2)], @(x) sin(x.^2)}
};

% Instantiate the object
BM = BroydenMethod();

% Minimize all test functions
for i = 1:length(TESTS)
    % Unpack problem variables
    x0  = TESTS{i}{1};
    A0  = TESTS{i}{2};
    fun = TESTS{i}{3};

    % Minimize the function
    BM.minimize_classical(fun, x0, A0);
    BM.minimize_alternative(fun, x0, A0);
    BM.minimize_inverse(fun, x0, A0);
    BM.minimize_low_memory(fun, x0, A0);
end