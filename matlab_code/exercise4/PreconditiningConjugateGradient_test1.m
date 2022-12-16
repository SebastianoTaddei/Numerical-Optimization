% Generate random tests

test_num = 100;               % number of tests
max_dim  = 100;               % maximum dimension of the problem
TESTS    = cell(test_num, 1); % initialise test container

for i = 1:test_num
    % Create the random nxn SPD matrix A
    n = randi(max_dim); % random dimension of at most max_dim
    A = rand(n, n);     % random nxn matrix
    A = 0.5*(A + A');   % random symmetric nxn matrix
    A = A + n*eye(n);   % random SPD nxn matrix

    % Create the random nx1 vector b
    b = rand(n, 1);

    % Create the random nx1 vector x0
    x0 = rand(n, 1);

    % Fill container
    TESTS{i} = {A, b, x0};
end

% Instantiate object
PCG = PreconditioningConjugateGradient();

% Set parameters
PCG.set_verbose(false);

% Minimize systems
for i = 1:length(TESTS)
    x = PCG.minimize(TESTS{i}{1}, TESTS{i}{2}, TESTS{i}{3});
    
    % Check with linsolve
    err = norm(x - linsolve(TESTS{i}{1}, TESTS{i}{2}));
    fprintf('The norm of the difference between PCG and linsolve is: %e.\n', err);
end
