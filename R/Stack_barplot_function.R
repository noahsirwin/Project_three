#' Creates a stacked bar chart when given columns and a dataframe
#'
#' @param data The dataframe you want to use
#' @param column1 The name of the first column of data applicable found in your dataframe
#' @param column2 The name of the second column of data applicable found in your dataframe
#' @param column3 The name of the third column of data applicable found in your dataframe
#' @param graphname The name you want to give to the graph you are created by this function
#'
#' @return plot  A ggplot object of the posterior trace
#' @export
stack_function<-function(data,column1,column2,column3,graphname){
  graph_data<-data %>%
    dplyr::select({{column1}},{{column2}},{{column3}}) %>%
    tidyr::gather(key=sgls, value=mm) %>%
    dplyr::mutate(rounded = round(mm)) %>%
    dplyr::group_by(rounded, sgls) %>%
    dplyr::summarize(count=n())
  plot<-ggplot2::ggplot(data=graph_data,mapping=aes(x=rounded,y=count,fill=sgls))+ggplot2::geom_col(position = position_stack())+xlab("SGL's (mm)")+ylab("Frequency")
  ggplot2::ggsave(graphname, width = 160, height = 80, units = "mm",dpi = 300)
  return(graph_data)
}
