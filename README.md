# Thesis R Package
## An R Package used to analyze and plot my data
### Author: Noah Irwin

## Introducing the Purrfect package
+ This package was created as the final project of an R course. 
+ It's purpose is to aid me in the analysis and plotting of my thesis data. 
+ This includes generating averages, frequencies, linear regressions, and plots. 
+ This package works with any data frame that has been read into R. 

## Installation Instructions

```
devtools::install_github("noahsirwin/Project_three")
library(purrfect)
```

## Where to get the data
```
library(readxl)
library(googlesheets4)
library(readxl)
gs4_deauth()
download.file("https://github.com/noahsirwin/Project_three/raw/refs/heads/main/data/Thesis%20Data%20Table%20for%20R%20and%20Figures.xlsx", "/cloud/project/data/Thesis_Data_Table_for_R_and_Figures.xlsx")
download.file("https://github.com/noahsirwin/Project_three/raw/refs/heads/main/data/First_collection_sgls.xlsx","/cloud/project/data/First_collection_sgls.xlsx")
athens_sgl_1<-readxl::read_excel("data/First_collection_sgls.xlsx", na = c("NA", ""),sheet="athens1")
athens_sgl_4<-readxl::read_excel("data/Fourth_collection_sgls.xlsx",na = c("NA", ""),sheet="athens4")
```

## Using the Thesis_avg_function
```
Thesis_avg_function<-function(data,columns){
  data<-data%>%
    filter(!is.na({{columns}})) %>%
    pull({{columns}})
  avg<-mean(data)
  return(avg)
}
```

## Example Average function Input
```
Thesis_avg_function(athens_sgl_1,larva_sgls)
```


## Using the Stack_function
```
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
```

## Example Stack function input
```
stack_function(data=athens_sgl_4,column1=larva_sgls,column2=meta_sgls,column3=adult_rounded_sgls,graphname="data/plots/athens_sgl_4_plot.png")
```


## Using the Frequency_function 
```
Frequency_function<-function(data,column1,column2,column3){
  col_1<-data %>%
    dplyr::select({{column1}}) %>%
    tidyr::na.omit() %>%
    dplyr::count()
  col_2<-data %>%
    dplyr::select({{column2}}) %>%
    tidyr::na.omit() %>%
    dplyr::count()
  col_3<-data %>%
    dplyr::select({{column3}}) %>%
    tidyr::na.omit() %>%
    dplyr::count()
  N_total<-col_1+col_2+col_3
  if(col_2>0 | col_3>0){
    return(N_total)
  }else{
    message(paste("Column2 or Column3 is empty.", col_1))
  }
}
```

## Example Frequency function
```
Frequency_function(data=athens_sgl_1,column1=larva_sgls,column2=meta_sgls,column3=adult_rounded_sgls)
```


## Using the mapping_function
```
mapping_function<-function(data,column1,column2,column3){
  mapping_data<-data %>%
    dplyr::select({{column1}},{{column2}},{{column3}}) %>%
    dplyr::group_by({{column3}}) %>%
    tidyr::na.omit() %>%
    dplyr::mutate(Actual_lon=as.integer({{column1}})) %>%
    dplyr::mutate(Actual_lat=as.integer({{column2}}))

  map<-leaflet::leaflet(mapping_data) %>%
    leaflet::addTiles() %>%
    leaflet::addMarkers(~Actual_lon,~Actual_lat,popup=mapping_data$column3)
  return(map)
}
```

## Example Mapping function input
```
mapping_function(data=Thesis_Data_Table_for_R_and_Figures,column1=Actual_lon,column2=Actual_lat,column3=Locality)
```


## Using the Linear_plot_function
```
Linear_plot_function<-function(data,x=column1,y=column2,xlab="text1",ylab="text2",title="text3",label="text4"){
  chart_label = paste(label)
  xlab_label = paste(xlab)
  ylab_label = paste(ylab)
  title_label = paste(title)
  line_plot<-ggplot2::ggplot(data,aes(x={{x}},y={{y}}))+ggplot2::geom_point()+ggplot2::geom_smooth(method="lm",color="black",size=0.5,fill="gray")+ labs(x=xlab_label,y=ylab_label, title=title_label)+annotate("text",x=20,y=28,label=chart_label,parse=T)+theme_bw()
  return(line_plot)
}
```

## Example Linear Plot function input
```
Linear_plot_function(Thesis_Data_Table_for_R_and_Figures,x=Avg_temp,y=Avg_sample_sgl, xlab="Avg temperature(celcius)",ylab= "Avg Size SGL(mm)" ,title="Linear regression to predict salamander size" ,label= "R^2==0.966")
```

