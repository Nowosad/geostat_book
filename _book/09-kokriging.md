---
knit: bookdown::preview_chapter
---

# Estymacje wielozmienne



## Kokriging (prosty i zwykły, SCK i OCK)
### Kokriging (ang. *co-kriging*)
- Kokriging pozwala na wykorzystanie dodatkowej zmiennej (ang. *auxiliary variable*), zwanej inaczej kozmienną (ang. *co-variable*), która może być użyta do prognozwania wartości badanej zmiennej w nieopróbowanej lokalizacji
- Zmienna dodatkowa może być pomierzona w tych samych miejscach, gdzie badana zmienna, jak też w innych niż badana zmienna
- Możliwa jest też sytuacja, gdy zmienna dodatkowa jest pomierzona w dwóch powyższych przypadkach
- Kokriging wymaga, aby obie zmienne były istotnie ze sobą skorelowane
- Najczęściej kokriging jest stosowany w sytuacji, gdy zmienna dodatkowa jest łatwiejsza (tańsza) do pomierzenia niż zmienna główna
- W efekcie, uzyskany zbiór danych zawiera informacje o badanej zmiennej oraz gęściej opróbowane informacje o zmiennej dodatkowej
- Jeżeli informacje o zmiennej dodatkowej są znane dla całego obszaru wówczas bardziej odpowiednią techniką będzie kriging z zewnątrznym trendem (KED)

### Kokriging | Wybór dodatkowej zmiennej
- Wybór zmiennej dodatkowej może opierać się na dwóch kryteriach:
    - Teoretycznym
    - Empirycznym
    
### Kokriging 



```r
library('sp')
wolin_lato_los <- read.csv('data/Wolin_TPZ_p_lato_750losN.csv', na.strings=-999.00)
coordinates(wolin_lato_los) <- ~X+Y
proj4string(wolin_lato_los) <- '+init=epsg:32633'

wolin_lato_los_255 <- wolin_lato_los[!is.na(wolin_lato_los$X1999.09.13_TPZ), ]
wolin_lato_los_750 <- wolin_lato_los

library('gstat')
g <- gstat(NULL, id="TPZ1999", form = X1999.09.13_TPZ~1, data = wolin_lato_los_255)
g <- gstat(g, id="TPZ2002", form = X2002.08.20_TPZ~1, data = wolin_lato_los_750)
g
```

```
## data:
## TPZ1999 : formula = X1999.09.13_TPZ`~`1 ; data dim = 255 x 9
## TPZ2002 : formula = X2002.08.20_TPZ`~`1 ; data dim = 750 x 9
```

```r
v <- variogram(g)
plot(v)
```

![](09-kokriging_files/figure-html/kokriging_predict-1.png)<!-- -->

```r
g <- gstat(g, model=vgm(17, "Sph", 12000, 5), fill.all=TRUE)
g_fit <- fit.lmc(v, g, fit.ranges = FALSE, fit.method=1)
g_fit
```

```
## data:
## TPZ1999 : formula = X1999.09.13_TPZ`~`1 ; data dim = 255 x 9
## TPZ2002 : formula = X2002.08.20_TPZ`~`1 ; data dim = 750 x 9
## variograms:
##                    model     psill range
## TPZ1999[1]           Nug  5.325525     0
## TPZ1999[2]           Sph 11.441263 12000
## TPZ2002[1]           Nug 10.042044     0
## TPZ2002[2]           Sph 11.626818 12000
## TPZ1999.TPZ2002[1]   Nug  7.312944     0
## TPZ1999.TPZ2002[2]   Sph 10.911990 12000
```

```r
plot(v, g_fit)
```

![](09-kokriging_files/figure-html/kokriging_predict-2.png)<!-- -->

```r
ck <- predict(g_fit, grid) 
```

```
## Linear Model of Coregionalization found. Good.
## [using ordinary cokriging]
```

```r
summary(ck)
```

```
## Object of class SpatialGridDataFrame
## Coordinates:
##          min       max
## s1  451080.5  484780.5
## s2 5961519.5 5986319.5
## Is projected: TRUE 
## proj4string :
## [+init=epsg:32633 +proj=utm +zone=33 +datum=WGS84 +units=m +no_defs
## +ellps=WGS84 +towgs84=0,0,0]
## Grid attributes:
##    cellcentre.offset cellsize cells.dim
## s1          451130.5      100       337
## s2         5961569.5      100       248
## Data attributes:
##   TPZ1999.pred    TPZ1999.var     TPZ2002.pred    TPZ2002.var   
##  Min.   :16.71   Min.   : 5.77   Min.   :19.09   Min.   :10.81  
##  1st Qu.:20.77   1st Qu.: 6.22   1st Qu.:20.99   1st Qu.:11.23  
##  Median :22.10   Median : 6.38   Median :22.73   Median :11.35  
##  Mean   :22.93   Mean   : 6.43   Mean   :23.49   Mean   :11.42  
##  3rd Qu.:24.52   3rd Qu.: 6.53   3rd Qu.:25.35   3rd Qu.:11.50  
##  Max.   :37.98   Max.   :10.42   Max.   :34.74   Max.   :15.76  
##  NA's   :57412   NA's   :57412   NA's   :57412   NA's   :57412  
##  cov.TPZ1999.TPZ2002
##  Min.   : 7.89      
##  1st Qu.: 8.30      
##  Median : 8.42      
##  Mean   : 8.48      
##  3rd Qu.: 8.56      
##  Max.   :12.40      
##  NA's   :57412
```


```r
spplot(ck, "TPZ1999.pred")
spplot(ck, "TPZ1999.var")
```




```r
spplot(ck_a, "TPZ1999.pred")
spplot(ck_a, "TPZ1999.var")
```


```r
library('gridExtra')
p1 <- spplot(ck_a, "TPZ1999.pred", main='Predykcja CK - anizotropia')
p2 <- spplot(ck_a, "TPZ1999.var", main='Wariancja CK - anizotropia')
grid.arrange(p1, p2, ncol=2)
```

<!--   
## Kokriging pełny i medianowy, kokriging kolokacyjny, 
## Kokriging na podstawie uproszczonych modeli Markowa I i II
-->

