% Before running the main.m file, first compile all the mex files by
% executing the following command 'run compile_mex' in the Command Window

% - Get the directories
addpath('_utils');
[dirs] = get_dir();


%% Loop through all the foldersIDs
fID = 1; fIDmax = 3;

while(fID <= fIDmax)

    % - get the folder name
    d_name = fID2Dir(fID);
    fprintf('\n**********************************\n')
    fprintf('[Info] Processing folder ID: %s\n', d_name)
    
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
        for frame_id = 1:1:10%n_frames
            
            fprintf('[Info] Processing frame: %s\n', f_names.depth(frame_id,:))
            
            % - Get the mask and pt_cld data
            % mask is the binary face mask and pt_cld.x pt_cld.y and 
            % pt_cld.z are 480 x 640 matrices containing point cloud in mm
            [mask, pt_cld] = get_maskndepth(dep_intrinsic, dirs, d_name, f_names, frame_id );
            
            % - plot head location and orientation
            plot_pose(pt_cld,gt_data,dep_intrinsic,frame_id);
         
            % Now you can use the mask and pt_cld data in your algorithm
                        
        end
    
    else
       fprintf('[Warning] Folder %s does have corresponding depth and mask @ frame id: %.5d.\n',d_name, frame_id)
       fprintf('[Warning] Ignored folder ID %s.\n',d_name)
    end
    
    % - Move to the next folderID
    fID = fID+1;
end
