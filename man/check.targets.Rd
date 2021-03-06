\name{check.targets}
\alias{check.targets}
\alias{print.optweight.targets}
\title{Construct and Check Targets Input}
\usage{
check.targets(formula,
           data = NULL,
           targets,
           stop = FALSE)

\method{print}{optweight.targets}(x, digits = 5, ...)
}
\description{
Checks whether proposed target population means values for \code{targets} are suitable in number and order for submission to \code{\link{optweight}} and \code{\link{optweight.svy}}. Users should include one value per variable in \code{formula}. For factor variables, one value per level of the variable is required. The output of \code{check.targets} can also be used as an input to \code{targets} in \code{optweight} and \code{optweight.svy}.

}
\arguments{
  \item{formula}{
A formula with the covariates to be balanced with \code{optweight} on the right hand side. See \code{\link{glm}} for more details. Interactions and functions of covariates are allowed.
}
  \item{data}{
An optional data set in the form of a data frame that contains the variables in \code{formula}.
}
  \item{targets}{
A vector of target population means values for each covariate. These should be in the order corresponding to the order of the corresponding variable in \code{formula}, except for interactions, which will appear after all lower-order terms. For factor variables, a target value must be specified for each level of the factor, and these values must add up to 1. If empty, the current sample means will be produced. If \code{NULL}, an \code{NA} vector named with the covariate names will be produced.
}
  \item{stop}{
\code{logical}; if \code{TRUE}, an error will be thrown if the number of values in \code{targets} is not equal to the correct number of (expanded) covariates in \code{formula}, and no messages will be displayed if the \code{targets} input is satisfactory. If \code{FALSE}, a message will be displayed if the number of values in \code{targets} is not equal to the correct number of covariates in \code{formula}, and other messages will be displayed.
}
  \item{x}{
An \code{optweight.targets} object; the output of a call to \code{check.targets}.
}
  \item{digits}{
How many digits to print.
}
  \item{\dots}{
Ignored.
}
}
\value{
An \code{optweight.targets} object, which is a named vector of target population mean values, one for each (expanded) covariate specified in \code{formula}. This should be used as user inputs to \code{\link{optweight}} and \code{\link{optweight.svy}}.

}
\details{
The purpose of \code{check.targets} is to allow users to ensure that their proposed input to \code{targets} in \code{\link{optweight}} and \code{\link{optweight.svy}} is correct both in the number of entries and their order. This is especially important when factor variables and interactions are included in the formula because factor variables are split into several dummies and interactions are moved to the end of the variable list, both of which can cause some confusion and potential error when entering \code{targets} values.

Factor variables are internally split into a dummy variable for each level, so the user must specify a target population mean value for each level of the factor. These must add up to 1, and an error will be displayed if they do not. These values represent the proposrtion of units in the target population with each factor level.

Interactions (e.g., \code{a:b} or \code{a*b} in the \code{formula} input) are always sent to the end of the variable list even if they are specified elsewhere in the \code{formula}. It is important to run \code{check.targets} to ensure the order of the proposed \code{targets} corresponds to the represented order of covariates used in the formula. You can run \code{check.targets} with \code{targets = NULL} to see the order of covariates that is required without specifying any targets.
}

\author{
Noah Greifer
}

\examples{
library("cobalt")
data("lalonde", package = "cobalt")

#Checking if the correct number of entries are included:
check.targets(treat ~ age + race + married +
                nodegree + re74,
                data = lalonde,
                targets = c(25, .4, .1, .5, .3,
                            .5, 4000))
#Notice race is split into three values (.4, .1, and .5)

}
