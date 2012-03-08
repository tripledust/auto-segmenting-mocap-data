%function [cut_frames] = project(mat)
  close all;
  % based on the paper
  % only retain 14 joints out of total 29 joints
  % dimension for each joint
  dims =[6 3 3 3 3 3 3 2 3 1 1 2 1 2 2 3 1 1 2 1 2 3 1 2 1 3 1 2 1];
  % start location for each joint
  locations = [1 7 10 13 16 19 22 25 27 30 31 32 34 35 37 39 42 43 44 46 47 49 52 53 55 56 59 60 62];
  retain = [7:24 27:30 39:42 49:52 56:59];

  % retain and convert 14 joints to quaternion
  % 14 joints x 4 (quaternion) per joint = 56-d vector
  X = [euler2quar(mat(:, 7: 9)) euler2quar(mat(:,10:12)) euler2quar(mat(:,13:15)) ...
       euler2quar(mat(:,16:18)) euler2quar(mat(:,19:21)) euler2quar(mat(:,22:24)) ...
       euler2quar(mat(:,27:29)) euler2quar(mat(:,   30)) euler2quar(mat(:,39:41)) ...
       euler2quar(mat(:,42   )) euler2quar(mat(:,49:51)) euler2quar(mat(:,52   )) ...
       euler2quar(mat(:,56:58)) euler2quar(mat(:,59   ))];
  
  % different kind of algorithm
  [m n] = size(X);
  start_pt = 1;

  cut_frames = [];
  last_cut_frame = 0;
  while 1
    Xpart = X(start_pt:m,:);
    cut_frame = pca_segment(Xpart);
    cut_frames = [cut_frames start_pt+cut_frame-1];
    start_pt = start_pt + cut_frame;
    if(start_pt>=m)
      break;
    end
  end

  % output cut frames
  cut_frames

  % store cut frames back to .amc
  disp(['========== storing ============']);
  start_pt = 1;
  for i = 1:length(cut_frames)
    matrix_to_amc(['./data/mat' int2str(i) '.amc'], mat(start_pt:cut_frames(i),:));
    start_pt = cut_frames(i)+1;
  end

  % amc player
