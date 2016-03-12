---
knit: bookdown::preview_chapter
---

# Wprowadzenie {#intro}

## Wymagania wstępne

Oprogramowanie, pakiety i dane.

### Oprogramowanie

- R (www.r-project.org)
- RStudio (www.rstudio.com) - https://www.rstudio.com/products/rstudio/download/

### Dane

- Adres
- Pliki + ryciny

## R a dane przestrzenne
    
### Pakiety
    
- GIS - `sp`, `rgdal`, `raster`, `rasterVis`, `rgeos`, `maptools`, `GeoXp`, `deldir`, `pgirmess`
- Geostatystyka - **gstat, geoR, geoRglm, fields, spBayes, RandomFields, vardiag**
- Inne - **ggplot2, corrplot, caret**


```r
pakiety <- (c('sp', 'rgdal', 'raster', 'rasterVis', 'gstat', 'ggplot2', 'corrplot', 'deldir', 'fields', 'geoR', 'pgirmess', 'caret'))
```


```r
install.packages(pakiety)
```



### Reprezentacja danych nieprzestrzennych
    
- Wektory (ang. *vector*):
    - liczbowe (ang. *integer*, *numeric*) - c(1, 2, 3) i c(1.21, 3.32, 4.43)
    - znakowe (ang. *character*) - c('jeden', 'dwa', 'trzy')
    - logiczne (ang. *logical*) - c(TRUE, FALSE)
    - czynnikowe (ang. *factor*) - c('jeden', 'dwa', 'trzy', 'jeden')
- Ramki danych (ang. *data.frame*) - to zbiór zmiennych (kolumn) oraz obserwacji (wierszy) zawierających różne typy danych
- Macierze (ang. *matrix*)
- Listy (ang. *list*)

### Reprezentacja danych przestrzennych

- Obiekty klasy Spatial* - wszystkie z nich zawierają dwie dodatkowe informacje:
    - bounding box (bbox) - obwiednia - określa zasięg danych
    - CRS (proj4string) - układ współrzędnych
- Najczęściej stosowane obiekty klasy Spatial* to SpatialPointsDataFrame, SpatialPolygonsDataFrame oraz SpatialGridDataFrame
- Obiekty klasy Raster, tj. RasterLayer, RasterStack, RasterBrick
- Inne

### GDAL/OGR
- http://www.gdal.org/
- GDAL to biblioteka zawierająca funkcje służące do odczytywania i zapiswania danych w formatach rastrowych
- OGR to bibioteka służąca to odczytywania i zapiswania danych w formatach wektorowych
- Pakiet **rgdal** pozwala na wykorzystanie bibliotek GDAL/OGR w R

### PROJ.4
- Dane przestrzenne powinny być zawsze powiązane z układem współrzednych
- PROJ.4 - to biblioteka pozwalająca na identyfiację oraz konwersję pomiędzy różnymi układami współrzędnych
http://www.spatialreference.org/

### EPSG
- Kod EPSG (ang. *European Petroleum Survey Group*) pozwala na łatwe identyfikowanie układów współrzędnych
- Przykładowo, układ PL 1992 może być określony jako:

"+proj=tmerc +lat_0=0 +lon_0=19 +k=0.9993 +x_0=500000 +y_0=-5300000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"

lub

"+init=epsg:2180"

### Układ geograficzny
- Proporcje pomiędzy współrzedną X (długość) a Y (szerokość) nie są 1:1
- Wielkość oczka siatki jest zmienna 
- Nie pozwala na proste określanie odległości czy powierzchni
- Jednostka mapy jest abstrakcyjna

- Do większości algorytmów w geostatystyce wykorzystywane są układy prostokątne płaskie

## Import danych

### Dane punktowe (format csv)


```r
library('sp')
dane_punktowe <- read.csv('dane/punkty.csv')
```


```r
head(dane_punktowe)
```

