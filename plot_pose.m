function plot_pose(pt_cld,gt_data,dep_intrinsic,frame_id)

% - plot head loc
% plot_headloc(pt_cld,gt_data, dep_intrinsic, frame_id);

% - get the rotation matrix
rot_mat = yrp2rot(gt_data.gt_ang(:,frame_id));

% - plot head orientation
plot_3d_headorientation(pt_cld, rot_mat);
            