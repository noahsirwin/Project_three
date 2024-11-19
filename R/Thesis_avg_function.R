#' Averages the data in a given column
#'
#' @param data The dataframe of interest
#' @param columns The column that you wish to average
#' @return the average of the column in integer form
#' @export
Thesis_avg_function<-function(data,columns){
  data<-data%>%
    na.omit(dataframe) %>%
    pull(columns)
  avg<-mean(data)
  return(avg)
}
