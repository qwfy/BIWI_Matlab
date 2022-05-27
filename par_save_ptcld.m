function par_save_ptcld(face_output_dir, img_stem, pt_mask, pt_cld)
    filePath = fullfile(face_output_dir, sprintf("%s_ptcld.mat", img_stem));
    save(filePath, 'pt_mask', 'pt_cld');
end