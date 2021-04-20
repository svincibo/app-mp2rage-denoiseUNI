
addpath(genpath('nii_func'));
addpath(genpath('func'));

mcc -m -R -nodisplay -d compiled mp2rage_denoiseUNI

disp('compiled')

exit
