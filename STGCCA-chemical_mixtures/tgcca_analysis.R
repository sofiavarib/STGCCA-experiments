### Get working directory from command line

library(RGCCA)
args <- commandArgs(trailingOnly = TRUE)
setwd(args[1])

dataset <- readRDS("./data/data.rds")
# 2 blocks:
#   dataset$Y: (28 x 13324 x 8) NMR block   (mixtures x chemical shift x gradient levels)
#   dataset$Z: (28 x 168)       LC-MS block (mixtures x features)

X <- dataset$Y$data
Z <- dataset$Z$data

# Load concentrations and remove mixture 27
concentrations <- readRDS("./data/concentrations.rds")
concentrations <- concentrations[-27, ]
normalized_concentrations <- apply(concentrations, 2, function(x) x / norm(x, type = "2"))

### Preprocess according to the paper procedure and center
X <- X / sqrt(sum(X^2))
X <- array(scale(matrix(as.vector(X), nrow = nrow(X)), center = T, scale = F), dim = dim(X))

Z <- scale(Z, center = F, scale = apply(Z, 2, sd, na.rm = TRUE))
Z <- Z / sqrt(sum(Z^2))
Z <- scale(Z, center = T, scale = F)

### Apply TGCCA
n_repeat <- 100



### Run 100 times TGCCA rank 1
print(dim(list(EEM = X, LCMS = Z)))
print(dim(Z))
print(dim(X))

ranks <- matrix(c(2, rep(1, 7)), 4, 2)


for (i in 1:n_repeat) {
 
  start_time <- Sys.time()
  print(i)
  fit_mgcca <- rgcca(blocks = list(EEM = X, LCMS = Z), method = "tgcca",separable=TRUE,
  tau = 1,  verbose = FALSE, scale = FALSE, ncomp = 5, init='random',mode_orth=2,
,rank=c(1,1))


  end_time <- Sys.time()
  duration <- end_time - start_time
  saveRDS(fit_mgcca, file = paste0("./models/TGCCA/", i, ".rds"))
  saveRDS(duration, file = paste0("./models/TGCCA/times/", i, ".rds"))
}

for (i in 1:n_repeat) {
 
  start_time <- Sys.time()
  print(i)
  fit_mgcca <- rgcca(blocks = list(EEM = X, LCMS = Z), method = "stgcca",separable=TRUE,
  sparsity=list(c(0.2,1),1),
  tau = 1,  verbose = FALSE, scale = FALSE, ncomp = 5, init='random',mode_orth=2,
,rank=c(1,1))

  end_time <- Sys.time()
  duration <- end_time - start_time
  saveRDS(fit_mgcca, file = paste0("./models/STGCCA/", i, ".rds"))
  saveRDS(duration, file = paste0("./models/STGCCA/times/", i, ".rds"))
}

