library('sp')
library('raster')
library('rgeos')
library('magrittr')

spk1 <- readRDS('data/granica_spk_rds') %>% gBuffer(., width=1000)
r <- raster('data/landsat8_temperature_spk.tif')
# spplot(r)

sample50 <-  spsample(spk1, 50, type='random')
sample100 <- spsample(spk1, 100, type='random')
sample200 <- spsample(spk1, 200, type='random')

sample50 <-  SpatialPointsDataFrame(sample50, data.frame(temperatura=extract(r, sample50)))
sample100 <- SpatialPointsDataFrame(sample100, data.frame(temperatura=extract(r, sample100)))
sample200 <- SpatialPointsDataFrame(sample200, data.frame(temperatura=extract(r, sample200)))
