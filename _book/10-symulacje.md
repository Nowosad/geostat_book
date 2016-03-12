---
knit: bookdown::preview_chapter
---

# Symulacje



<!--
## Symulacje przestrzenne 1:
 sekwencyjna symulacja i ko symulacja gaussowska,
  sekwencyjna symulacja danych kodowanych, 
  przetwarzanie (postprocesing) wyników symulacji
 
-->  

## Symulacje geostatystyczne
### Symulacje geostatystyczne
- Kriging daje optymalne predykcje, czyli wyznacza najbardziej potencjalnie możliwą wartość dla wybranej lokalizacji
- Dodatkowo, efektem krigingu jest wygładzony obraz. W konsekwencji wyniki estymacji różnią się od danych pomiarowych
- Jest to tylko (aż?) predykcja. Prawdziwa wartość jest niepewna ...
- Korzystając z symulacji geostatystycznych nie tworzymy predykcji, ale generujemy równie prawdopodobne możliwości poprzez symulację z rozkładu prawdopodobieństwa (wykorzystując genereator liczb losowych)

### Symulacje geostatystyczne | Cel

- Efekt symulacji ma bardziej realistyczny przestrzenny wzór (ang. *pattern*) niż kriging, którego efektem jest wygładzona reprezentacja rzeczywistości
- Każda z symulowanych map jest równie prawdopodobna
- Symulacje pozwalają na przedstawianie niepewności interpolacji
- Jednocześnie - kriging jest znacznie lepszy, gdy naszym celem jest jak najdokładniejsza predykcja

## Typy symulacji
### Typy symulacji
- Symulacje bezwarunkowe (ang. Unconditional Simulations) - wykorzystuje semiwariogram, żeby włączyć informację przestrzenną, ale wartości ze zmierzonych punktów nie są wykorzystywane. 
- Symulacje warunkowe (ang. Conditional Simulations) - opiera się ona o średnią wartość, strukturę kowariancji oraz obserwowane wartości


## Symulacje bezwarunkowe

<!--
http://santiago.begueria.es/2010/10/generating-spatially-correlated-random-fields-with-r/
-->




```r
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
```


```r
library('gstat')
sym_bezw1 <- krige(formula=z~1, locations=NULL, newdata=grid, dummy=TRUE,
                         beta=1, model=vgm(psill=0.025,model='Exp',range=100), nsim=4, nmax=30)
```

```
## [using unconditional Gaussian simulation]
```

```r
spplot(sym_bezw1, main="Przestrzennie skorelowana powierzchnia \nśrednia=1, sill=0.025, zasięg=100, model wykładniczy")
```

![](10-symulacje_files/figure-html/unnamed-chunk-2-1.png)<!-- -->


```r
sym_bezw2 <- krige(formula=z~1, locations=NULL, newdata=grid, dummy=TRUE, 
                   beta=1, model=vgm(psill=0.025,model='Exp',range=1500), nsim=4, nmax=30)
```

```
## [using unconditional Gaussian simulation]
```

```r
spplot(sym_bezw2, main="Przestrzennie skorelowana powierzchnia \nśrednia=1, sill=0.025, zasięg=1500, model wykładniczy")
```

