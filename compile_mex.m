% Compile all the mex files
disp('Started compiling mex files.')

disp('Compiling: mxReadDepthFile.cpp.')
mex mxReadDepthFile.cpp

disp('Compilation successful.')