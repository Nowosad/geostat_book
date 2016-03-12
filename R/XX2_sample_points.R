spatial_pixels_to_points <- function(spatial_pixels, type, ...){
        if (type==1){
                type <- "random"
        } else if (type==2){
                type <- "regular"
        } else if (type==3){
                type <- "stratified"
        } else if (type==4){
                type <- "nonaligned"
        } else if (type==5){
                type <- "hexagonal"
        } else if (type==6){
                type <- "clustered"
        } else if (type==7){
                type <- "Fibonacci"
        }
        sample_points <- spsample(spatial_pixels, type=type, ...)
        sp::over(sample_points, spatial_pixels) %>% SpatialPointsDataFrame(sample_points, .)
}


