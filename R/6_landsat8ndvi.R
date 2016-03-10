# https://aws.amazon.com/public-data-sets/landsat/
## other stuff
# http://grindgis.com/blog/vegetation-indices-arcgis


library('sp')
library('raster')
library('rgeos')
library('magrittr')
url4 <- "http://landsat-pds.s3.amazonaws.com/L8/187/022/LC81870222015186LGN00/LC81870222015186LGN00_B4.TIF"
url5 <- "http://landsat-pds.s3.amazonaws.com/L8/187/022/LC81870222015186LGN00/LC81870222015186LGN00_B5.TIF"

fn4 <- 'data/LC81870222015186LGN00_B4.tif'
download.file(url4, fn4, method='curl')
fn5 <- 'data/LC81870222015186LGN00_B5.tif'
download.file(url5, fn5, method='curl')

###
r <- stack(fn4, fn5)
spk <- readRDS('data/granica_spk_rds')
spk10 <- gBuffer(spk, width=10000) %>% spTransform(., proj4string(r))
r2 <- crop(r, spk10) %>% projectRaster(., crs=proj4string(spk))
spk1 <- gBuffer(spk, width=1000)
r3 <- crop(r2, spk1) %>% mask(., spk1)

### ndvi
#https://blogs.esri.com/esri/arcgis/2014/01/06/deriving-temperature-from-landsat-8-thermal-bands-tirs/

names(r3) <- c("band4", "band5")
## calculate ndvi from red (band 1) and near-infrared (band 2) channel

# Band 4 reflectance= (2.0000E-05 * (“sub_tif_Band_4”)) + -0.100000


DN_to_radiance <- function(value){
        value*2.0000E-05-0.1
}
r4 <- DN_to_radiance(r3)

ndvi <- overlay(r4[[1]], r4[[2]], fun = function(x, y) {
        (y-x) / (y+x)
})

savi <- overlay(r4[[1]], r4[[2]] ,fun = function(x, y) {
        l=0.5
        ((y-x) / (y+x+l)) * (1+l)
})


writeRaster(ndvi, 'data/landsat8_ndvi_spk.tif')
writeRaster(savi, 'data/landsat8_savi_spk.tif')

if (file.exists(fn4)) file.remove(fn4)
if (file.exists(fn5)) file.remove(fn5)
