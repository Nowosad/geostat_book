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
library('rasterVis')

r <- raster('data/crc/g100_06.tif')
spk_line <- readRDS('data/granica_spk_rds') %>% as(., 'SpatialLines')
spk <- readRDS('data/granica_spk_rds')
spk10 <- gBuffer(spk, width=10000) %>% spTransform(., proj4string(r))
r2 <- crop(r, spk10) %>% projectRaster(., crs=proj4string(spk), method='ngb')
spk1 <- gBuffer(spk, width=1000)
r3 <- crop(r2, spk1) %>% mask(., spk1)

# 1-9 Artificial surfaces
# 12-22 Agricultural areas
# 23-34 Forest and semi natural areas
# 35-39 Wetlands
# 40-44 Water bodies
# 48 NODATA
# 49, 50, 255 UNCLASSIFIED
r4 <- reclassify(r3, include.lowest = TRUE, right=FALSE,
                        c(12, 22, 1,
                        23, 34, 2,
                        35, 39, 3, 
                        40, 44, 4))
writeRaster(r4, 'data/crc06_spk.tif', overwrite=TRUE)
fn <- 'data/crc/g100_06.tif'
if (file.exists(fn)) file.remove(fn)
# 
# r5 <- ratify(r4) 
# rat <- levels(r5)[[1]]
# rat$legend <- c('Agricultural areas', 'Forest and semi natural areas', 'Water bodies')
# levels(r5) <- rat
# levelplot(r5)
