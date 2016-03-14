sp_na_omit <- function(x, margin) {
        if (!inherits(x, "SpatialPointsDataFrame") & !inherits(x, "SpatialPolygonsDataFrame")) 
                stop("MUST BE sp SpatialPointsDataFrame OR SpatialPolygonsDataFrame CLASS OBJECT") 
        na.index <- try(unique(as.data.frame(which(is.na(x@data), arr.ind=TRUE))[ ,margin]), silent = TRUE)
        if (inherits(na.index, 'try-error')){
                cat("DELETING: NONE\n") 
                return(x)
        } else if(margin == 1) {  
                cat("DELETING ROWS: ", na.index, "\n") 
                return(x[-na.index, ]) 
        } else if(margin == 2) {  
                cat("DELETING COLUMNS: ", na.index, "\n") 
                return(x[, -na.index]) 
        }
        return(x)
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
        set.seed(14032016)
        sample_points <- spsample(spatial_pixels, type=type, ...)
        sample_points <- sp::over(sample_points, spatial_pixels) %>% SpatialPointsDataFrame(sample_points, .)
        coordnames(sample_points) <- c('x', 'y')
        sample_points2 <- sp_na_omit(sample_points, 1)
        if (only_ndvi){
                sample_points2@data <- sample_points2@data['ndvi']
        }
        sample_points2
}

spatial_points_stratified <- function(spatial_points, threshold, prop){
        set.seed(255)
        above <- spatial_points[spatial_points@data[, 'temp']>threshold, ]
        above <- above[sample(1:length(above), size=nrow(above)*prop), ]
        below <- spatial_points[spatial_points@data[, 'temp']<threshold, ]
        below <- below[sample(1:length(below), size=nrow(below)*(1-prop)), ]
        rbind(below, above)
}
