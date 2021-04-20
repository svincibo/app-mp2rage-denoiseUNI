#!/bin/bash
module load matlab/2019a

mkdir -p compiled

log=compiled/commit_ids.txt
true > $log
echo "/N/u/brlife/git/jsonlab" >> $log
(cd /N/u/brlife/git/jsonlab && git log -1) >> $log

cat > build.m <<END
addpath(genpath('/N/u/brlife/git/jsonlab'))
mcc -m -R -nodisplay -d compiled mp2rage_denoiseUNI.m
exit
END
matlab -nodisplay -nosplash -r build
