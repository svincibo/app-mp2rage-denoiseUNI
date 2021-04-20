#!/bin/bash

# compiled with MATLAB R2020a
rm -rf compiled
mkdir -p compiled

cat > build.m <<END

addpath(genpath('nii_func'));
addpath(genpath('func'));

mcc -m -R -nodisplay -d compiled mp2rage_denoiseUNI

disp('compiled')

exit
END

matlab -nodisplay -nosplash -r build
