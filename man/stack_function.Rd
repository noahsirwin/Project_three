% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Stack_barplot_function.R
\name{stack_function}
\alias{stack_function}
\title{Creates a stacked bar chart when given columns and a dataframe}
\usage{
stack_function(data, column1, column2, column3, graphname)
}
\arguments{
\item{data}{The dataframe you want to use}

\item{column1}{The name of the first column of data applicable found in your dataframe}

\item{column2}{The name of the second column of data applicable found in your dataframe}

\item{column3}{The name of the third column of data applicable found in your dataframe}

\item{graphname}{The name you want to give to the graph you are created by this function}
}
\value{
plot  A ggplot object of the posterior trace
}
\description{
Creates a stacked bar chart when given columns and a dataframe
}
