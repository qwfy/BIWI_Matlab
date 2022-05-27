function [success] = validate_data (f_names,n_frames, gt)

% This function checks whether or not for every frame # there exists a
% depth frame, a mask frame and a ground truth frame.

for frame_id = 1:1:n_frames
    d_name = f_names.depth{frame_id, 1};
    m_name = f_names.mask{frame_id, 1};
    gt_name = gt.fnames(frame_id,:);
    
    % - get the depth frame number
    [~,b]=strtok(d_name,'_');
    [d_framenum]=strtok(b,'_');
    
    % - get the mask frame number
    [~,q]=strtok(m_name,'_');
    [m_framenum]=strtok(q,'_');
    
    % - get the gt frame number
    [~,n]=strtok(gt_name,'_');
    [gt_framenum]=strtok(n,'_');
    
    success1 = strcmp(d_framenum,m_framenum);
    success2 = strcmp(d_framenum,gt_framenum);

    success = success1 & success2;
    
    if(~success1) 
        fprintf('[Error] Match failed for depth image frame: %s with mask frame',d_framenum)
        return;
    end
    if(~success2) 
        fprintf('[Error] Match failed for depth image frame: %s with groundtruth frame',d_framenum)
        return;
    end
end

disp('[Info] Database frame# OK')