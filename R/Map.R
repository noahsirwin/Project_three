#' Creates a map from an excel sheet containing three columns latitude,longitude,locality
#'
#' @param data The dataframe of interest
#' @param column1 Longitude
#' @param column2 Latitude
#' @param column3 Locality
#' @return A map from the Leaflet function
#' @export
mapping_function<-function(data,column1,column2,column3){
  mapping_data<-data %>%
    select({{column1}},{{column2}},{{column3}}) %>%
    group_by({{column3}}) %>%
    na.omit() %>%
    mutate(Actual_lon=as.integer({{column1}})) %>%
    mutate(Actual_lat=as.integer({{column2}}))

  map<-leaflet::leaflet(mapping_data) %>%
    addTiles() %>%
    addMarkers(~Actual_lon,~Actual_lat,popup=mapping_data$column3)
  return(map)
}



