library(stars)
library(gstat)
library(terra)
library(purrr)
x = c(0, 1, 0.5)
y = c(1, 1, 0)
tri = st_cast(st_sfc(geom = st_multipoint(cbind(x, y))), "POLYGON")
# plot(tri, axes = T)

template = rast(vect(tri), resolution = 0.005, crs = "EPSG:4326")
siatka = rasterize(vect(tri), template)
# plot(siatka)
siatka_stars = st_as_stars(siatka)

template2 = rast(vect(tri), resolution = 0.001, crs = "EPSG:4326")
siatka2 = rasterize(vect(tri), template2)
# plot(siatka)
siatka_stars2 = st_as_stars(siatka2)

create_sim = function(range, siatka){
        sym_bezw1 = krige(formula = z ~ 1, 
                          model = vgm(psill = 0.025,
                                      model = "Exp", 
                                      range = range), 
                          newdata = siatka, 
                          beta = 1,
                          nmax = 30,
                          locations = NULL, 
                          dummy = TRUE, 
                          nsim = 1)  
        rast(as(sym_bezw1, "Raster"))
}

set.seed(4324)
r10 = map(seq(5, 0.001, length.out = 10), create_sim, siatka_stars)

transform_sim = function(sim, trans_scale){
        ext(sim) = ext(sim) - c(0, 0, -0.1 * trans_scale, 0.1 * trans_scale)
        sim
}

r10b = map2(r10, 1:10, transform_sim)

all = do.call(terra::merge, r10b)

plot(all)

x2 = c(0, 1, 0.5)
y2 = c(0, 0, -1)
tri2 = st_cast(st_sfc(geom = st_multipoint(cbind(x2, y2))), "POLYGON")

all_cm = mask(crop(all, vect(tri2)), vect(tri2))

plot(all_cm)

library(tmap)
logo = tm_shape(all_cm) +
        tm_raster(style = "order", palette = hcl.colors(50, "Geyser")) +
        tm_layout(legend.show = FALSE, frame = FALSE,
                  main.title = "\nGeostatystyka w R",
                  main.title.position = "center",
                  main.title.size = 1.8,
                  main.title.fontface = "bold",
                  main.title.fontfamily = "Palatino",
                  inner.margins = c(0.1, 0.02, 0.1, 0.02),
                  outer.margins = 0.01,
                  bg.color = "#00858505") +
        tm_shape(tri2) +
        tm_borders(lwd = 2, col = "black") +
        tm_credits("Jakub Nowosad",
                   fontfamily = "URWGothic",
                   alpha = 0.8)

tmap_save(logo, filename = "Rfigs/book_cover3.png", width = 1000, height = 1500)

