# http://thebiobucket.blogspot.com/2013/04/programmatically-download-corine-land.html
library('XML')

doc <- htmlParse("http://www.eea.europa.eu/data-and-maps/data/corine-land-cover-2006-raster-3")
urls <- xpathSApply(doc,'//*/a[contains(@href,".zip/at_download/file")]/@href')
url <- urls[[1]]

get_zip_name <- function(x) unlist(strsplit(x, "/"))[grep(".zip", unlist(strsplit(x, "/")))] # function to get zip file names
dl_urls <- function(x) try(download.file(x, paste0('data/', get_zip_name(x)), mode = "wb")) # function to plug into sapply

dl_urls(url)
fn <- 'data/g100_06.zip'
unzip(fn, exdir='data/crc/')
if (file.exists(fn)) file.remove(fn)

###
library('sp')
library('raster')
library('rgeos')
library('magrittr')

r <- raster('data/crc/g100_06.tif')
spk_line <- readRDS('data/granica_spk_rds') %>% as(., 'SpatialLines')
spk <- readRDS('data/granica_spk_rds')
spk10 <- gBuffer(spk, width=10000) %>% spTransform(., proj4string(r))
r2 <- crop(r, spk10) %>% projectRaster(., crs=proj4string(spk))
spk2 <- gBuffer(spk, width=1000)
r3 <- crop(r2, spk2) %>% mask(., spk2)

writeRaster(r3, 'data/crc06_spk.tif')
fn <- 'data/crc/g100_06.tif'
if (file.exists(fn)) file.remove(fn)
