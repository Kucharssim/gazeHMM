#' Gamma Response Model for depmixS4
#'
#' Creates a gamma response model to be used in \code{\link[depmixS4]{makeDepmix}}
#' as part of \code{\link{HMM_classify}}.
#'
#' @param y Numeric vector containing a response variable.
#' @param pstart Numeric vector of length two containing the starting values
#' for the shape and scale parameters.
#' @param fixed Logical vector of length two indicating which parameters are
#' fixed.
#' @param ... Further arguments to be supplied by parent functions.
#'
#' @return An S4 object of class 'gamma2'.
#' @slot parameters List of length two containing the shape and scale parameters
#' of the gamma distribution.
#' @slot fixed Logical vector indicating which parameters are fixed.
#' @slot y Response variable.
#' @slot x Covariate variables (or just an intercept).
#' @slot npar Number of parameters.
#' @slot constr Vector defining the parameter constraints.
#'
#' @name gamma2
#' @importFrom methods new
#' @importFrom stats dgamma rgamma
NULL


#' @rdname gamma2
#'
setClass("gamma2", contains = "response")


#' @rdname gamma2
#'
setGeneric("gamma2", function(y, pstart = NULL, fixed = NULL, ...) standardGeneric("gamma2"))


#' @rdname gamma2
#'
setMethod("gamma2",
          signature(y="ANY"),
          function(y,pstart=NULL,fixed=NULL, ...) {
            y <- matrix(y,length(y))
            x <- matrix(1)
            parameters <- list()
            npar <- 2
            if(is.null(fixed)) fixed <- as.logical(rep(0,npar))
            if(!is.null(pstart)) {
              if(length(pstart)!=npar) stop("length of 'pstart' must be ",npar)
              parameters$shape <- log(pstart[1])
              parameters$scale <- log(pstart[2])
            }
            mod <- new("gamma2",parameters=parameters,fixed=fixed,x=x,y=y,npar=npar)
            mod
          }
)