```
##       srtm clc      temp      ndvi      savi        x        y
## 1 225.0000   4  8.445198 0.2714581 0.1336594 748318.6 718215.9
## 2 226.2811   1 26.459794 0.3990652 0.2777170 746796.4 713105.3
## 3 202.1949   1 16.224041 0.5414072 0.3192062 755746.5 717561.6
## 4 218.4167   1 19.477969 0.5021783 0.2769863 752826.7 713117.8
## 5 196.3150   1 20.679498 0.4138057 0.2240249 748584.1 712664.4
## 6 212.1392   2 20.844318 0.5492478 0.2501368 753884.3 713267.7
```


```r
coordinates(dane_punktowe) <- ~x+y
summary(dane_punktowe)
```

```
## Object of class SpatialPointsDataFrame
## Coordinates:
##        min      max
## x 745619.3 756963.6
## y 712664.4 721253.9
## Is projected: NA 
## proj4string : [NA]
## Number of points: 252
## Data attributes:
##       srtm            clc             temp             ndvi       
##  Min.   :145.8   Min.   :1.000   Min.   : 8.153   Min.   :0.1772  
##  1st Qu.:184.6   1st Qu.:1.000   1st Qu.:12.459   1st Qu.:0.4520  
##  Median :215.0   Median :1.000   Median :15.210   Median :0.5105  
##  Mean   :211.4   Mean   :1.508   Mean   :15.522   Mean   :0.4974  
##  3rd Qu.:235.4   3rd Qu.:2.000   3rd Qu.:18.258   3rd Qu.:0.5587  
##  Max.   :277.0   Max.   :4.000   Max.   :26.700   Max.   :0.6955  
##       savi        
##  Min.   :0.05808  
##  1st Qu.:0.27785  
##  Median :0.31928  
##  Mean   :0.31185  
##  3rd Qu.:0.35793  
##  Max.   :0.46736
```


```r
proj4string(dane_punktowe) <- '+init=epsg:2180'
summary(dane_punktowe)
```

```
## Object of class SpatialPointsDataFrame
## Coordinates:
##        min      max
## x 745619.3 756963.6
## y 712664.4 721253.9
## Is projected: TRUE 
## proj4string :
## [+init=epsg:2180 +proj=tmerc +lat_0=0 +lon_0=19 +k=0.9993
## +x_0=500000 +y_0=-5300000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0
## +units=m +no_defs]
## Number of points: 252
## Data attributes:
##       srtm            clc             temp             ndvi       
##  Min.   :145.8   Min.   :1.000   Min.   : 8.153   Min.   :0.1772  
##  1st Qu.:184.6   1st Qu.:1.000   1st Qu.:12.459   1st Qu.:0.4520  
##  Median :215.0   Median :1.000   Median :15.210   Median :0.5105  
##  Mean   :211.4   Mean   :1.508   Mean   :15.522   Mean   :0.4974  
##  3rd Qu.:235.4   3rd Qu.:2.000   3rd Qu.:18.258   3rd Qu.:0.5587  
##  Max.   :277.0   Max.   :4.000   Max.   :26.700   Max.   :0.6955  
##       savi        
##  Min.   :0.05808  
##  1st Qu.:0.27785  
##  Median :0.31928  
##  Mean   :0.31185  
##  3rd Qu.:0.35793  
##  Max.   :0.46736
```

<!--
### Usuwanie punktów zawierających braki wartości


```r
sp_na_omit <- function(x, margin=1) {
    if (!inherits(x, "SpatialPointsDataFrame") & !inherits(x, "SpatialPolygonsDataFrame")) 
        stop("MUST BE sp SpatialPointsDataFrame OR SpatialPolygonsDataFrame CLASS OBJECT") 
    na.index <- unique(as.data.frame(which(is.na(x@data),arr.ind=TRUE))[,margin])
    if(margin == 1) {  
        cat("DELETING ROWS: ", na.index, "\n") 
        return( x[-na.index,]  ) 
    }
    if(margin == 2) {  
        cat("DELETING COLUMNS: ", na.index, "\n") 
        return( x[,-na.index]  ) 
    }
}
# wolin_lato_los2 <- sp_na_omit(wolin_lato_los) 
# summary(wolin_lato_los2)
```
-->

