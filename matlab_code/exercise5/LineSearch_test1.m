% Test functions
TESTS = {
    ... Easy function to test if everything works
    {@(x) x(1).^2 + x(2).^2,                                            ... % function
     @(x) [2.*x(1); 2.*x(2)],                                           ... % gradient
     [4.0; -12.0],                                                      ... % starting point
     [0; 0]},                                                           ... % global minimum
    ... Beale function
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
    ... Rosenbrock function
    {@(x) 100.*(x(2) - x(1).^2).^2 + (x(1) - 1).^2,                     ...
     @(x) [-2 + 400.*x(1).^3 + (-400.*x(2) + 2).*x(1);                  ...
           -200.*x(1).^2 + 200.*x(2)],                                  ...
     [-1.2; 1.0],                                                       ...
     [1.0; 1.0]},                                                       ...
    ... Booth function
    {@(x) (x(1) + 2.*x(2) - 7).^2 + (2.*x(1) + x(2) - 5).^2,            ...
     @(x) [10.*x(1) + 8.*x(2) - 34;                                     ...
           8.*x(1) + 10.*x(2) - 38],                                    ...
     [7.0; 3.0],                                                        ...
     [1.0; 3.0]},                                                       ...
    ... Matyas function
    {@(x) 0.26.*x(1).^2 + 0.26.*x(2).^2 - 0.48.*x(1).*x(2),             ...
     @(x) [0.52.*x(1) - 0.48.*x(2);                                     ...
           0.52.*x(2) - 0.48.*x(1)],                                    ...
     [-3.0; 4.0],                                                       ...
     [0.0; 0.0]},                                                       ...
    ... Himmelblau's function
    {@(x) (x(1).^2 + x(2) - 11).^2 + (x(2).^2 + x(1) - 7).^2,           ...
     @(x) [4.*(x(1).^2 + x(2) - 11).*x(1) + 2.*x(2).^2 + 2.*x(1) - 14;  ...
           2.*x(1).^2 + 2.*x(2) - 22 + 4.*(x(2).^2 + x(1) - 7).*x(2)],  ...
     [-2.0; 2.0],                                                       ...
     [3.0, -2.80, -3.77, 3.58; 2.0, 3.13, -3.28, -1.85]},               ...
    ... Three-hump camel function
    {@(x) 2.*x(1).^2 - 1.05.*x(1).^4 + 1/6.*x(1).^6 + x(1).*x(2)        ...
          + x(2).^2,                                                    ...
     @(x) [4.*x(1) - 4.20.*x(1).^3 + x(1).^5 + x(2);                    ...
           x(1) + 2.*x(2)],                                             ...
     [-4.0; 1.0],                                                       ...
     [0.0; 0.0]},                                                       ...
    ... Easom function
    {@(x) -cos(x(1)).*cos(x(2)).*exp(-(x(1) - pi).^2 - (x(2) - pi).^2), ...
     @(x) [sin(x(1)).*cos(x(2)).*exp(-(x(1) - pi).^2 - (x(2) - pi).^2)  ...
           - cos(x(1)).*cos(x(2)).*(-2.*x(1)                            ...
           + 2.*pi).*exp(-(x(1) - pi).^2 - (x(2) - pi).^2);             ...
           cos(x(1)).*sin(x(2)).*exp(-(x(1) - pi).^2 - (x(2) - pi).^2)  ...
           - cos(x(1)).*cos(x(2)).*(-2.*x(2) + 2.*pi).*exp(-(x(1)       ...
           - pi).^2 - (x(2) - pi).^2)],                                 ...
     [90.0; -73.0],                                                     ...
     [pi; pi]},                                                         ...
    ... McCormick function
    {@(x) sin(x(1) + x(2)) + (x(1) - x(2)).^2 - 1.5.*x(1) + 2.5.*x(2)   ...
          + 1,                                                          ...
     @(x) [cos(x(1) + x(2)) + 2.*x(1) - 2.*x(2) - 1.5;                  ...
           cos(x(1) + x(2)) - 2.*x(1) + 2.*x(2) + 2.5],                 ...
     [1.0; 0.0],                                                        ...
     [-0.55; -1.55]},                                                   ...
    ... Schaffe function N. 2
    {@(x) 0.5 + (sin(x(1).^2 - x(2).^2).^2 - 0.5)./(1 + 0.001.*x(1).^2  ...
          + 0.001.*x(2).^2).^2,                                         ...
     @(x) [4.*sin(x(1).^2 - x(2).^2).*x(1).*cos(x(1).^2 - x(2).^2)/(1   ...
           + 0.001.*x(1).^2 + 0.001.*x(2).^2).^2 - 0.004.*(sin(x(1).^2  ...
           - x(2).^2).^2 - 0.5).*x(1)./(1 + 0.001.*x(1).^2              ...
           + 0.001.*x(2).^2).^3;                                        ...
           -4.*sin(x(1).^2 - x(2).^2).*x(2).*cos(x(1).^2                ...
           - x(2).^2)./(1 + 0.001.*x(1).^2 + 0.001.*x(2).^2).^2         ...
           - 0.004.*(sin(x(1).^2 - x(2).^2).^2 - 0.5).*x(2)./(1         ...
           + 0.001.*x(1).^2 + 0.001.*x(2).^2).^3],                      ...
     [-4.0; 18.0],                                                      ...
     [0.0; 0.0]}
};

% Instantiate solver
LS = LineSearch();

% Set solver properties
LS.set_verbose(false);
% LS.set_max_iter(1e3);

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
    x_fm = fminunc(fun, x0, ...        % fminunc
        optimoptions('fminunc', 'Display', 'off'));

    % Report results
    fprintf('<strong>------------------------------------</strong>\n');
    fprintf('<strong>Global minimum at x = [%s]:</strong>\n', ...
        join(string(sol'), '; '))
    fprintf('<strong> - Armijo Parabolic-Cubic found x = [%s];</strong>\n', ...
        join(string(x_ab), '; '));
    fprintf('<strong> - Strong Wolfe found           x = [%s];</strong>\n', ...
        join(string(x_sw), '; '));
    fprintf('<strong> - Exact search found           x = [%s];</strong>\n', ...
        join(string(x_es), '; '));
    fprintf('<strong> - fminunc found                x = [%s];</strong>\n', ...
        join(string(x_es), '; '));
end
