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



