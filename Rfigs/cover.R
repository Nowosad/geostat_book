# devtools::install_github('nowosad/geostatbook')
# devtools::install_github('nowosad/wesanderson')
# devtools::install_github('oscarperpinan/rasterVis')
library('gridExtra')
library('ggplot2')
library('sp')
library('geostatbook')
library('raster')
library('rasterVis')
library('viridis')

data('siatka')
data('granica')
data('punkty')
siatka <- raster(siatka)

myTheme <- rasterTheme(region = rev(viridis(256)),
                       strip.background = list(col = 'transparent'))
plotek <- levelplot(
        siatka,
        contour = FALSE,
        par.settings = viridisTheme,
        zscaleLog = TRUE,
        margin = FALSE,
        scales = list(draw = FALSE),
        colorkey = FALSE) +
        layer(sp.points(punkty, pch = 20, col = 'black')) +
        layer(sp.lines(granica, lwd = 4, col = '#999999')) 
plotek <- arrangeGrob(plotek)
        
ggsave(plotek, file='Rfigs/cover.png')
# library('ggplot2')
# gplot(siatka) + geom_tile(aes(fill = value)) +
#     facet_wrap(~ variable) +
#     scale_fill_gradient(low = 'white', high = 'blue') +
#     coord_equal()