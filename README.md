# book_to_fix:
1. Popraw references
1. Popraw wielkość obrazków
1. Zamiana ryciny normalności


# toAdd:
1. Kokriging - dodaj mapki, etc./ może mniejsza siatka?
1. Jak walidować dane Indicator Kriging?
2. Dodać informację dlaczego wartości  IK są poniżej/powyżej wartości 0/1
3. Zmienić skale kolorystyczne - jak to ustawić globalnie?
4. Kokriging - kokriging kierunkowy
5. Kokriging - aniztoropia - jak dodać modele do wykresu? [NOTE w helpie - "plotting models and/or point pair numbers is not supported when a variogram is both directional and multivariable"]
6. Raster do gstat (działa funkcja interpolate, ale czy robi anizotropię, etc.?)
8. Dodanie literatury
9. Anizotropia zonalna? (http://gis.stackexchange.com/questions/157218/how-to-remove-zonal-anisotropy-from-directional-variogram-using-gstat-in-r)
10. Practical range
11. Może słownik pojęć?
12. Normalizacja przy symulacjach (GsLIB – metodyka nieparametryczna – strona 141; Wackernagel – metodyka parametryczna (wielomiany Hermite) –   strona 238)
13. Automatyczne dopasowywanie modeli - http://r-spatial.org/r/2016/02/14/gstat-variogram-fitting.html
14. geostat i ggplot2 - http://rogiersbart.blogspot.com/2016/03/variography-with-gstat-and-ggplot2.html

# data:

## dane:
- landuse - CLC - [licencja](http://wiki.openstreetmap.org/wiki/Corine_Land_Cover)
- elevation (lidar + srtm + dted?)
- ndvi
- temperature
- soils?

## resources:
- http://opentopo.sdsc.edu/lidar?format=sd
- http://earthexplorer.usgs.gov/logout/expire 
- http://neo.sci.gsfc.nasa.gov/
- http://www.diva-gis.org/Data
- https://www.iscgm.org/gmd/
- https://cran.rstudio.com/web/packages/geoknife/vignettes/geoknife.html