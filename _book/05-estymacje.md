---
knit: bookdown::preview_chapter
---
# Estymacje jednozmienne



## Kriging

### Kriging | Interpolacja geostatystyczna
- Zaproponowana w latach 50. przez Daniela Krige
- Istnieje wiele rodzajów krigingu
- Główna zasada mówi, że prognoza w danej lokalizacji jest kombinacją obokległych obserwacji
- Waga nadawana każdej z obserwacji jest zależna od stopnia (przestrzennej) korelacji - stąd też bierze się istotna rola semiwariogramów

## Rodzaje krigingu
### Rodzaje krigingu
- Kriging prosty (ang. *Simple kriging*)
- Kriging zwykły (ang. *Ordinary kriging*)
- Kriging z trendem (ang. *Kriging with a trend*)
- Kriging stratyfikowany (ang. *Kriging within strata* – KWS)
- Kriging prosty ze zmiennymi średnimi lokalnymi (ang. *Simple kriging with varying local means* - SKlm)
- Kriging z zewnętrznym trendem/Uniwersalny kriging (ang.*Kriging with an external trend/Universal kriging*)
- Kriging danych kodowanych (ang. *Indicator kriging*)
- Kokriging (ang. *Co-kriging*)
- Inne

## Kriging prosty (ang. *Simple kriging*)
### Kriging prosty (ang. *Simple kriging*)
- Zakłada, że średnia jest znana i stała na całym obszarze

### Kriging prosty (ang. *Simple kriging*)


```r
library('raster')
ras <- raster('dane/siatka.tif')
grid <- as(ras, "SpatialGridDataFrame")
proj4string(grid) <- proj4string(punkty)

library('gstat')
vario <- variogram(temp~1, punkty)
model <- vgm(10, model = 'Sph', range = 4000, nugget = 0.5)
model
```

```
##   model psill range
## 1   Nug   0.5     0
## 2   Sph  10.0  4000
```

```r
fitted <- fit.variogram(vario, model)
plot(vario, model=fitted)
```

![](05-estymacje_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

```r
sk <- krige(temp~1, punkty, grid, model=fitted, beta=15.324)
```

```
## [using simple kriging]
```

```r
summary(sk)
```

```
## Object of class SpatialGridDataFrame
## Coordinates:
##         min      max
## s1 745541.7 757001.7
## s2 712646.2 721256.2
## Is projected: TRUE 
## proj4string :
## [+init=epsg:2180 +proj=tmerc +lat_0=0 +lon_0=19 +k=0.9993
## +x_0=500000 +y_0=-5300000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0
## +units=m +no_defs]
## Grid attributes:
##    cellcentre.offset cellsize cells.dim
## s1          745556.7       30       382
## s2          712661.2       30       287
## Data attributes:
##    var1.pred         var1.var    
##  Min.   : 8.316   Min.   :1.134  
##  1st Qu.:12.545   1st Qu.:2.022  
##  Median :14.927   Median :2.373  
##  Mean   :15.469   Mean   :2.462  
##  3rd Qu.:18.070   3rd Qu.:2.751  
##  Max.   :25.362   Max.   :6.317  
##  NA's   :11142    NA's   :11142
```


```r
spplot(sk, "var1.pred")
spplot(sk, "var1.var")
```

![](05-estymacje_files/figure-html/plotsy2-1.png)<!-- -->

## Kriging zwykły (ang. *Ordinary kriging*)
### Kriging zwykły (ang. *Ordinary kriging*)
- Średnia traktowana jest jako nieznana
- Uwzględnia lokalne fluktuacje średniej poprzez stosowanie ruchomego okna

### Kriging zwykły  (ang. *Ordinary kriging*)


```r
ok <- krige(temp~1, punkty, grid, model=fitted, maxdist=1000)
```

```
## [using ordinary kriging]
```

```r
# ok <- krige(temp~1, punkty, grid, model=fitted, nmax=30)
```


```r
spplot(ok, "var1.pred")
spplot(ok, "var1.var")
```

![](05-estymacje_files/figure-html/plotsy2ok2-1.png)<!-- -->

<!--


```r
spplot(ok, "var1.pred", sp.layout=list(punkty, pch=21, col="white"))
```

![](05-estymacje_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

```r
spplot(ok, "var1.var", sp.layout=list(punkty, pch=21, col="white"))
```

![](05-estymacje_files/figure-html/unnamed-chunk-3-2.png)<!-- -->


-->
## Kriging z trendem (ang. *Kriging with a trend*)
### Kriging z trendem (ang. *Kriging with a trend*)


```r
vario_kzt <- variogram(temp~x+y, data=punkty)
plot(vario_kzt)
```

![](05-estymacje_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

```r
model_kzt <- vgm(psill = 5, model = 'Sph', range = 2500, nugget = 1)
fitted_kzt <- fit.variogram(vario_kzt, model_kzt)
fitted_kzt
```

```
##   model     psill    range
## 1   Nug 0.7272135    0.000
## 2   Sph 6.1096673 2355.502
```

```r
plot(vario_kzt, fitted_kzt)
```

![](05-estymacje_files/figure-html/unnamed-chunk-4-2.png)<!-- -->

```r
grid_sp <- as(ras, "SpatialPixelsDataFrame")
proj4string(grid_sp) <- proj4string(punkty)
grid_sp@data <- as.data.frame(coordinates(grid_sp))

punkty@data <- cbind(punkty@data, as.data.frame(coordinates(punkty)))
kzt <- krige(temp~x+y, punkty, grid_sp, model=fitted_kzt)
```

```
## [using universal kriging]
```


```r
spplot(kzt, "var1.pred")
spplot(kzt, "var1.var")
```

![](05-estymacje_files/figure-html/plotsy2kzt-1.png)<!-- -->

## Porównanie wyników SK, OK i KZT

![](05-estymacje_files/figure-html/ploty_trzy-1.png)<!-- -->
