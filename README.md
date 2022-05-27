Matlab code to parse the BIWI dataset.

This mainly is a copy of [Extracting Data from BIWI Head pose data base into Matlab (Full)](https://www.mathworks.com/matlabcentral/fileexchange/38219-extracting-data-from-biwi-head-pose-data-base-into-matlab-full)
by Soumitry J Ray.

Changes are:

- Use "Version 3" of the [dataset on kaggle](https://www.kaggle.com/datasets/kmader/biwi-kinect-head-pose-database)
- Adapt it to Matlab R2022a
- Run in parallel (with the plot functionality disabled)
- Change the zThresh in the original code from 3 to 3000

Usage:

- Search for "/mnt/large/dataset/Biwi/" and replace it accordingly
- cd to this directory in matlab
- run `compile_mex`
- run `main`