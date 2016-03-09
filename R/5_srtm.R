library('sp')
library('raster')
library('rgeos')
library('magrittr')
url <- "http://srtm.csi.cgiar.org/SRT-ZIP/SRTM_V41/SRTM_Data_GeoTiff/srtm_41_02.zip"

fn <- 'data/srtm_41_02.zip'
download.file(url, fn, mode = "wb")
unzip(fn, exdir='data/srtm/')
if (file.exists(fn)) file.remove(fn)

###
r <- raster('data/srtm/srtm_41_02.tif')
spk <- readRDS('data/granica_spk_rds')
spk10 <- gBuffer(spk, width=10000) %>% spTransform(., proj4string(r))
r2 <- crop(r, spk10) %>% projectRaster(., crs=proj4string(spk))
spk1 <- gBuffer(spk, width=1000)
r3 <- crop(r2, spk1) %>% mask(., spk1)

writeRaster(r3, 'data/srtm_spk.tif')
fn <- 'data/srtm/srtm_41_02.tif'
if (file.exists(fn)) file.remove(fn)
