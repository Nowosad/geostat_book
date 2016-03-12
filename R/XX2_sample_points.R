sp_na_omit <- function(x, margin=1) {
        if (!inherits(x, "SpatialPointsDataFrame") & !inherits(x, "SpatialPolygonsDataFrame")) 
                stop("MUST BE sp SpatialPointsDataFrame OR SpatialPolygonsDataFrame CLASS OBJECT") 
        na.index <- unique(as.data.frame(which(is.na(x@data),arr.ind=TRUE))[,margin])
        if(margin == 1) {  
                cat("DELETING ROWS: ", na.index, "\n") 
                return( x[-na.index,]  ) 
        }
        if(margin == 2) {  
                cat("DELETING COLUMNS: ", na.index, "\n") 
                return( x[,-na.index]  ) 
        }
}

spatial_pixels_to_points <- function(spatial_pixels, type, only_ndvi=FALSE, ...){
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
        sample_points <- sp::over(sample_points, spatial_pixels) %>% SpatialPointsDataFrame(sample_points, .)
        coordnames(sample_points) <- c('x', 'y')
        sample_points <- sp_na_omit(sample_points)
        if (only_ndvi){
                sample_points@data <- sample_points@data['ndvi']
        }
        sample_points
}


