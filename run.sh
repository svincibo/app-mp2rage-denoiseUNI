#!/bin/bash

set -x
set -e

# make a brain mask to use if the user asks us to automatically select the regularization parameter
# the algorithm for selecting the regularization parameter will return an incorrect value if it is fed non-brain voxels

# read in unit1 filepath/filename from config.json
unit1=`jq -r '.unit1' config.json`

# crop
robustfov -i ${unit1} -m roi2full.mat -r unit1.cropped.nii.gz

# get mask
bet unit1.cropped.nii.gz unit1.mask.nii.gz -R
