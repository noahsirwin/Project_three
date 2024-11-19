#' Title Generates the total number of samples of multiple columns
#'
#' @param data Dataframe your data is from
#' @param column1 The first column of data you want to sum
#' @param column2 The second column of data you want to sum
#' @param column3 The third column of data you want to sum
#'
#' @return the total number of entries from your chosen columns
#' @export
Frequency_function<-function(data,column1,column2,column3){
  col_1<-data %>%
    dplyr::select({{column1}}) %>%
    na.omit() %>%
    count()
  col_2<-data %>%
    dplyr::select({{column2}}) %>%
    na.omit() %>%
    count()
  col_3<-data %>%
    dplyr::select({{column3}}) %>%
    na.omit() %>%
    count()
  N_total<-col_1+col_2+col_3
  if(col_2>0 | col_3>0){
    return(N_total)
  }else{
    message(paste("Column2 or Column3 is empty.", col_1))
  }
}
