#' Comparing diagnositic tests: a simple graphic using likelihood ratios.
#' @name LRgraph
#'
#' @description LRgraph graphically compares two or more (all of them with the first test) diagnostic tests with binary results through their likelihood ratios, based on the rationale that the predictive ability of a test is a more interesting characteristic than sensitivity and/or specificity. It is possible to see through the graph that if the tests with smaller sensitivity or specificity may have superior predictive ability, that is, increases the prediction ability with small sensitivity/specificity trade-off.
#'
#' @param tests A object composed by two or more tests. This object should be created binding two \code{\link{diagnosis}} objects as 'cbind(mytest1,mytest2)'. One may insert as many tests as one wishes. See below.
#'
#' @param lwd Line width. See \code{\link[graphics]{par}}
#'
#' @param lty Line type. See \code{\link[graphics]{par}}
#'
#' @param cex Symbols and text size. See \code{\link[graphics]{par}}
#'
#' @param leg.cex Legend text size, this will replace the cex option in the legend. See \code{\link[graphics]{legend}}
#'
#' @param pt.cex Size of the symbols in the legend. See \code{\link[graphics]{legend}}
#'
#' @param ... Other graphical parameters passed to \code{\link[graphics]{plot.default}}
#'
#' @details When a diagnostic test has both sensitivity and specificity higher than a competing test is easy to see that the former is superior than the later. However, sometimes a test may have superior sensitivity and inferior specificity (or the other way around). In this case, a good decision may be toward the test that have a better prediction ability. The graph visually helps the user to see and compare these abilities. The graph is very similar to the ROC graph. The vertical and horizontal axis have the same length as the ROC graph. However, the diagnostic tests are represented as dots instead of curves. The solid line passing through (0,0) is the likelihood ratio positive-line and the solid line passing through (1,1) is the likelihood ratio negative-line. Both negative and positive likelihood are numerically equivalent to the slopes of the solid lines. The solid lines split the graph into four areas (run the example). Also, there are dashed lines representing the sensitivity and specificity of the first test plotted. One may see that there are areas that a test may have superior sensitivity (or specificity) and yet the dot may be below the likelihood solid line. That is because the sensitivity / specificity trade-off is not reasonable, making the test with less predictive ability.
#'
#' @return Returns only a graph which is divided in four areas by the black solid lines (the likelihood ratios of the firts test). The interpretation of the comparisons will depend on which area the competing tests will fall in. See and run the example to have the idea on how interpretation must be done.
#'
#' @references Biggerstaff, B.J. Comparing diagnostic tests: a simple graphic using likelihood ratios. Statistics in Medicine. 2000; 19(5):649-663
#'
#' @seealso \code{\link{diagnosis}}
#'
#' @examples
#' # Making tests with diagnosis function with different performances for comparison.
#' # mytest5 is the one which all others will be compared with.
#' mytest5<-diagnosis(80,20,20,80,print=FALSE)
#'
#' # mytest1 has higher sensitivity and specificity.
#' # mytest1 is overall superior compared to mytest5.
#' mytest1<-diagnosis(90,10,10,90,print=FALSE)
#'
#' # mytest2 has lower sensitivity but higher specificity.
#' # mytest2 is better to identify the presence of the target condition compared to mytest5.
#' mytest2<-diagnosis(72,28,3,97,print=FALSE)
#'
#' # mytest3 has higher sensitivity but lower specificity.
#' # mytest3 is better to identify the absence of the target condition compared to mytest5.
#' mytest3<-diagnosis(92,8,37,63,print=FALSE)
#'
#' # mytest41 has lower sensitivity and specificity.
#' # mytest41 is overall inferior compared to mytest5.
#' mytest41<-diagnosis(72,28,35,65,print=FALSE)
#'
#' # mytest42 has lower specificity but higher sensitivity.
#' # Nevertheless, mytest42 still is overall inferior compared to mytest5.
#' mytest42<-diagnosis(82,18,42,58,print=FALSE)
#'
#' # But that becomes clear only after ploting the tests.
#' LRgraph(cbind(mytest5,mytest1,mytest2,mytest3,mytest41,mytest42),cex=2.5)
#'
#' # The texts below are not part of the function but helps to understand the areas
#' text(x=.5, y =.5, labels ="Area 4: Overall inferior", col="lightgray",cex=.8)
#' text(x=.5, y =1, labels ="Area 2: Absence", col="lightgray",cex=.8)
#' text(x=.07, y =.68, labels ="Area 3: Presence", col="lightgray",cex=.8)
#' text(x=.1, y =1, labels ="Area 1: Overall superior", col="lightgray",cex=.8)
#'
#' rm(mytest1)
#' rm(mytest2)
#' rm(mytest3)
#' rm(mytest41)
#' rm(mytest42)
#' rm(mytest5)
#'
#' @import graphics
#' @export
LRgraph <- function(tests, lwd = 2, lty = 1, cex = 1, leg.cex = 1.5, pt.cex = 2, ...){
    plot(1 - tests[[6, 1]], tests[[4, 1]], xlim = c(0, 1), ylim = c(0,1), xlab = "False positive rate", ylab = "True positive rate",
        col = 1, cex = cex, lwd = lwd, lty = lty)
    abline(coef = c(0, ((tests[[4, 1]])/(1 - tests[[6, 1]]))), lwd = lwd)
    abline(coef = c(1 - 1 * ((1 - tests[[4, 1]])/(1 - (1 - tests[[6,1]]))), (1 - tests[[4, 1]])/(1 - (1 - tests[[6, 1]]))), lwd = lwd)
    abline(v = 1 - tests[[6, 1]], lty = 6, col = "lightgray", lwd = lwd)
    abline(h = tests[[4, 1]], lty = 6, col = "lightgray", lwd = lwd)
    fill.col <- c(1)
    symbol <- c(1)
    for (i in 2:ncol(tests)) {
        points(1 - tests[[6, i]], tests[[4, i]], col = i, pch = i, cex = cex, lwd = lwd, lty = lty)
        fill.col <- c(fill.col, i)
        symbol <- c(symbol, i)
    }
    legend("bottomright", legend = colnames(tests), col = fill.col, pch = symbol, bty = "n", cex = leg.cex, pt.cex = pt.cex,
        pt.lwd = lwd)
}
