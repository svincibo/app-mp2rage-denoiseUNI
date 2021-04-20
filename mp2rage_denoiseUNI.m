function [] = mp2rage_denoiseUNI()

% app-mp2rage-denoiseUNI

% Denoises an MP2RAGE_UNI image based on a user-provided regularization
% parameter.

% app-mp2rage-selectregparam can be used to help select a regularization
% parameter that is appropriate for your dataset.

% Setup environment.
if ~isdeployed
    
    addpath(genpath('nii_func'));
    addpath(genpath('func'));
    
end

% Read in config.json.
config = jsondecode(fileread('config.json'));

%% Regularization parameter.

% Check that the user entered something for the regularization parameter.
if isempty(config.reg_param)
    error('You must enter a regularization parameter. If you are unsure what number to select, consider using app-mp2rage-selectregparam.')
end

%% MP2RAGE data.

% UNI.
MP2RAGE.filenameUNI = config.unit1;

% INV1.
MP2RAGE.filenameINV1 = config.mag_inv1;

% INV2.
MP2RAGE.filenameINV2 = config.mag_inv2;

% Assign output file name.
MP2RAGE.filenameOUT=fullfile('output', 'unit1.nii');

%% DENOISE.
[MP2RAGEimgRobustPhaseSensitive]=RobustCombination(MP2RAGE, str2num(config.reg_param));


% Save image for qa.
saveas(gcf, fullfile('output', 'qa.png'));

% Copy over mag.inv1.nii.gz and mag.inv1.nii.gz from input to output.
copyfile(config.mag_inv1, fullfile('output', 'mag.inv1.nii.gz'));
% copyfile( ---- json ----, fullfile('output', 'mag.inv2.json'));

copyfile(config.mag_inv2, fullfile('output', 'mag.inv2.nii.gz'));
% copyfile( ---- json ----, fullfile('output', 'mag.inv2.json'));


