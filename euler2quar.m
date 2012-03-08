function [quaternion] = euler2quar(euler_angles)
  % [phi theta psi] = euler_angles
  euler_angles = euler_angles / 180 * pi;

  [m n] = size(euler_angles);
  if n > 3
    disp(['error']);
    return;
  end

  phi_2   = euler_angles(:,1)/2;
  sin_phi_2 = sin(phi_2);
  cos_phi_2 = cos(phi_2);

  if n >= 2
    theta_2 = euler_angles(:,2)/2;
    sin_theta_2 = sin(theta_2);
    cos_theta_2 = cos(theta_2);
  else
    sin_theta_2 = zeros(m, 1);
    cos_theta_2 = ones(m, 1);
  end
  
  if n >= 3
    psi_2   = euler_angles(:,3)/2;
    sin_psi_2 = sin(psi_2);
    cos_psi_2 = cos(psi_2);
  else
    sin_psi_2 = zeros(m, 1);
    cos_psi_2 = ones(m, 1);
  end

  quaternion = [ (cos_phi_2.*cos_theta_2.*cos_psi_2 + sin_phi_2.*sin_theta_2.*sin_psi_2) ...
                 (sin_phi_2.*cos_theta_2.*cos_psi_2 - cos_phi_2.*sin_theta_2.*sin_psi_2) ...
                 (cos_phi_2.*sin_theta_2.*cos_psi_2 + sin_phi_2.*cos_theta_2.*sin_psi_2) ...
                 (cos_phi_2.*cos_theta_2.*sin_psi_2 - sin_phi_2.*sin_theta_2.*cos_psi_2)];
