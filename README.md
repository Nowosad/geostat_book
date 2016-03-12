# toDo:
1. Wyczyszczenie pakietów
1. Ujednolicenie cudzysłowów
1. Kokriging - dodaj mapki, etc./ może mniejsza siatka?
1. Jak walidować dane Indicator Kriging?
2. Dodać informację dlaczego wartości  IK są poniżej/powyżej wartości 0/1
3. Zmienić skale kolorystyczne - jak to ustawić globalnie?
4. Kokriging - wszystko w jednym miejscu + kokriging kierunkowy
5. Kokriging - aniztoropia - jak dodać modele do wykresu? [NOTE w helpie - "plotting models and/or point pair numbers is not supported when a variogram is both directional and multivariable"]
6. Raster do gstat (działa funkcja interpolate, ale czy robi anizotropię, etc.?)
7. Nowe dane w pakiecie do tego (najlepiej jaby w nich byl aspekt wysokosci)
8. Dodanie literatury
9. Anizotropia zonalna? (http://gis.stackexchange.com/questions/157218/how-to-remove-zonal-anisotropy-from-directional-variogram-using-gstat-in-r)
10. Practical range
11. Może słownik pojęć?
12. Normalizacja przy symulacjach (GsLIB – metodyka nieparametryczna – strona 141; Wackernagel – metodyka parametryczna (wielomiany Hermite) –   strona 238)



### Źródła wiedzy
- [An Introduction to R](http://cran.r-project.org/doc/manuals/R-intro.pdf) - oficjalne wprowadzenie do R
- [Przewodnik po pakiecie R](http://www.biecek.pl/R/), [Programowanie w języku R](http://rksiazka.rexamine.com/),  [Statystyczna analiza danych z wykorzystaniem programu R](http://ksiegarnia.pwn.pl/7371_pozycja.html?npt=233) - polskie wydawnictwa
- [Applied Spatial Dala Analysis with R](http://www.asdar-book.org/)
- [A Practical Guide to Geostatistical Mapping](http://spatial-analyst.net/book/system/files/Hengl_2009_GEOSTATe2c1w.pdf)
- [gstat user's manual](http://www.gstat.org/gstat.pdf)
- [CRAN Task View: Analysis of Spatial Data](https://cran.r-project.org/web/views/Spatial.html)
- [Applied Geostatistics](https://books.google.pl/books?id=vC2dcXFLI3YC), [Statistics for spatial data](https://books.google.pl/books?id=4SdRAAAAMAAJ)
- [Praktyczny poradnik - jak szybko zrozumieć i wykorzystać geostatystykę w pracy badawczej](http://www.geoinfo.amu.edu.pl/staff/astach/www_geostat/programy/A_Stach_%20poradnik_geostatystyki.pdf)
- Wyszukiwarki internetowe [Rseek](http://www.rseek.org/), [Duckduckgo](http://duckduckgo.com/), [Google](http://google.com/), [Bing](http://bing.com/), itd.

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