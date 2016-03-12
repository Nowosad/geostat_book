data_merger <- function(spk, clc, srtm, temp, ndvi, savi){
        ext <- extent(spk)
        rtemplate <- raster(ext)
        res(rtemplate) <- 30
        clc_res <- resample(raster(clc), rtemplate, method="ngb")
        srtm_res <- resample(raster(srtm), rtemplate, method="bilinear")
        temp_res <- resample(raster(temp), rtemplate, method="bilinear")
        ndvi_res <- resample(raster(ndvi), rtemplate, method="bilinear")
        savi_res <- resample(raster(savi), rtemplate, method="bilinear")
        sta <- stack(clc_res, srtm_res, temp_res, ndvi_res, savi_res)
        names(sta) <- c('clc', 'srtm', 'temp', 'ndvi', 'savi')
        crs(sta) <- "+init=epsg:2180"
        sta
}

raster_to_sp <- function(raster_stack){
        as(raster_stack, 'SpatialPixelsDataFrame')
}

raster_to_sp2 <- function(raster_stack){
        new_spdf <- as(raster_stack, 'SpatialPixelsDataFrame')
        new_spdf$temp <- NULL
        new_spdf
}

