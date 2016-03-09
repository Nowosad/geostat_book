# http://www.gdos.gov.pl/dane-i-metadane
library('sp')
library('raster')
library('rgeos')
library('magrittr')
url <- "http://sdi.gdos.gov.pl/wfs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=GDOS:ParkiKrajobrazowe&SRSNAME=EPSG:2180&outputFormat=shape-zip&format_options=charset:windows-1250"

fn <- 'data/parki_krajobrazowe_pl.zip'
download.file(url, fn, mode = "wb")
unzip(fn, exdir='data/parki_krajobrazowe_pl/')
if (file.exists(fn)) file.remove(fn)

pk <- shapefile('data/parki_krajobrazowe_pl/ParkiKrajobrazowePolygon.shp', encoding='CP1250')
spk <- subset(pk, nazwa=='Suwalski Park Krajobrazowy')
plot(spk, axes=T)
saveRDS(spk, 'data/granica_spk_rds')
