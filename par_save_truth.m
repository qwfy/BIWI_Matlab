function par_save_truth(face_output_dir, img_stem, gt_ang, gt_loc)
    filePath = fullfile(face_output_dir, sprintf("%s_truth.mat", img_stem));
    save(filePath, 'gt_ang', 'gt_loc');
end