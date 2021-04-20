function [] = mp2rage_denoiseUNI()

% app-mp2rage-denoiseUNI

% Denoises an MP2RAGE_UNI image based on a user-provided regularization
% parameter.

% app-mp2rage-selectregparam can be used to help select a regularization
% parameter that is appropriate for your dataset.

% Setup json lab.
% if ~isdeployed
%     
%     addpath(genpath('/N/u/brlife/git/jsonlab'));
%     
% end

addpath(genpath('func'));
addpath(genpath('nii_func'));

% Read in config.json.
config = loadjson('config.json');

%% Regularization parameter.
% Check that the user entered something for the regularization parameter.
if isempty(config.reg_param)
    error('You must enter a regularization parameter. If you are unsure what number to select, consider using app-mp2rage-selectregparam.')
end

%% MP2RAGE data.

% UNI.
MP2RAGE.filenameUNI = config.mag_unit1;

% INV1.
MP2RAGE.filenameINV1 = config.mag_inv1;

% INV2.
MP2RAGE.filenameINV2 = config.mag_inv2;

% Assign output file name.
MP2RAGE.filenameOUT=fullfile('output', ['MP2RAGE_denoised_reg' config.reg_param '.nii.gz']);

%% DENOISE.
[MP2RAGEimgRobustPhaseSensitive]=RobustCombination(MP2RAGE, double(reg_param));

% Save image for qa.
saveas(gcf, fullfile('output', 'MP2RAGE_denoised.png'));