![](10-symulacje_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

<!--
sym_bezw_model3 <- gstat(formula=~1+X+Y, locations=~X+Y, dummy=T, beta=c(1,0,0.005), model=vgm(psill=0.025,model='Exp',range=1500), nmax=20)
sym_bezw3 <- predict(sym_bezw_model3, newdata=grid, nsim=4)
spplot(sym_bezw3, main="Przestrzennie skorelowana powierzchnia \nśrednia=1, sill=0.025, zasięg=1500, model wykładniczy \ntrend na osi y = 0.005")

sym_bezw_model4 <- gstat(formula=~1+X+Y, locations=~X+Y, dummy=T, beta=c(1,0.02,0.005), model=vgm(psill=0.025,model='Exp',range=1500), nmax=20)
sym_bezw4 <- predict(sym_bezw_model4, newdata=grid, nsim=4)
spplot(sym_bezw4, main="Przestrzennie skorelowana powierzchnia \nśrednia=1, sill=0.025, zasięg=500, model wykładniczy \ntrend na osi x = 0.02, trend na osi y = 0.005")
-->

## Symulacje warunkowe

### Sekwencyjna symulacja gaussowska (ang. *Sequential Gaussian simulation*)
1. Wybranie lokalizacji nie posiadającej zmierzonej wartości badanej zmiennej
2. Kriging wartości tej lokalizacji korzystając z dostepnych danych, co pozwala na uzyskanie rozkładu prawdopodobieństwa badanej zmiennej
3. Wylosowanie wartości z rozkładu prawdopodobieństwa za pomocą generatora liczba losowych i przypisanie tej wartości do lokalizacji
4. Dodanie symulowaniej wartości do zbioru danych i przejście do kolejnej lokalizacji
5. Powtórzenie poprzednich kroków, aż do momentu gdy nie pozostanie już żadna nieokreślona lokalizacja

### Sekwencyjna symulacja gaussowska (ang. *Sequential Gaussian simulation*)


```r
vario <- variogram(temp~1, punkty)
model <- vgm(10, model = 'Sph', range = 4500, nugget=1)
fitted <- fit.variogram(vario, model)
plot(vario, model=fitted)
```

![](10-symulacje_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

```r
sym_ok <- krige(temp~1, punkty, grid, model=fitted, nsim=4, nmax=30)
```

```
## drawing 4 GLS realisations of beta...
## [using conditional Gaussian simulation]
```

```r
spplot(sym_ok)
```

![](10-symulacje_files/figure-html/unnamed-chunk-4-2.png)<!-- -->

### Sekwencyjna symulacja gaussowska (ang. *Sequential Gaussian simulation*)


```r
sym_sk <- krige(temp~1, punkty, grid, model=fitted, beta=15.324, nsim=100, nmax=30)
```

```
## [using conditional Gaussian simulation]
```

```r
library('raster')
sym_sk <- stack(sym_sk)
sym_sk_sd <- calc(sym_sk, fun = sd)
spplot(sym_sk_sd)
```

![](10-symulacje_files/figure-html/master_symulation-1.png)<!-- -->

## Sekwencyjna symulacja danych kodowanych (ang. *Sequential indicator simulation*)
### Sekwencyjna symulacja danych kodowanych (ang. *Sequential indicator simulation*)


```r
summary(punkty$temp) 
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   7.805  12.190  15.130  15.320  17.340  26.070
```

```r
punkty$temp_ind <- punkty$temp < 12
summary(punkty$temp_ind) 
```

```
##    Mode   FALSE    TRUE    NA's 
## logical     188      56       0
```


```r
vario_ind <- variogram(temp_ind~1, punkty)         
plot(vario_ind)
```

![](10-symulacje_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

```r
model_ind <- vgm(0.14, model = 'Sph', range = 2000, nugget = 0.02)
plot(vario_ind, model=model_ind)
```

![](10-symulacje_files/figure-html/unnamed-chunk-6-2.png)<!-- -->

```r
fitted_ind <- fit.variogram(vario_ind, model_ind)
fitted_ind
```

```
##   model      psill    range
## 1   Nug 0.03275448    0.000
## 2   Sph 0.13398278 1922.352
```

```r
plot(vario_ind, model=fitted_ind)
```

![](10-symulacje_files/figure-html/unnamed-chunk-6-3.png)<!-- -->

```r
sym_ind <- krige(temp_ind~1, punkty, grid, model=fitted_ind, indicators=TRUE, nsim=4, nmax=30)
```

```
## drawing 4 GLS realisations of beta...
## [using conditional indicator simulation]
```

```r
spplot(sym_ind, main='Symulacje warunkowe')
```

![](10-symulacje_files/figure-html/unnamed-chunk-6-4.png)<!-- -->

<!--
łączenie sis - wiele symulacji
-->
