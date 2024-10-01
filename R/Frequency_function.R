Frequency_function<-function(filepath,column1,column2,column3){
  dataframe<-read_excel(filepath)
  data<-dataframe %>% 
    na.omit(dataframe) %>%
    col_1<-count(column1) %>% 
    col_2<-count(column2) %>% 
    col_3<-count(column3)
  N_total<-col_1+col_2+col3{
    if(col_2>0,col_3>0){
      return(N_total)
    }else{
      Print("Column2 or column3 is empty.")
    }
  }
  return(N_total)
}