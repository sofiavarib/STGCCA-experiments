rm(list = ls())

### Get args from command line
args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 4) {
  stop("Number of subjects per fold/Total number of subjects/Root path/Experiment")
} else {
  N <- as.numeric(args[1])
  N_total <- as.numeric(args[2])
  root_path <- args[3]
  experiment <- args[4]
}


SNR_levels <- c(0.1, 0.3, 0.5, 1)
if (experiment == "2B") {
  shapes <- c("gas", "cross_little")
  block_names <- c("Gas", "Cross (small)")
  models <- c(
    "stgcca","tgcca","stgcca3","tgcca3"
  )
  names <- c(
    "stgcca","tgcca","stgcca3","tgcca3"
  )
  params <- vector("list", length = length(models))
  params[[1]] <- list() # 2DCCA1
} 

ref_shapes <- c("square", "gas", "cross", "cross_little", "vector")
blocks <- match(shapes, ref_shapes)

fileConn <- file(paste0(root_path, "/cmd/", experiment, "_", N, ".txt"), "w")
full_names <- list()

for (i in 1:length(models)) {
  full_names[[i]] <- paste0(names[i], "_B", paste(blocks, collapse = ""), "_", N)
  for (SNR in SNR_levels) {
    writeLines(paste0(
      "Rscript ",
      root_path,
      "/run.R ",
      N,
      " ",
      N_total,
      " ",
      SNR,
      " ",
      paste(blocks, collapse = ","),
      " ",
      models[i],
      " ",
      root_path,
      " ",
      full_names[[i]],
      " ",
      paste(params[[i]], collapse = " ")
    ), fileConn)
  }

  writeLines(paste0(
    "Rscript ",
    root_path,
    "/analyse.R ",
    paste(blocks, collapse = ","),
    " ",
    root_path,
    " ",
    full_names[[i]],
    "\n"
  ), fileConn)
}

writeLines(paste0(
  "Rscript ",
  root_path,
  "/compare.R ",
  paste(shapes, collapse = ","),
  " ",
  paste(SNR_levels, collapse = ","),
  " ",
  root_path,
  " ",
  paste(full_names, collapse = ","),
  " ",
  paste(names, collapse = ","),
  " ",
  "\"", paste(block_names, collapse = ","), "\""
), fileConn)

close(fileConn)
