library('raster')
library('magrittr')

spk1 <- readRDS('data/granica_spk_rds') %>% gBuffer(., width=1000)
r <- raster() 
extent(r) <- extent(spk1)
res(r) <- 30
