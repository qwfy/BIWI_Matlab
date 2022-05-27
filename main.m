% Before running the main.m file, first compile all the mex files by
% executing the following command 'run compile_mex' in the Command Window

% - Get the directories
addpath('_utils');
[dirs] = get_dir();

warning('off', 'MATLAB:MKDIR:DirectoryExists');

output_root = '/mnt/large/dataset/Biwi/BIWI_Matlab_Output/';
fprintf('Output will be written to %s\n', output_root);
mkdir(output_root);


%% Loop through all the foldersIDs
fIDmin = 1; fIDmax = 24;

parfor fID=fIDmin:fIDmax

    % - get the folder name
    d_name = fID2Dir(fID);
    fprintf('\n**********************************\n')
    fprintf('[Info] Processing folder ID: %s\n', d_name)

    face_output_dir = fullfile(output_root, d_name);
    mkdir(face_output_dir);
    
    % - Get the binary mask and depth img file names and ground truth
    [f_names, n_frames] = get_filenames(dirs, d_name);

    gt_data = get_groundtruth(dirs, d_name);
    
    % - Check if the groundtruth,depth and mask frame nos correspond to each other
    success = validate_data(f_names, n_frames, gt_data);
   
    if (success)
        % - Get the calibration data
        dep_intrinsic = load_calib(dirs,d_name);
      
        % - Loop through all the images in the folder d_name 
        % setting the upper limit in for loop below to n_frames
        % results in reading all the depth images in XX folder(XX= 01,02,...)
        for frame_id = 1:n_frames
            
            fprintf('[Info] Processing frame: %s %05d %s\n', d_name, frame_id, f_names.depth{frame_id, 1});
            
            % - Get the mask and pt_cld data
            % mask is the binary face mask and pt_cld.x pt_cld.y and 
            % pt_cld.z are 480 x 640 matrices containing point cloud in mm
            [mask, pt_cld] = get_maskndepth(dep_intrinsic, dirs, d_name, f_names, frame_id);

            % - plot head location and orientation
            % plot_pose(pt_cld,gt_data,dep_intrinsic,frame_id);
         
            % Now you can use the mask and pt_cld data in your algorithm

            % Save the result

            % frame_00000
            [~, img_stem, ~] = fileparts(f_names.depth{frame_id, 1});
            img_stem = split(img_stem, '_');
            img_stem = sprintf("%s_%s", img_stem{1, 1}, img_stem{2, 1});

            gt_ang = gt_data.gt_ang(:, frame_id);
            gt_loc = gt_data.gt_loc(:, frame_id);
            % save(fullfile(face_output_dir, sprintf("%s_truth.mat", img_stem)), "gt_ang", "gt_loc");
            % save(fullfile(face_output_dir, sprintf("%s_ptcld.mat", img_stem)), "mask", "pt_cld");
            par_save_truth(face_output_dir, img_stem, gt_ang, gt_loc);
            par_save_ptcld(face_output_dir, img_stem, mask, pt_cld);
        end
    
    else
       fprintf('[Warning] Ignored folder ID %s.\n',d_name)
    end
end
