function [a,b] = minimize( self, fun, a_in, b_in )
  % Reorder a and b such that b > a
  a = min(a_in,b_in);
  b = max(a_in,b_in);
  %
  % Initialize history
  %
  self.history = [a; b];
  % Early exit, check tolerance
  if b - a <= self.tol
    return;
  end
  %
  % Build the sub intervals [a mu] and [lambda b] 
  %
  %            c = (a + b)/2
  % |------+---|---+-------|
  % a    lambda    mu      b
  %
  % Compute the length of the subintervals [golden section * length]
  dlen   = self.tau*(b - a);
  % Compute the edges of the subintervals
  lambda = b - dlen;
  mu     = a + dlen;
  % Compute values at lambda and mu
  fl     = feval(fun, lambda);
  fm     = feval(fun, mu);
  %
  for k=1:self.max_iter
    % Early exit, check tolerance
    if b - a <= self.tol
      break;
    end

    % Compute the new legnth of the interval
    dlen   = dlen*self.tau;

    if fl > fm
      % Select interval [lambda, b] --> fl > fm <= fb
      %
      % The new interval is [a, b] <- [lambda, b] 
      a = lambda;
      %
      % Compute the next lambda and mu with f(lambda) and f(mu)
      lambda = mu;
      fl     = fm;
      mu     = a + dlen;
      fm     = feval(fun, mu);
    else
      % Select interval [a, mu] --> fa >= fl <= fm
      %
      % The new interval is [a, b] <- [a, mu] 
      b = mu;
      %
      % Compute the next lambda and mu with f(lambda) and f(mu)
      mu     = lambda;
      fm     = fl;
      lambda = b - dlen;
      fl     = feval(fun, lambda);
    end
    self.history = [self.history, [a; b]];
  end
end