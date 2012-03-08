function [cut_frame] = ppca_segment(X_total)
  tau = 0.95;

  [frame_num n] = size(X_total);
  cut_frame = frame_num;

  Delta = 10;
  T = 150;
  K = T;  
  R = 15; % threshold

  H = zeros(frame_num, 1);

  if (frame_num < T)
    return;
  end

  proj_error = zeros(frame_num, 1);
  delta_error = zeros(frame_num, 1);

  d_mean = zeros(frame_num, 1);
  d_std  = zeros(frame_num, 1);

  % fit r with first K frames
 % X_mean = mean(X_total(1:K,:));
  X_mean = mean(X_total);
  Xfit = X_total(1:K, :) - ones(K,1) * X_mean;
  [U S V] = svd(Xfit, 0);

  r = 1;
  while Er(diag(S),r) < tau
    r = r + 1;
  end
  disp(r);
  
  % ppca part
  diagS = diag(S);

  avg_square_discard = mean(diagS(r+1:n) .* diagS(r+1:n));

  W = V(:,1:r) * sqrt( S(1:r,1:r)^2 - avg_square_discard*eye(r));
  C = (W*W' + avg_square_discard*eye(n))/(frame_num-1);
  invC = inv(C);

  for K = T:Delta:frame_num
    if (K+T > frame_num)
      break;
    end
    X_T = X_total(K+1:K+T,:);
    X_zero_mean = X_T - ones(T,1)*X_mean;
    H(K) = trace( X_zero_mean*invC*X_zero_mean' )/T;
  end

  index = T:Delta:frame_num;
  plot(index, H(index));

end
