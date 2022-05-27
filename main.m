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
fID = 1; fIDmax = 24;

while(fID <= fIDmax)

    % - get the folder name
    d_name = fID2Dir(fID);
    fprintf('\n**********************************\n')
    fprintf('[Info] Processing folder ID: %s\n', d_name)
    
    % - Get the binary mask and depth img file names and ground truth
    [f_names, n_frames] = get_filenames(dirs, d_name);
    filelist_out = fullfile(output_root, "file_list");
    mkdir(filelist_out);
    save(fullfile(filelist_out, sprintf('%s.mat', d_name)), "f_names");

    gt_data = get_groundtruth(dirs, d_name);
    
    % - Check if the groundtruth,depth and mask frame nos correspond to each other
    success = validate_data(f_names, n_frames, gt_data);

    % - Save the gt_data to disk
    ground_truth_out = fullfile(output_root, "groud_truth");
    mkdir(ground_truth_out);
    save(fullfile(ground_truth_out, sprintf("%s.mat", d_name)), "gt_data");
   
    if (success)
        pt_cld_dir = fullfile(output_root, 'point_cloud', d_name);
        mkdir(pt_cld_dir);
        
        % - Get the calibration data
        dep_intrinsic = load_calib(dirs,d_name);
      
        % - Loop through all the images in the folder d_name 
        % setting the upper limit in for loop below to n_frames
        % results in reading all the depth images in XX folder(XX= 01,02,...)
        for frame_id = 1:n_frames
            
            fprintf('[Info] Processing frame: %05d %s %s\n', frame_id, d_name, f_names.depth{frame_id, 1})
            
            % - Get the mask and pt_cld data
            % mask is the binary face mask and pt_cld.x pt_cld.y and 
            % pt_cld.z are 480 x 640 matrices containing point cloud in mm
            [mask, pt_cld] = get_maskndepth(dep_intrinsic, dirs, d_name, f_names, frame_id );
            save(fullfile(pt_cld_dir, sprintf('%05d.mat', frame_id)), "mask", "pt_cld");

            % - plot head location and orientation
            % plot_pose(pt_cld,gt_data,dep_intrinsic,frame_id);
         
            % Now you can use the mask and pt_cld data in your algorithm
                        
        end
    
    else
       fprintf('[Warning] Ignored folder ID %s.\n',d_name)
    end
    
    % - Move to the next folderID
    fID = fID+1;
end
