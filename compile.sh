#!/bin/bash

# compiled with MATLAB R2019b 10.14.6
rm -rf compiled
mkdir -p compiled

cat > build.m <<END

addpath(genpath('nii_func'));
addpath(genpath('func'));

mcc -m -R -nodisplay -d compiled mp2rage_denoiseUNI.m
disp('compiled')
exit
END

/Applications/MATLAB_R2019b.app/bin/matlab -nodisplay -nosplash -r build
