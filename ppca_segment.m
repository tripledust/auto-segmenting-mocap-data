function [cut_frame] = pca_segment(X_total)
  tau = 0.9;

  frame_num = size(X_total, 1);
  cut_frame = frame_num;

  k = 240;  % window size
  l =  60;

  i = k;
  i0 = k + l;

  if (frame_num < i0)
    return;
  end

  proj_error = zeros(frame_num, 1);
  delta_error = zeros(frame_num, 1);

  d_mean = zeros(frame_num, 1);
  d_std  = zeros(frame_num, 1);

  % fit r with first k frames
  X_mean = mean(X_total(1:k,:));
  Xfit = X_total(1:k, :) - ones(k,1) * X_mean;
  [U S V] = svd(Xfit, 0);

  r = 4;
  while Er(diag(S),r) < tau
    r = r + 1;
  end
%  disp(r);

  % svd for every frame
  for i = k: frame_num
    X = X_total(1:i,:);

    [m, n] = size(X);
    D = X - ones(m,1) * mean(X);
    [U S V] = svd(D,0);

    proj_error(i) = project_error(diag(S), r);
    delta_error(i) = proj_error(i) - proj_error(i-l);

    d_mean(i) = mean(delta_error(k:i));
    d_std(i) = std(delta_error(k:i));

    if ( i > i0 && (delta_error(i) > d_mean(i) + 3 * d_std(i)) )
      cut_frame = i;
      break;
    end
  end % end of i

%  index = k:i;
%  figure(1);
%  hold on;
%  plot(index, delta_error(index),'-b');
%  plot(index, d_mean(index), ':r');
%  legend('derivative error', 'mean');
%  plot(index, d_mean(index)+d_std(index), ':m');
%  plot(index, d_mean(index)-d_std(index), ':m');
%  plot(index, d_mean(index)+3*d_std(index), ':g');
%  plot(index, d_mean(index)-3*d_std(index), ':g');
%  axis([0 i 0 max(d_mean + 3*d_std)]);
end
