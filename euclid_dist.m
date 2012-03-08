function [dist] = euclid_dist(x1, x2)
  if size(x1,2) == 1
    dist = sqrt((x1-x2)'*(x1-x2));
  else
    dist = sqrt((x1-x2)*(x1-x2)');
  end
