function [rot_mat] = yrp2rot(gt_angles)

pitch = gt_angles(1);
yaw   = gt_angles(2);
roll  = gt_angles(3);

% See [1] and [2] for rotational transformation

rot_z = [cosd(roll),-sind(roll), 0;
         sind(roll), cosd(roll), 0;
         0        , 0        , 1];

rot_y = [cosd(yaw),0, sind(yaw);
         0          ,1,       0;
         -sind(yaw),0,cosd(yaw)];
     
rot_x = [1,          0,          0;
         0, cosd(pitch),-sind(pitch);
         0, sind(pitch),cosd(pitch)];
rot_mat = rot_z*rot_y*rot_x;

% Reference:
% [1] http://planning.cs.uiuc.edu/node102.html
% [2] http://en.wikipedia.org/wiki/Aircraft_principal_axes
