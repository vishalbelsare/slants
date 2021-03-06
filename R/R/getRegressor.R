#' get Regressor
#'
#' This function calculate the input value for getSequential Nonlinear Model
#'
#' @param x input data, vector x
#' @param d the index of which knots to look at
#' @param spconfig splines configuration
#' @return a vector of regressor that will be passed to EM algorithm
#' @export
#' @examples
#' x =  matrix(rnorm(2*(1000+8)),1000+8, 2)
#' d = rep(1,length(x[,1]))
#' knotBox = apply(x, 2, quantile, c(0.02,0.98), na.rm = TRUE)
#' nBspline = 10
#' order = 3
#' knots = apply(knotBox, 2, augknt, nBspline, order)
#' spconfig = list(order = 3, nBspline = 10, knots = knots,knotBox = knotBox)
#' regressor <- getRegressor(x[,1],d,spconfig)




getRegressor <- function(x, d, spconfig) {
  # d is a vector with same length as x, giving the index of which knots to look at
  # TODO: currently just accept vector x, may need to incorporate matrix x
  # may be slow
  sp <- NULL
  for (i in 1:length(x)) {
    for (j in 1:spconfig$nBspline) {
      sp <- c(sp, spval(x[i], spconfig$knots[j:(j+spconfig$order), d[i]]))
    }
  }

  sp


}
