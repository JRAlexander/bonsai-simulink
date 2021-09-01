% Copyright (c) Microsoft Corporation.
% Licensed under the MIT License.

% Script to configure assessment of your trained Bonsai brain. Assessment can be
% run in 3 steps:
%   1. run this script to configure an assessment session and set required variables
%   2. open the model and click "Run"
%   3. begin assessmnet in the web, selecting the "Simulink Cartpole" simulator.

%initialize the buses
initModel;

% load model and disable fast restart
mdl = 'cartpole_discrete_api_loop';
load_system(mdl);
set_param(mdl, 'FastRestart', 'off');

% configure assessment
config = bonsaiConfig;
BonsaiApiConfigureAssessment(config, mdl, @episodeStartCallback);

% any initial data required for compilation should go here
initialPos = 0;

% callback for provided episode configuration
function episodeStartCallback(mdl, episodeConfig)
    assignin('base', 'initialPos', episodeConfig.pos);
end
