---
knit: bookdown::preview_chapter
---

# Wprowadzenie {#intro}

## Wymagania wstępne

Oprogramowanie, pakiety i dane.

### Oprogramowanie

- [R](www.r-project.org) - https://cloud.r-project.org/
- [RStudio](www.rstudio.com) - https://www.rstudio.com/products/rstudio/download/

### Dane

- Adres
- Pliki + ryciny

## R a dane przestrzenne
    
### Pakiety
    
- GIS - `sp`, `rgdal`, `raster`, `rasterVis`, `rgeos`, `maptools`, `GeoXp`, `deldir`, `pgirmess`
- Geostatystyka - `gstat`, `geoR`, `geoRglm`, `fields`, `spBayes`, `RandomFields`, `vardiag`
- Inne - `ggplot2`, `corrplot`, `caret`


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

- Obiekty klasy `Spatial*` z pakietu `sp` - wszystkie z nich zawierają dwie dodatkowe informacje:
    - bounding box (`bbox`) - obwiednia - określa zasięg danych
    - CRS (`proj4string`) - układ współrzędnych
- Najczęściej stosowane obiekty klasy `Spatial*` to `SpatialPointsDataFrame`, `SpatialPolygonsDataFrame` oraz `SpatialGridDataFrame`
- Obiekty klasy `Raster*` z pakietu `raster`, tj. `RasterLayer`, `RasterStack`, `RasterBrick`
- Inne

### GDAL/OGR
- http://www.gdal.org/
- GDAL to biblioteka zawierająca funkcje służące do odczytywania i zapiswania danych w formatach rastrowych
- OGR to bibioteka służąca to odczytywania i zapiswania danych w formatach wektorowych
- Pakiet `rgdal` pozwala na wykorzystanie bibliotek GDAL/OGR w R

### PROJ.4
- Dane przestrzenne powinny być zawsze powiązane z układem współrzednych
- PROJ.4 - to biblioteka pozwalająca na identyfiację oraz konwersję pomiędzy różnymi układami współrzędnych
http://www.spatialreference.org/

### EPSG
- Kod EPSG (ang. *European Petroleum Survey Group*) pozwala na łatwe identyfikowanie układów współrzędnych
- Przykładowo, układ PL 1992 może być określony jako:

"+proj=tmerc +lat_0=0 +lon_0=19 +k=0.9993 +x_0=500000 +y_0=-5300000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"

- ...lub też za pomocą kodu EPSG:

"+init=epsg:2180"

### Układ geograficzny
- Proporcje pomiędzy współrzedną oznaczjącą długość geograficzną (X) a oznaczającą szerokość geograficzną (Y) nie są równe 1:1
- Wielkość oczka siatki jest zmienna 
- Nie pozwala to na proste określanie odległości czy powierzchni
- Jednostka mapy jest abstrakcyjna

- Do większości algorytmów w geostatystyce wykorzystywane są układy współrzędnych prostokątnych płaskich

## Import danych

### Dane punktowe (format csv)


```r
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






































