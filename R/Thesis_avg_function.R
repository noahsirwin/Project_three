Thesis_avg_function<-function(data,columns){
  data<-data%>% 
    na.omit(dataframe) %>% 
    pull(columns)
  avg<-mean(data)
  return(avg)
}
