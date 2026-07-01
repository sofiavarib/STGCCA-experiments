STGCCA-2D_simulations
==============

R code to generate simulations to test STGCCA and compare it with TGCCA.

## Generate data

To generate data, the script generate.R is used. It generates 100 folds of 100 observations each from the specified shapes, noise structure, signal-to-noise ratio (SNR) and correlations. The data used in the paper was generated running the following command:
Rscript path_to_TGCCA-2D_simulations/generate.R 100 100 SNR 0.8,0.8,0.8,0.8,0.8 square,gas,cross,cross_little,vector path_to_STGCCA-2D_simulations information,parking,restaurant,cup,null
for values of SNR 0.1, 0.3, 0.5, and 1.

## Run and compare models

To help running and comparing different models, the script make_scripts.R has been created.
To generate the scripts that need to be run to reproduce the experiments, the following commands have been run with n = 100 and N = 10000, n = 200 and N = 10000, n = 300 and N = 9900, n = 500 and N = 10000, and n = 1000 and N = 10000; and experiment = 2B;
Rscript path_to_STGCCA-2D_simulations/make_scripts.R n N path_to_STGCCA-2D_simulations experiment

Running the script will create commands, in folder cmd, to run in a shell, that will conduct the analysis.
Results will appear in folder results and final comparisons will appear in folder comparisons. A figure summarizing the comparison for the different SNR levels as well as a table per SNR level are generated.
