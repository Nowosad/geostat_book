data_merger <- function(spk, clc, srtm, temp, ndvi, savi){
        ext <- extent(spk)
        rtemplate <- raster(ext)
        res(rtemplate) <- 30
        clc_res <- resample(raster(clc), rtemplate, method="ngb")
        srtm_res <- resample(raster(srtm), rtemplate, method="bilinear")
        temp_res <- resample(raster(temp), rtemplate, method="bilinear")
        ndvi_res <- resample(raster(ndvi), rtemplate, method="bilinear")
        savi_res <- resample(raster(savi), rtemplate, method="bilinear")
        stack(clc_res, srtm_res, temp_res, ndvi_res, savi_res)
        
}

# raster_to_sp <- function(raster_stack){
#         
# }

# 
# 
# rs <- readRDS('data/raster_stack.rds')
# names(rs)
