function plot_headloc(pt_cld,gt_data, dep_intrinsic, frame_id)

imagesc(pt_cld.z), hold on,
% xpix = ((x*dep_intr(1))/z)+dep_intr(2)
xpix = ( gt_data.gt_loc(1,frame_id)*dep_intrinsic(1) ...
        /gt_data.gt_loc(3,frame_id) )+ dep_intrinsic(3);
    
% ypix = ((y*dep_intr(5))/z)+dep_intr(6)    
ypix = ( gt_data.gt_loc(2,frame_id)*dep_intrinsic(5) ...
        /gt_data.gt_loc(3,frame_id) )+ dep_intrinsic(6);
   
rectangle('Position',[xpix-5,ypix-5,10,10],...
          'FaceColor','y'), 

drawnow,