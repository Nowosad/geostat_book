# https://aws.amazon.com/public-data-sets/landsat/
## other stuff
# http://grindgis.com/blog/vegetation-indices-arcgis


library('sp')
library('raster')
library('rgeos')
library('magrittr')
url10 <- "http://landsat-pds.s3.amazonaws.com/L8/187/022/LC81870222015186LGN00/LC81870222015186LGN00_B10.TIF"
url11 <- "http://landsat-pds.s3.amazonaws.com/L8/187/022/LC81870222015186LGN00/LC81870222015186LGN00_B11.TIF"

fn10 <- 'data/LC81870222015186LGN00_B10.tif'
download.file(url10, fn10, mode = "wb")
fn11 <- 'data/LC81870222015186LGN00_B11.tif'
download.file(url11, fn11, mode = "wb")

###
r <- stack('data/LC81870222015186LGN00_B10.tif', 'data/LC81870222015186LGN00_B11.tif')
spk <- readRDS('data/granica_spk_rds')
spk10 <- gBuffer(spk, width=10000) %>% spTransform(., proj4string(r))
r2 <- crop(r, spk10) %>% projectRaster(., crs=proj4string(spk))
spk1 <- gBuffer(spk, width=1000)
r3 <- crop(r2, spk1) %>% mask(., spk1)

### temperature
#http://gis.stackexchange.com/a/137755/20955
#https://blogs.esri.com/esri/arcgis/2014/01/06/deriving-temperature-from-landsat-8-thermal-bands-tirs/

names(r3) <- c("band10", "band11")

DN_to_radiance <- function(value){
        value*0.0003342+0.1
}
radiance_to_kelvin <- function(value, band){
        if (band=='band10'){
                1321.08 / log((774.89/DN_to_radiance(value))+1)
        } else if (band=='band11'){
                1201.14 / log((480.89/DN_to_radiance(value))+1)
        }
        
}

kelvin_to_celcius <- function(value){
        value - 273.15
}

band_10_cel <- r3[[1]] %>% radiance_to_kelvin(., 'band10') %>% kelvin_to_celcius(.)
band_11_cel <- r3[[2]] %>% radiance_to_kelvin(., 'band11') %>% kelvin_to_celcius(.)

r4 <- stack(band_11_cel, band_11_cel)
writeRaster(r4[[1]], 'data/landsat8_temperature_spk.tif')


if (file.exists(fn10)) file.remove(fn10)
if (file.exists(fn11)) file.remove(fn11)
