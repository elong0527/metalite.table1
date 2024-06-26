% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/metalite_table1.R
\name{metalite_table1}
\alias{metalite_table1}
\title{Interactive Table of Descriptive Statistics in HTML}
\usage{
metalite_table1(
  formula,
  data,
  id = NULL,
  var_listing = NULL,
  total = TRUE,
  header = NULL,
  download = "none",
  record_name = NULL,
  ...
)
}
\arguments{
\item{formula}{an object of class "formula".}

\item{data}{a data frame that contain variables described in the \code{formula}.}

\item{id}{a character value to indicate subject/record id variable name in \code{data}.}

\item{var_listing}{a character vector of additional variables included in the drill down listing.}

\item{total}{a logical value to display or hide "Total" column.}

\item{header}{a logical vector with length 1 or same length of the variables in \code{formula} to show the \verb{Number of xxx} row of each variable.
Default is to show the row for the first variable.}

\item{download}{a character value to enable download button. Allowed values include
"none", "listing", "table", and 'all'.}

\item{record_name}{a character value to control section title (e.g. "Subjects", "Records").}

\item{...}{additional arguments passed to \code{reactable}. More details refer \url{https://glin.github.io/reactable/reference/reactable.html}}
}
\value{
a \code{shiny.tag.list} object that contain a \code{reactable} HTML widget for
interactive table of describptive statistics.
}
\description{
Interactive Table of Descriptive Statistics in HTML
}
\examples{
if (interactive()) {
  metalite_table1(~ AGE + SEX | TRT01A, data = r2rtf::r2rtf_adsl, id = "SUBJID")
}

}
