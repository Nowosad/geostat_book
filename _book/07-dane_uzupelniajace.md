---
knit: bookdown::preview_chapter
---

# Wykorzystanie do estymacji danych uzupełniających 





## Kriging stratyfikowany (ang. *Kriging within strata*)
### Kriging stratyfikowany (ang. *Kriging within strata*)
- Zakłada on, że zmienność badanego zjawiska zależy od zmiennej jakościowej (kategoryzowanej)
- Przykładowo, zróżnicowanie badanej zmiennej jest różne w zależności od pokrycia terenu
- Kriging stratyfikowany wymaga posiadania danych zmiennej jakościowej (kategoryzowanej) na całym badanym obszarze

### Kriging stratyfikowany (ang. *Kriging within strata*)


```r
library('gstat')
grid <- read.csv("dane/siatka.csv")
head(grid)
```

```
##       srtm clc      ndvi      savi        x        y
## 1 242.1462   1        NA        NA 748886.7 721241.2
## 2 240.9517   1        NA        NA 748916.7 721241.2
## 3 239.9704   1        NA        NA 748946.7 721241.2
## 4 239.2956   1        NA        NA 748976.7 721241.2
## 5 238.6385   1 0.5022462 0.3166959 749006.7 721241.2
## 6 237.9930   1 0.5480913 0.3545066 749036.7 721241.2
```

```r
coordinates(grid) <- ~x+y
proj4string(grid) <- proj4string(punkty)
gridded(grid) <- TRUE

grid$clc <- as.factor(grid$clc)
spplot(grid, "clc")
```

