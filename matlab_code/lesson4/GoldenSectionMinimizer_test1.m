GS = GoldenSectionMinimizer();

TESTS = {
    {0.5, 1.0, @(x) exp(x) + 1./x       }, ...
    {0.5, 2.0, @(x) 5./x + x.*x         }, ...
    {0.8, 2.0, @(x) -5./(x.*(x - 2) + 5)}
    };

for k = 1:length(TESTS)
    fun = TESTS{k}{3};
    a   = TESTS{k}{1};
    b   = TESTS{k}{2};
    x   = a:0.001:b;
    y   = fun(x);
    subplot(3, 1, k);
    plot(x, y, '-r');
    [aa, bb] = GS.minimize(fun, a, b);
    ym = max(fun(a), fun(b));
    y0 = min(fun(aa), fun(bb));
    dy = -max(0.1, ym - y0);
    y0 = y0 + 3*dy;
    GS.plot(y0, dy);
end