%
% Change the default tolerance
%
function setTolerance( self, tol )
  if tol <= 0
    error('GoldenSectionMinimizer:setTolerance, bad tolerance %g\n',tol);
  end
  self.tol = tol;
end