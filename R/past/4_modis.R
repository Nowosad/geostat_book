# devtools::install_github("mccreigh/rwrfhydro")
library("rwrfhydro")
library('rgeos')
library('rgdal')
library('raster')
library('MODIS')
library('ncdf4')
library('magrittr')

MODISoptions(localArcPath=paste0(getwd(), "/data/MODIS_ARC"), 
             outDirPath=paste0(getwd(), "/data/MODIS_ARC/PROCESSED"))
# getProduct()
# 41 MODIS MOD11A2 Land Surface Temperature & Emissivity Terra  Tile  1000m 8 Day

year_to_dates <- function(year){
        dates <- as.POSIXct(as.Date(c(paste0(year, "-01-01"), paste0(year, "-12-31"))))
        return(dates)
}
dates <- year_to_dates(2006)
product <- "MOD11A2"
getSds('data/MODIS_ARC/MODIS/MOD11A2.005/2006.01.01/MOD11A2.A2006001.h19v03.005.2008098031519.hdf')
spk10 <- readRDS('data/granica_spk_rds') %>% gBuffer(., width=1000)
runGdal(product = product, begin=dates[1], end=dates[2], extent = spk10,
        SDSstring=c(110011000000))

#bieda