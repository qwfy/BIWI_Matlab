Matlab code to parse the BIWI dataset.

This is mainly a copy of [Extracting Data from BIWI Head pose data base into Matlab (Full)](https://www.mathworks.com/matlabcentral/fileexchange/38219-extracting-data-from-biwi-head-pose-data-base-into-matlab-full)
by Soumitry J Ray.

Changes are:

- Use "Version 3" of the [dataset on kaggle](https://www.kaggle.com/datasets/kmader/biwi-kinect-head-pose-database)
- Adapt it to Matlab R2022a
- Run in parallel (with the plot functionality disabled)
- Change the `zThresh` in the original code from `3` to `3000`

Usage:

- Search for the hard-coded string `/mnt/large/dataset/Biwi/` and replace it accordingly
- cd to this directory in matlab
- run `compile_mex`
- run `main`

Note:

- `rotz(gt_ang(3)) * roty(gt_ang(2)) * rotx(gt_ang(1)) == faces_0/xx/_pose.txt(1:3, 1:3)`