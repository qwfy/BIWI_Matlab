function [gt_data] = get_groundtruth(dirs, d_name)

cd(dirs.gt_dir); cd(d_name);

gt_data = struct;
gt_data.fnames = wildcard_files('*.bin');
gt_data.nframes = size(gt_data.fnames,1);
gt_data.gt_loc = zeros(3,gt_data.nframes);
gt_data.gt_ang = zeros(3,gt_data.nframes);

for frame_id = 1:1:gt_data.nframes
    
    fid = fopen(gt_data.fnames{frame_id, 1}, 'r');
    
    % first triplet is x,y,z head loc, See[1]
    gt_data.gt_loc(:,frame_id) = fread(fid, 3,'float');
    
    % second triplet is the pitch, yaw and roll angles, See[1]
    gt_data.gt_ang(:,frame_id) = fread(fid, 3,'float');
    
    fclose(fid);
    
end

cd(dirs.w_dir);

fprintf('[Info] Finished reading ground truth data from folder ID: %s\n',d_name)

% Reference:
% [1] http://www.vision.ee.ethz.ch/~gfanelli/head_pose/readme.txt
