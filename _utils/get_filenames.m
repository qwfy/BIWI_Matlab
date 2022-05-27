function [f_names,n_frames] = get_filenames(dirs, d_name)

   f_names = struct ;
   cd(dirs.d_dir); cd(d_name);
   
   % read the depth file names
   f_names.depth = wildcard_files('*.bin');
   % fix for the incorrect data
   if d_name == "01"
       f_names.depth = f_names.depth(2:end, :);
   end
   n_dframes = size(f_names.depth,1);
   
   % read the rgb filenames
   f_names.rgb = wildcard_files('*.png');
   if d_name == "01"
       f_names.rgb = f_names.rgb(2:end, :);
   end
   n_rgbframes = size(f_names.rgb,1);
   cd(dirs.w_dir);
    
   cd(dirs.m_dir); cd(d_name);
   
   % read the mask filenames
   f_names.mask = wildcard_files('*.png') ;
   n_mframes = size(f_names.mask,1);
   
   cd(dirs.w_dir);

   if (n_dframes ~= n_rgbframes )
       fprintf('[Error] Unequal number of depth and rgb frames\n')
       return,
   end
   
   if (n_dframes ~= n_mframes )
       fprintf('[Error] Unequal number of depth and mask frames\n')
       return,
   end
   
   n_frames = n_dframes;
   fprintf('[Info] Finished reading depth and mask filenames from folder ID: %s\n',d_name)