function [dirs] = get_dir()

dirs = struct;
% Select the working directory
% dirs.w_dir = uigetdir([], 'Select the working directory.');
dirs.w_dir = '/mnt/large/dataset/Biwi/BIWI_Matlab';
pause(0.3);
if (dirs.w_dir == 0)
    return;
end
% - Get the parent directory of compressed binary depth images 
% dirs.d_dir = uigetdir([], 'Select the parent directory of the of .bin Depth Images: "kinect_head_pose_db"');
dirs.d_dir = '/mnt/large/dataset/Biwi/kaggle_version3/faces_0';
if (dirs.d_dir == 0)
    return;
end
pause(0.3);

% - Get the parent directory of the binary masks
% dirs.m_dir = uigetdir([], 'Select the parent directory of the of Binary Masks: "head_pose_masks"');
dirs.m_dir = '/mnt/large/dataset/Biwi/kaggle_version3/head_pose_masks';
if (dirs.m_dir == 0)
    return;
end
pause(0.3);

% - Get the parent directory of the groundtruth
% dirs.gt_dir = uigetdir([], 'Select the parent directory of the of Ground Truth: "db_annotations"');
dirs.gt_dir = '/mnt/large/dataset/Biwi/kaggle_version3/db_annotations';
if (dirs.gt_dir == 0)
    return;
end
pause(0.3);

addpath(dirs.w_dir);
disp('[Info] Obtained all the directories')