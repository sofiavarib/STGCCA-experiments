parse_param <- function(param, type = NULL) {
  if (type == "bool") {
    return(param == "T" || param == "TRUE")
  }
  if (type == "num_vec") {
    return(as.numeric(strsplit(param, ",")[[1]]))
  }
  return(param)
}
run_stgcca <- function(dataset, raw_params = NULL, root_path = NULL, seed = 0, random_init = FALSE) {
  params <- list(rank = 2, tau = 0.001, scale_block = F, scheme = "horst", scale = F)
  mapping <- c("rank", "tau", "scale_block", "scheme", "scale")
  param_type <- c("num_vec", "num_vec", "bool", "string", "bool")
  if (!is.null(raw_params)) {
    for (i in 1:length(raw_params)) {
     
      if (!is.na(mapping[i])){
      params[[mapping[i]]] <- parse_param(raw_params[i], param_type[i])

      }
    }
  }
  #params[["NA_method"]]='na.omit'
  params[["blocks"]] <- dataset$X
  params[["n_run"]] <- 10


  #print(dataset$X[[1]])

  params[["method"]] <- "stgcca"
  
  params[["sparsity"]]<- list(c(1,0.8),c(1,0.8))
  # params[["sparsity"]]<- list(c(1,1),c(1,1))
  params[["tau"]]<-1
  params[["rank"]] <- 1


  params[["separable"]]<- TRUE
  params[["connection"]]<-1 - diag(length(dataset$X))
  #print(params)
  
  params[["scale_block"]] <- TRUE

  
  params[["scale"]] <- FALSE

  fit_mgcca <- do.call(rgcca, params)
  return(list(a = fit_mgcca$astar))
}
run_tgcca <- function(dataset, raw_params = NULL, root_path = NULL, seed = 0, random_init = FALSE) {
  params <- list(rank = 2, tau = 0.001, scale_block = F, scheme = "horst", scale = F)
  mapping <- c("rank", "tau", "scale_block", "scheme", "scale")
  param_type <- c("num_vec", "num_vec", "bool", "string", "bool")
  if (!is.null(raw_params)) {
    for (i in 1:length(raw_params)) {
     
      if (!is.na(mapping[i])){
      params[[mapping[i]]] <- parse_param(raw_params[i], param_type[i])

      }
    }
  }
  #params[["NA_method"]]='na.omit'
  params[["blocks"]] <- dataset$X
  params[["n_run"]] <- 10


  #print(dataset$X[[1]])

  params[["method"]] <- "tgcca"
  
  params[["tau"]]<-1
  params[["rank"]] <- 1


  params[["separable"]]<- TRUE
  params[["connection"]]<-1 - diag(length(dataset$X))
  #print(params)
  
  params[["scale_block"]] <- TRUE

  
  params[["scale"]] <- FALSE

  fit_mgcca <- do.call(rgcca, params)
  return(list(a = fit_mgcca$astar))
}
run_tgcca3 <- function(dataset, raw_params = NULL, root_path = NULL, seed = 0, random_init = FALSE) {
  params <- list(rank = 2, tau = 0.001, scale_block = F, scheme = "horst", scale = F)
  mapping <- c("rank", "tau", "scale_block", "scheme", "scale")
  param_type <- c("num_vec", "num_vec", "bool", "string", "bool")
  if (!is.null(raw_params)) {
    for (i in 1:length(raw_params)) {
     
      if (!is.na(mapping[i])){
      params[[mapping[i]]] <- parse_param(raw_params[i], param_type[i])

      }
    }
  }
  #params[["NA_method"]]='na.omit'
  params[["blocks"]] <- dataset$X
  params[["n_run"]] <- 10


  #print(dataset$X[[1]])

  params[["method"]] <- "tgcca"
  
  # params[["sparsity"]]<- list(c(1,1),c(1,1))
  params[["tau"]]<-1
  params[["rank"]] <- 3


  params[["separable"]]<- TRUE
  params[["connection"]]<-1 - diag(length(dataset$X))
  #print(params)
  
  params[["scale_block"]] <- TRUE

  
  params[["scale"]] <- FALSE

  fit_mgcca <- do.call(rgcca, params)
  return(list(a = fit_mgcca$astar))
}
run_stgcca3 <- function(dataset, raw_params = NULL, root_path = NULL, seed = 0, random_init = FALSE) {
  params <- list(rank = 2, tau = 0.001, scale_block = F, scheme = "horst", scale = F)
  mapping <- c("rank", "tau", "scale_block", "scheme", "scale")
  param_type <- c("num_vec", "num_vec", "bool", "string", "bool")
  if (!is.null(raw_params)) {
    for (i in 1:length(raw_params)) {
     
      if (!is.na(mapping[i])){
      params[[mapping[i]]] <- parse_param(raw_params[i], param_type[i])

      }
    }
  }
  #params[["NA_method"]]='na.omit'
  params[["blocks"]] <- dataset$X
  params[["n_run"]] <- 10


  #print(dataset$X[[1]])

  params[["method"]] <- "stgcca"
  
  params[["sparsity"]]<- list(c(1,0.7),c(1,0.7))
  # params[["sparsity"]]<- list(c(1,1),c(1,1))
  params[["tau"]]<-1
  params[["rank"]] <- 3


  params[["separable"]]<- TRUE
  params[["connection"]]<-1 - diag(length(dataset$X))
  #print(params)
  
  params[["scale_block"]] <- TRUE

  
  params[["scale"]] <- FALSE

  fit_mgcca <- do.call(rgcca, params)
  return(list(a = fit_mgcca$astar))
}



