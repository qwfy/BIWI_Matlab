function [mask,pt_cld] = get_maskndepth(dep_intrinsic, dirs, d_name, f_names, frame_id )

% load mask
cd(dirs.m_dir);
cd(d_name);
mask = logical(imread(f_names.mask{frame_id, 1},'png'));

% load depth and rgb
cd(dirs.d_dir);
cd(d_name);

pt_cld = struct;
zThresh = 3000.0;
% read the point cloud
[pt_cld.x, pt_cld.y, pt_cld.z] = mxReadDepthFile(f_names.depth{frame_id, 1}, dep_intrinsic, zThresh);

% read the rgb frames
pt_cld.rgb = imread(f_names.rgb{frame_id, 1},'png');

% move to the working directory
cd(dirs.w_dir);