![](07-dane_uzupelniajace_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

```r
vario_kws1 <- variogram(temp~1, punkty[punkty$clc==1, ])
plot(vario_kws1)
```

![](07-dane_uzupelniajace_files/figure-html/unnamed-chunk-2-2.png)<!-- -->

```r
fitted_kws1 <- fit.variogram(vario_kws1, vgm(10, model = 'Sph', range = 4500, nugget = 0.5))
plot(vario_kws1, fitted_kws1)
```

![](07-dane_uzupelniajace_files/figure-html/unnamed-chunk-2-3.png)<!-- -->

```r
vario_kws2 <- variogram(temp~1, punkty[punkty$clc==2, ])
plot(vario_kws2)
```

![](07-dane_uzupelniajace_files/figure-html/unnamed-chunk-2-4.png)<!-- -->

```r
fitted_kws2 <- fit.variogram(vario_kws2, vgm(5, model = 'Sph', range = 4500, nugget = 0.1))
plot(vario_kws2, fitted_kws2)
```

![](07-dane_uzupelniajace_files/figure-html/unnamed-chunk-2-5.png)<!-- -->

```r
vario_kws4 <- variogram(temp~1, punkty[punkty$clc==4, ])
plot(vario_kws4)
```

![](07-dane_uzupelniajace_files/figure-html/unnamed-chunk-2-6.png)<!-- -->

```r
fitted_kws4 <- fit.variogram(vario_kws4, vgm(0.5, model = 'Nug'))
plot(vario_kws4, fitted_kws4)
```

![](07-dane_uzupelniajace_files/figure-html/unnamed-chunk-2-7.png)<!-- -->

```r
kws1 <- krige(temp~1, punkty[punkty$clc==1, ], grid[na.omit(grid$clc==1), ], model = fitted_kws1, nmax = 50)
```

```
## [using ordinary kriging]
```

```r
kws2 <- krige(temp~1, punkty[punkty$clc==2, ], grid[na.omit(grid$clc==2), ], model = fitted_kws2, nmax = 50)
```

```
## [using ordinary kriging]
```

```r
kws4 <- krige(temp~1, punkty[punkty$clc==4, ], grid[na.omit(grid$clc==4), ], model = fitted_kws4, nmax = 50)
```

```
## [using ordinary kriging]
```

```r
kws <- rbind(as.data.frame(kws1), as.data.frame(kws2), as.data.frame(kws4))
coordinates(kws) <- ~x+y
kws <- as(kws, "SpatialPixelsDataFrame")
spplot(kws, "var1.pred", sp.layout=(list=SpatialPoints(punkty)))
```

![](07-dane_uzupelniajace_files/figure-html/unnamed-chunk-2-8.png)<!-- -->

## Prosty kriging ze zmiennymi średnimi lokalnymi (LVM)
### Prosty kriging ze zmiennymi średnimi lokalnymi (LVM)
- Prosty kriging ze zmiennymi średnimi lokalnymi zamiast znanej (stałej) stacjonarnej średniej wykorzystuje zmienne średnie lokalne uzyskane na podstawie innej informacji
- Lokalna średnia może być uzyskana za pomocą wyliczenia regresji liniowej pomiędzy zmienną badaną a zmienną dodatkową

### Prosty kriging ze zmiennymi średnimi lokalnymi (LVM)


```r
coef <- lm(temp~srtm, punkty)$coef
coef
```

```
## (Intercept)        srtm 
## 18.91937897 -0.01699626
```

```r
vario <- variogram(temp~srtm, punkty)
model_sim <- vgm(10, model = 'Sph', range = 4000, nugget = 1)
model_sim
```

```
##   model psill range
## 1   Nug     1     0
## 2   Sph    10  4000
```

```r
fitted_sim <- fit.variogram(vario, model_sim)
fitted_sim
```

```
##   model      psill    range
## 1   Nug  0.8106758    0.000
## 2   Sph 11.3220167 4239.323
```

```r
plot(vario, model=fitted_sim)
```

![](07-dane_uzupelniajace_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

```r
sk_lvm <- krige(temp~srtm, punkty, grid, model=fitted_sim, beta = coef)
```

```
## [using simple kriging]
```

```r
summary(sk_lvm)
```

```
## Object of class SpatialPixelsDataFrame
## Coordinates:
##        min      max
## x 745556.7 756986.7
## y 712661.2 721241.2
## Is projected: TRUE 
## proj4string :
## [+init=epsg:2180 +proj=tmerc +lat_0=0 +lon_0=19 +k=0.9993
## +x_0=500000 +y_0=-5300000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0
## +units=m +no_defs]
## Number of points: 98572
## Grid attributes:
##   cellcentre.offset cellsize cells.dim
## x          745556.7       30       382
## y          712661.2       30       287
## Data attributes:
##    var1.pred         var1.var    
##  Min.   : 8.278   Min.   :1.166  
##  1st Qu.:12.515   1st Qu.:2.084  
##  Median :14.960   Median :2.448  
##  Mean   :15.465   Mean   :2.540  
##  3rd Qu.:18.119   3rd Qu.:2.838  
##  Max.   :25.372   Max.   :6.507  
##  NA's   :80       NA's   :80
```


```r
spplot(sk_lvm, "var1.pred")
spplot(sk_lvm, "var1.var")
```

![](07-dane_uzupelniajace_files/figure-html/plotsylvm2-1.png)<!-- -->

## Kriging uniwersalny (ang. *Universal kriging*)
### Kriging uniwersalny (ang. *Universal kriging*)
- Określany również jako kriging z trendem (ang. *Kriging with a trend model*)
- Zakłada on, że nieznana średnia lokalna zmiania się stopniowo na badanym obszarze

### Kriging uniwersalny (ang. *Universal kriging*)

<!--

```r
# vario_ku <- variogram(temp~odl_od_morza, data=punkty)
# plot(vario_ku)
# model_ku <- vgm(psill = 17, model = 'Sph', range = 12000, nugget = 5)
# fitted_ku <- fit.variogram(vario_ku, model_ku)
# fitted_ku
# plot(vario_ku, fitted_ku)
```

-->



```r
punkty$clc <- as.factor(punkty$clc)
vario_uk1 <- variogram(temp~clc, punkty)
vario_uk1
```

```
##      np      dist     gamma dir.hor dir.ver   id
## 1   106  216.1844  1.789125       0       0 var1
## 2   297  480.4988  2.605557       0       0 var1
## 3   483  809.9846  3.452457       0       0 var1
## 4   675 1120.7278  4.810112       0       0 var1
## 5   763 1435.6421  4.985586       0       0 var1
## 6   939 1751.4373  5.562505       0       0 var1
## 7  1038 2060.9052  6.522438       0       0 var1
## 8  1173 2375.2790  6.965343       0       0 var1
## 9  1284 2698.7080  7.347384       0       0 var1
## 10 1336 3010.7474  8.274137       0       0 var1
## 11 1346 3328.7317  8.364764       0       0 var1
## 12 1380 3647.2702  8.809890       0       0 var1
## 13 1426 3963.2623  9.161750       0       0 var1
## 14 1299 4280.0420  9.329572       0       0 var1
## 15 1431 4599.6926 10.882716       0       0 var1
```

```r
plot(vario_uk1)
```

![](07-dane_uzupelniajace_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

```r
model_uk1 <- vgm(8, model = 'Sph', range = 3000, nugget = 1)
vario_fit_uk1 <- fit.variogram(vario_uk1, model=model_uk1)
vario_fit_uk1
```

```
##   model    psill    range
## 1   Nug 1.316597    0.000
## 2   Sph 8.499845 4837.699
```

```r
plot(vario_uk1, vario_fit_uk1)
```

![](07-dane_uzupelniajace_files/figure-html/unnamed-chunk-5-2.png)<!-- -->

<!--


```r
# przygotowanie siatki
# grid <- read.csv("data/Wolin_TPZ_p_lato_popN.csv")
# head(grid)
# coordinates(grid) <- ~X+Y
# proj4string(grid) <- proj4string(punkty)
# gridded(grid) <- TRUE
# plot(grid)
# names(grid)[6] <- c("clc")
# names(grid)[7] <- c("odl_od_morza")
# grid@data <- grid@data[c(2, 4:9)]
# # grid@data <- cbind(grid@data, as.data.frame(coordinates(grid)))
# write.csv(grid, 'data/siatka_wolin_lato.csv', row.names=FALSE)
# spplot(grid)
```

-->


```r
grid$clc <- as.factor(grid$clc)
spplot(grid, "clc")
```

![](07-dane_uzupelniajace_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

```r
uk1 <- krige(temp~clc, locations = punkty, newdata=grid, model=vario_fit_uk1)
```

```
## [using universal kriging]
```


```r
spplot(uk1, "var1.pred")
spplot(uk1, "var1.var")
```

![](07-dane_uzupelniajace_files/figure-html/plotsy4uk1-1.png)<!-- -->


```r
vario_uk2 <- variogram(temp~ndvi+srtm, punkty)
vario_uk2
```

```
##      np      dist     gamma dir.hor dir.ver   id
## 1   106  216.1844  1.376210       0       0 var1
## 2   297  480.4988  2.901703       0       0 var1
## 3   483  809.9846  3.788317       0       0 var1
## 4   675 1120.7278  5.036029       0       0 var1
## 5   763 1435.6421  6.337475       0       0 var1
## 6   939 1751.4373  7.439551       0       0 var1
## 7  1038 2060.9052  8.262829       0       0 var1
## 8  1173 2375.2790  9.176715       0       0 var1
## 9  1284 2698.7080  9.452524       0       0 var1
## 10 1336 3010.7474 10.321034       0       0 var1
## 11 1346 3328.7317  9.949039       0       0 var1
## 12 1380 3647.2702 10.314282       0       0 var1
## 13 1426 3963.2623 11.676009       0       0 var1
## 14 1299 4280.0420 12.279317       0       0 var1
## 15 1431 4599.6926 14.471317       0       0 var1
```

```r
plot(vario_uk2)
```

![](07-dane_uzupelniajace_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

```r
model <- vgm(8, model = 'Sph', range = 3000, nugget = 1)
vario_fit_uk2 <- fit.variogram(vario_uk2, model=model)
vario_fit_uk2
```

```
##   model      psill    range
## 1   Nug  0.7796684    0.000
## 2   Sph 11.5478605 4580.795
```

```r
plot(vario_uk2, vario_fit_uk2)
```

![](07-dane_uzupelniajace_files/figure-html/unnamed-chunk-8-2.png)<!-- -->

```r
uk2 <- krige(temp~ndvi+srtm, locations = punkty, newdata=grid, model=vario_fit_uk2)
```

```
## [using universal kriging]
```


```r
spplot(uk2, "var1.pred")
spplot(uk2, "var1.var")
```

![](07-dane_uzupelniajace_files/figure-html/plotsy4ked-1.png)<!-- -->
