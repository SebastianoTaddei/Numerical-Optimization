% Test functions
TESTS = {
    {@(x) x(1).^2 + x(2).^2,                                            ... % function
     @(x) [2.*x(1); 2.*x(2)],                                           ... % gradient
     [4.0; -12.0],                                                      ... % starting point
     [0; 0]},                                                           ... % global minimum
    {@(x) ((1.5 - x(1) + x(1).*x(2)).^2                                 ...
          + (2.25 - x(1) + x(1).*x(2).^2).^2                            ...
          + (2.625 - x(1) + x(1).*x(2).^3).^2),                         ...
     @(x) [(2.*x(1).*x(2).^6 + 2.*x(1).*x(2).^4                         ...
           + (5.25 - 4.*x(1)).*x(2).^3 + (-2.*x(1) + 4.5).*x(2).^2      ...
           + (-4.*x(1) + 3).*x(2) - 12.75 + 6.*x(1));                   ...
           ((-2 - 2.*x(2) + 4.*x(2).^3 - 6.*x(2).^2                     ...
           + 6.*x(2).^5).*x(1).^2                                       ...
           + (3 + 9.*x(2) + 15.75.*x(2).^2).*x(1))],                    ...
     [4.0; 1.0],                                                        ...
     [3.0; 0.5]},                                                       ...
    {@(x) 100.*(x(2) - x(1).^2).^2 + (x(1) - 1).^2,                     ...
     @(x) [-2 + 400.*x(1).^3 + (-400.*x(2) + 2).*x(1);                  ...
           -200.*x(1).^2 + 200.*x(2)],                                  ...
     [-1.2; 1.0],                                                       ...
     [1.0; 1.0]}
};

% Instantiate solver
LS = LineSearch();

% Set solver properties
LS.set_verbose(false);
LS.set_max_iter(1e3);

for i = 1:length(TESTS)
    % Unpack data
    fun  = TESTS{i}{1};
    dfun = TESTS{i}{2};
    x0   = TESTS{i}{3};
    sol  = TESTS{i}{4};

    % Minimize
    LS.set_level(1);
    x_ab = LS.minimize(fun, dfun, x0); % Armijo Parabolic-Cubic
    LS.set_level(2);
    x_sw = LS.minimize(fun, dfun, x0); % Strong Wolfe
    LS.set_level(3);
    x_es = LS.minimize(fun, dfun, x0); % Exact search

    % Report results
    fprintf('<strong>------------------------------------</strong>\n');
    fprintf('<strong>Global minimum at x = [%s]:</strong>\n', ...
        join(string(sol), '; '))
    fprintf('<strong> - Armijo Parabolic-Cubic found x = [%s];</strong>\n', ...
        join(string(x_ab), '; '));
    fprintf('<strong> - Strong Wolfe found           x = [%s];</strong>\n', ...
        join(string(x_sw), '; '));
    fprintf('<strong> - Exact search found           x = [%s];</strong>\n', ...
        join(string(x_es), '; '));
end