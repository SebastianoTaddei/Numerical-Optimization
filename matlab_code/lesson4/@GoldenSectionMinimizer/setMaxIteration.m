%
% Change the default maximum number of iterations
%
function setMaxIteration( self, max_iter )
  if length(max_iter) > 1 || ~isinteger(max_iter)
    error('GoldenSectionMinimizer:setMaxIteration, expected a scalar  integer\n');
  end
  if max_iter < 0 || max_iter > 10000
    error('GoldenSectionMinimizer:setMaxIteration, bad number of iterator %d\n',max_iter);
  end
  self.max_iter = max_iter;
end

