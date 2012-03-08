function [dist] = euclid_dist_square(x1, x2)
  if size(x1,2) == 1
    dist = (x1-x2)'*(x1-x2);
  else
    dist = (x1-x2)*(x1-x2)';
  end