### Dane poligonowe (formaty gisowe)


```r
library('rgdal')
```

```
## Loading required package: methods
```

```
## rgdal: version: 1.1-3, (SVN revision 594)
##  Geospatial Data Abstraction Library extensions to R successfully loaded
##  Loaded GDAL runtime: GDAL 1.11.2, released 2015/02/10
##  Path to GDAL shared files: /usr/share/gdal/1.11
##  Loaded PROJ.4 runtime: Rel. 4.8.0, 6 March 2012, [PJ_VERSION: 480]
##  Path to PROJ.4 shared files: (autodetected)
##  Linking to sp version: 1.2-1
```

```r
granica <- readOGR(dsn='dane', layer='granica', verbose=FALSE)
plot(granica)
```

![](01-wprowadzenie_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

### Rastry


```r
library('raster')
siatka_raster <- raster("dane/siatka.tif")
plot(siatka_raster)
```

![](01-wprowadzenie_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

## Eksport danych

### Zapisywanie danych wektorowych


```r
library('rgdal')
writeOGR(poligon, dsn="nazwa_folderu", layer="nowy_poligon", driver="ESRI Shapefile")
```

### Zapisywanie danych rastrowych


```r
library('raster')
writeRaster(siatka_raster, filename="nazwa_folderu/nowy_raster.tif")
```

## Wizualizacja danych 2D
### Dane punktowe


```r
spplot(dane_punktowe, "temp")
```

![](01-wprowadzenie_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

### Dane punktowe


```r
spplot(dane_punktowe, "srtm")
```

![](01-wprowadzenie_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

### Dane punktowe - kategorie


```r
dane_punktowe@data$clc <- as.factor(dane_punktowe@data$clc)
spplot(dane_punktowe, "clc")
```

![](01-wprowadzenie_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

### Rastry


```r
library('raster')
library('rasterVis')
levelplot(siatka_raster, margin=FALSE)
```

![](01-wprowadzenie_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

## Tworzenie siatek
### Siatki regularne


```r
bbox(dane_punktowe)
```

```
##        min      max
## x 745619.3 756963.6
## y 712664.4 721253.9
```

```r
extent(dane_punktowe)
```

```
## class       : Extent 
## xmin        : 745619.3 
## xmax        : 756963.6 
## ymin        : 712664.4 
## ymax        : 721253.9
```



```r
siatka <- expand.grid(x = seq(from = 745050, to = 757050, by = 500),
                      y = seq(from = 712650, to = 721650, by = 500))
coordinates(siatka) <- ~x + y
gridded(siatka) <- TRUE
proj4string(siatka) <- proj4string(dane_punktowe)
```


```r
siatka <- makegrid(dane_punktowe, cellsize=500)
names(siatka) <- c('x', 'y')
coordinates(siatka) <- ~x + y
gridded(siatka) <- TRUE
proj4string(siatka) <- proj4string(dane_punktowe)
```

### Siatki regularne


```r
plot(siatka)
plot(dane_punktowe, add=TRUE)
```

![](01-wprowadzenie_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

### Siatki nieregularne


```r
library('raster')
granica <- readOGR(dsn='dane', layer='granica')
```

```
## OGR data source with driver: ESRI Shapefile 
## Source: "dane", layer: "granica"
## with 1 features
## It has 3 fields
```

```r
siatka_n <- raster(extent(granica))
res(siatka_n) <- c(500, 500)
siatka_n[] <- 0
proj4string(siatka_n) <- proj4string(granica)
siatka_n <- mask(siatka_n, granica)
```


```r
levelplot(siatka_n, margin=FALSE)
```

![](01-wprowadzenie_files/figure-html/unnamed-chunk-18-1.png)<!-- -->

### Siatki nieregularne


```r
siatka_n <- as(siatka_n, 'SpatialPointsDataFrame')
siatka_n <- siatka_n[!is.na(siatka_n@data$layer), ]
gridded(siatka_n) <- TRUE
plot(siatka_n)
```

![](01-wprowadzenie_files/figure-html/unnamed-chunk-19-1.png)<!-- -->
