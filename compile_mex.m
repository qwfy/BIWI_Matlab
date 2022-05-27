% Compile all the mex files
disp('Started compiling mex files.')

disp('Compiling: mxReadDepthFile.cpp.')
mex -R2018a mxReadDepthFile.cpp

disp('Compilation successful.')