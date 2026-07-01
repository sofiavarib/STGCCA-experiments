# STGCCA-chemical_mixtures

R code to evaluate STGCCA on real data and compare it with TGCCA from Girka, F., Gloaguen, A., Le Brusquet, L., Zujovic, V., & Tenenhaus, A., CMTF from E. Acar, T. G. Kolda, and D. M. Dunlavy and ACMTF from E. Acar, E. E. Papalexakis, G. Gurdeniz, M. A. Rasmussen, A. J. Lawaetz, M. Nilsson and R. Bro.

The data is the data used to validate ACMTF and is available from this link. As in the original paper describing ACMTF, we use the NMR (Nuclear Magnetic Resonance) spectroscopy and LC-MS (Liquid Chromatography - Mass Spectrometry) blocks. From these two blocks, we aim to retrieve the concentrations of the 5 chemicals used to create the 28 mixtures composing the data.

## Prerequisites
    Matlab, Matlab tensor toolbox, Matlab CMTF toolbox, and Matlab Poblano toolbox.

## Run and compare models

All models were run 100 times with random initialization points. The reported results include means and standard deviations of the cosines between the true chemical concentrations and the estimated ones, the cosines obtained by the models with the best criteria over the multiple runs and the computation times (means and standard deviations).

### Run CMTF and ACMTF

CMTF and ACMTF models were run using the run_cmtf_and_acmtf.m file. To directly run it from command line, you can do
matlab  -nodisplay -nosplash -nodesktop -r "data_path='path_to_TGCCA-chemical_mixtures';run('path_to_TGCCA-chemical_mixtures/run_cmtf_and_acmtf.m');exit()"

### Run STGCCA and TGCCA

Two versions of STGCCA were run, one with a first component of rank 2 and the other one with all components having rank 1. This was done using the tgcca_analysis.R file. To run it from command line, you can do
Rscript path_to_STGCCA-chemical_mixtures/tgcca_analysis.R path_to_STGCCA-chemical_mixtures

## Compile results

To analyse the results, produce table and plots, the compile_results.R file was used:
Rscript path_to_STGCCA-chemical_mixtures/compile_results.R path_to_STGCCA-chemical_mixtures
