#' Linear Plot Function: creates a linear plot when fed two variables
#'
#' @param data The desired dataframe
#' @param x The predictor
#' @param y The response
#' @param xlab Desired text label for the x axis should be encased by quotes
#' @param ylab Desired text label for the y axis should be encased by quotes
#' @param title Desired text label for the chart title should be encased by quotes
#' @param label Desired text label for the R square value should be encased by quotes
#'
#' @return A linear regression plot with labels
#' @export
Linear_plot_function<-function(data,x=column1,y=column2,xlab="text1",ylab="text2",title="text3",label="text4"){
  chart_label = paste(label)
  xlab_label = paste(xlab)
  ylab_label = paste(ylab)
  title_label = paste(title)
  line_plot<-ggplot2::ggplot(data,aes(x={{x}},y={{y}}))+ggplot2::geom_point()+ggplot2::geom_smooth(method="lm",color="black",size=0.5,fill="gray")+ labs(x=xlab_label,y=ylab_label, title=title_label)+annotate("text",x=20,y=28,label=chart_label,parse=T)+theme_bw()
  return(line_plot)
}
