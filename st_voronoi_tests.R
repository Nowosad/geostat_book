# https://github.com/r-spatial/sf/issues/824

library(sf)

set.seed(100)
df <- data.frame(ID = 1:10, X = sample(1:10, 10), Y = sample(1:10, 10))
d <- st_geometry(st_as_sf(df,coords = c("X", "Y")))
hull <- st_convex_hull(st_union(d))

# No envelope
v <- st_voronoi(d, per_)
plot(v, col = "grey")
plot(d, add = TRUE)


by_feature


st_voronoi.sfc = function(x, envelope = st_polygon(), dTolerance = 0.0, bOnlyEdges = FALSE, by_feature = FALSE) {
	if (!by_feature){
		st_sfc(CPL_geos_voronoi(x, st_sfc(envelope), dTolerance = dTolerance,
								bOnlyEdges = as.integer(bOnlyEdges)))
	} else {
		v = st_collection_extract(st_sfc(st_voronoi(do.call(c, d))), "POLYGON")
	}

}

