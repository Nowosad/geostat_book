---
knit: bookdown::preview_chapter
---

# Eksploracyjna analiza danych



## Eksploracyjna analiza danych | Cel
- Ogólna charakterystyka danych oraz badanego zjawiska
- Określenie przestrzennego/czasowego typu próbkowania
- Informacja o relacji pomiędzy lokalizacją obserwacji a czynnikami wpływającymi na zmienność przestrzenną cechy

## Dane Wolin
### Dane Wolin


```r
library('sp')
library('rgdal')
punkty <- read.csv('dane/punkty.csv')
coordinates(punkty) <- ~x+y

proj4string(punkty) <- '+init=epsg:2180'
par(mar=c(rep(0, 4)))
plot(punkty)

str(punkty)
```

```
## Formal class 'SpatialPointsDataFrame' [package "sp"] with 5 slots
##   ..@ data       :'data.frame':	244 obs. of  5 variables:
##   .. ..$ srtm: num [1:244] 184 220 242 204 203 ...
##   .. ..$ clc : int [1:244] 1 2 2 1 1 1 2 2 4 4 ...
##   .. ..$ temp: num [1:244] 17.8 16.8 10.1 18.6 17.9 ...
##   .. ..$ ndvi: num [1:244] 0.549 0.607 0.6 0.723 0.5 ...
##   .. ..$ savi: num [1:244] 0.364 0.343 0.398 0.489 0.335 ...
##   ..@ coords.nrs : int [1:2] 6 7
##   ..@ coords     : num [1:244, 1:2] 752245 751901 750205 753276 753895 ...
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:244] "1" "2" "3" "4" ...
##   .. .. ..$ : chr [1:2] "x" "y"
##   ..@ bbox       : num [1:2, 1:2] 745574 712659 756978 721228
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:2] "x" "y"
##   .. .. ..$ : chr [1:2] "min" "max"
##   ..@ proj4string:Formal class 'CRS' [package "sp"] with 1 slot
##   .. .. ..@ projargs: chr "+init=epsg:2180 +proj=tmerc +lat_0=0 +lon_0=19 +k=0.9993 +x_0=500000 +y_0=-5300000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m"| __truncated__
```

```r
str(punkty@data)
```

```
## 'data.frame':	244 obs. of  5 variables:
##  $ srtm: num  184 220 242 204 203 ...
##  $ clc : int  1 2 2 1 1 1 2 2 4 4 ...
##  $ temp: num  17.8 16.8 10.1 18.6 17.9 ...
##  $ ndvi: num  0.549 0.607 0.6 0.723 0.5 ...
##  $ savi: num  0.364 0.343 0.398 0.489 0.335 ...
```

```r
granica <- readOGR('dane', 'granica')
```

```
## OGR data source with driver: ESRI Shapefile 
## Source: "dane", layer: "granica"
## with 1 features
## It has 3 fields
```

```r
plot(granica, add=TRUE)
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-1-1.png)<!-- -->


## Statystyki opisowe
### Statystyki opisowe


```r
summary(punkty@data)
```

```
##       srtm            clc             temp             ndvi       
##  Min.   :145.0   Min.   :1.000   Min.   : 7.805   Min.   :0.1465  
##  1st Qu.:188.5   1st Qu.:1.000   1st Qu.:12.192   1st Qu.:0.4590  
##  Median :213.2   Median :1.000   Median :15.134   Median :0.5163  
##  Mean   :211.6   Mean   :1.418   Mean   :15.324   Mean   :0.5033  
##  3rd Qu.:236.7   3rd Qu.:2.000   3rd Qu.:17.343   3rd Qu.:0.5660  
##  Max.   :283.0   Max.   :4.000   Max.   :26.072   Max.   :0.7229  
##       savi        
##  Min.   :0.04552  
##  1st Qu.:0.29080  
##  Median :0.32742  
##  Mean   :0.32071  
##  3rd Qu.:0.36468  
##  Max.   :0.48895
```


### Statystyki opisowe | średnia i mediana


```r
median(punkty$temp, na.rm=TRUE)
```

```
## [1] 15.13433
```

```r
mean(punkty$temp, na.rm=TRUE)
```

```
## [1] 15.32378
```


### Statystyki opisowe | średnia i mediana
- w wypadku symetrycznego rozkładu te dwie cechy są równe
- średnia jest bardziej wrażliwa na wartości odstające
- mediana jest lepszą miarą środka danych, jeżeli są one skośne

Po co używać średniej?

- przydatniejsza w przypadku małych zbiorów danych
- gdy rozkład danych jest symetryczny
- (jednak) często warto podawać obie miary
  
### Statystyki opisowe | minimum i maksimum


```r
min(punkty$temp, na.rm=TRUE)
```

```
## [1] 7.804768
```

```r
max(punkty$temp, na.rm=TRUE)
```

```
## [1] 26.07235
```


### Statystyki opisowe | ochylenie standardowe
![](figs/sd.png)


```r
sd(punkty$temp, na.rm=TRUE)
```

```
## [1] 3.883714
```


## Wykresy
### Histogram


```r
library('ggplot2')
ggplot(punkty@data, aes(temp)) + geom_histogram()
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

- Stworzony przez Karla Pearsona
- Jest graficzną reprezentacją rozkładu <br> danych
- Wartości danych są łączone w przedziały (na osi poziomej) a na osi pionowej jest ukazana liczba punktów (obserwacji) w każdym przedziale
- Różny dobór przedziałów może dawać inną informację
- W pakiecie ggplot2, domyślnie przedział to zakres/30

### Estymator jądrowy gęstości (ang. *kernel density estimation*)


```r
ggplot(punkty@data, aes(temp)) + geom_density()
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-7-1.png)<!-- -->


### Wykresy kwantyl-kwantyl (ang.*quantile-quantile*)


```r
ggplot(punkty@data, aes(sample=temp)) + stat_qq()
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-8-1.png)<!-- -->


### Wykresy kwantyl-kwantyl (ang. *quantile-quantile*)
http://stats.stackexchange.com/questions/101274/how-to-interpret-a-qq-plot
![http://stats.stackexchange.com/questions/101274/how-to-interpret-a-qq-plot](figs/qq.png)

<!--    
## [analiza typu rozkładu jednej zmiennej i porównanie rozkładów dwóch zmiennych (wykresy q-q i p-p)]
    


```r
df <- as.data.frame(qqplot(punkty$temp, punkty$X1999.09.13_NDVI, plot.it=FALSE))
ggplot(df) + geom_point(aes(x=x, y=y)) + xlab('TPZ') + ylab('NDVI')

ggplot(punkty@data) + geom_point(aes(x=temp, y=X1999.09.13_NDVI)) + xlab('TPZ') + ylab('NDVI')
```

-->

### Dystrybuanta (CDF)
- Dystrybuanta (ang. conditional density function - CDF) wyświetla prawdopodobieństwo, że wartość zmiennej przewidywanej jest mniejsza lub równa określonej wartości



```r
ggplot(punkty@data, aes(temp)) + stat_ecdf()
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-10-1.png)<!-- -->


## Porównanie zmiennych

### Kowariancja
- Kowariancja jest nieunormowaną miarą zależności liniowej pomiędzy dwiema zmiennymi
- Kowariancja dwóch zmiennych $x$ i $y$ pokazuje jak dwie zmienne są ze sobą liniowo powiązane
- Dodatnia kowariancja wzkazuje na pozytywną relację liniową pomiędzy zmiennymi, podczas gdy ujemna kowariancja świadczy o odwrotnej sytuacji
- Jeżeli zmienne nie są ze sobą liniowo powiązane, wartość kowariacji jest bliska zeru
- Inaczej mówiąc, kowariancja stanowi miarę wspólnej zmienności dwóch zmiennych  
- Wielkość samej kowariancji uzależniona jest od przyjętej skali zmiennej (jednostki)
- Inne wyniku uzyskamy (przy tej samej zależności pomiędzy parą zmiennych), gdy będziemy analizować wyniki np. wieku i dochodu w złotówkach a inne dla wieku i dochodu w dolarach



```r
cov(punkty$temp, punkty$ndvi, use= "complete.obs")
```

```
## [1] 0.03160881
```


### Współczynnik korelacji
- Wspołczynnik korelacji to unormowana miara zależności pomiędzy dwiema zmiennymi, przyjmująca wartości od -1 do 1
- Współczynnik korelacji jest uzyskiwany poprzez podzielenie wartości kowariancji przez odchylenie standardowe wyników
- Z racji unormowania nie jest ona uzależniona od jednostki


```r
ggplot(punkty@data, aes(temp, ndvi)) + geom_point()
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

```r
cor(punkty$temp, punkty$ndvi, use=  "complete.obs")
```

```
## [1] 0.0852945
```


```r
cor.test(punkty$temp, punkty$ndvi)
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  punkty$temp and punkty$ndvi
## t = 1.3317, df = 242, p-value = 0.1842
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.04072759  0.20864535
## sample estimates:
##       cor 
## 0.0852945
```


```r
cor(punkty@data[c(1, 3:5)], use= "complete.obs")
```

```
##             srtm        temp      ndvi       savi
## srtm  1.00000000 -0.14468277 0.1054047 0.08462306
## temp -0.14468277  1.00000000 0.0852945 0.06513805
## ndvi  0.10540468  0.08529450 1.0000000 0.94461511
## savi  0.08462306  0.06513805 0.9446151 1.00000000
```


```r
library('corrplot')
corrplot(cor(punkty@data[c(1, 3:5)], use= "complete.obs"))
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

### Wykresy pudełkowe


```r
punkty$clc <- as.factor(punkty$clc)
ggplot(punkty@data, aes(clc, temp)) + geom_boxplot()
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

- obrazuje pięc podstawowych <br> statystyk opisowych oraz wartości odstające
- pudełko to zakres międzykwantylowy
- linie oznaczają najbardziej ekstremalne wartości, ale nie odstające. Górna to 1,5\*IQR ponad krawędź pudełka, dolna to 1,5\*IQR poniżej wartości dolnej krawędzi pudełka
- linia środkowa to mediana

<!--
1. Tereny komunikacyjne i porty
2. Zabudowa luźna, złożone systemy upraw i działek
3. Grunty orne, Łąki
4. Lasy liściaste,  Lasy iglaste, mieszane
5. Bagna, Torfowiska
6. Zbiorniki wodne
-->

### Testowanie istotności różnić średniej pomiędzy grupami


```r
punkty$clc <- as.factor(punkty$clc)
aov_test <- aov(temp~clc, data=punkty)
summary(aov_test)
```

```
##              Df Sum Sq Mean Sq F value Pr(>F)    
## clc           2   1098   549.1   51.55 <2e-16 ***
## Residuals   241   2567    10.7                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

### Testowanie istotności różnić średniej pomiędzy grupami


```
## null device 
##           1
```


```r
tukey <- TukeyHSD(aov_test, "clc")
plot(tukey, las=1)
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-19-1.png)<!-- -->

## Transformacje danych
### Transformacje danych
- Transformacja danych może mieć na celu ułatwienie porównywania różnych zmiennych, zniwelowanie skośności rozkładu lub też zmniejszenie wpływu danych odstających
- Centrowanie i skalowanie (standaryzacja):
    - Centrowanie danych - wybierana jest przeciętna wartość predyktora, a następnie od wszystkich wartości predyktorów odejmowana jest wybrana wcześniej wartość
    - Skalowanie danych - dzielenie każdej wartości predyktora przez jego odchylenie standardowe
    - Wadą tego podjeścia jest główne zmniejszenie interpretowalności pojedynczych wartości
- Redukcja skośności:
    - Logarytmizacja
    - Pierwiastkowanie
    - Rodzina transformacji Boxa Coxa
    - Inne    

### Transformacja danych | Logarytmizacja


```r
ggplot(punkty@data, aes(temp)) + geom_density()
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-20-1.png)<!-- -->

```r
punkty$log_tpz <- log(punkty$temp)
ggplot(punkty@data, aes(log_tpz)) + geom_density()
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-20-2.png)<!-- -->

```r
punkty$exp_tpz <- exp(punkty$log_tpz)
ggplot(punkty@data, aes(exp_tpz)) + geom_density()
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-20-3.png)<!-- -->

### Transformacja danych | Pierwiastkowanie


```r
ggplot(punkty@data, aes(temp)) + geom_density()
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-21-1.png)<!-- -->

```r
punkty$sqrt_tpz <- sqrt(punkty$temp)
ggplot(punkty@data, aes(sqrt_tpz)) + geom_density()
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-21-2.png)<!-- -->

```r
punkty$pow_tpz <- punkty$sqrt_tpz^2
ggplot(punkty@data, aes(pow_tpz)) + geom_density()
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-21-3.png)<!-- -->

### Transformacja danych | Rodzina transformacji Boxa Coxa


```r
library('caret')
ggplot(punkty@data, aes(temp)) + geom_density()
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-22-1.png)<!-- -->

```r
transformacja <- BoxCoxTrans(punkty$temp)
transformacja
```

```
## Box-Cox Transformation
## 
## 244 data points used to estimate Lambda
## 
## Input data summary:
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   7.805  12.190  15.130  15.320  17.340  26.070 
## 
## Largest/Smallest: 3.34 
## Sample Skewness: 0.508 
## 
## Estimated Lambda: 0.1 
## With fudge factor, Lambda = 0 will be used for transformations
```

```r
punkty$bc_tpz <- predict(transformacja, punkty$temp)
ggplot(punkty@data, aes(bc_tpz)) + geom_density()
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-22-2.png)<!-- -->

```r
invBoxCox <- function(x, lambda) if (lambda == 0) exp(x) else (lambda*x + 1)^(1/lambda) 
punkty$bc_tpz_inv <- invBoxCox(punkty$bc_tpz, lambda=-0.3)
ggplot(punkty@data, aes(bc_tpz_inv)) + geom_density()
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-22-3.png)<!-- -->

## Mapy 

### Podstawowe terminy | Kontekst przestrzenny
- Populacja - cały obszar, dla którego chcemy określić wybrane właściwości
- Próba - zbiór obserwacji, dla których mamy informacje. Inaczej, próba to podzbiór populacji. Zazwyczaj niemożliwe (lub bardzo kosztowne) jest zdobycie informacji o całej populacji. Z tego powodu bardzo cenne jest odpowiednie wykorzystanie informacji z próby.

### Mapy punktowe | Cel
- Sprawdzenie poprawności współrzędnych
- Wgląd w typ próbkowania
- Sprawdzenie poprawności danych - dane odstające lokalnie
- Identyfikacja głównych cech struktury przestrzennej zjawiska (np. trend)

### Typ próbowania
- Regularny
- Losowy
- Losowy stratyfikowany
- Preferencyjny
- Liniowy

### Typ próbowania | Regularny


```r
set.seed(225)
regularny <- spsample(granica, 150, type = 'regular')
plot(regularny)
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-23-1.png)<!-- -->

- Zmienna *offset*

### Typ próbowania | Losowy


```r
set.seed(301)
losowy <- spsample(granica, 150, type = 'random')
plot(losowy)
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-24-1.png)<!-- -->

- Każda lokalizacja ma takie samo prawdopodobieństwo wystąpienia
- Każdy punkt jest losowany niezależnie od pozostałych

### Typ próbowania | Losowy stratyfikowany


```r
set.seed(125)
strat <- spsample(granica, 150, type = 'stratified')
plot(strat)
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-25-1.png)<!-- -->

### Typ próbowania | Preferencyjny I


```r
set.seed(425)
pref <- spsample(granica, 150, type = 'clustered', nclusters=80)
plot(pref)
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-26-1.png)<!-- -->

### Typ próbowania | Liniowy


```r
# library('rgdal')
# linia <- readOGR("data", "linia", verbose=FALSE)
# set.seed(224)
# izoliniowy <- spsample(linia, 150, type = 'regular')
# plot(izoliniowy)
```

### Mapy punktowe i dane lokalnie odstające


```r
par(mar=c(rep(0, 4)))
library('rgdal')
granica <- readOGR(dsn='dane', layer='granica', verbose=FALSE) 
plot(granica) 
plot(punkty, add=TRUE) 
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-28-1.png)<!-- -->


```r
library('sp')
# select.spatial(punkty, digitize=FALSE, rownames=TRUE)
spplot(punkty, "temp", identify=TRUE)
```


```r
spplot(punkty, "temp", sp.layout = granica)
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-29-1.png)<!-- -->

## Rozgrupowanie danych

### Rozgrupowanie danych
- Istnieje szereg metod rozgrupowywania danych, między innymi:
    - Rozgrupowywanie komórkowe
    - Rozgrupowywanie poligonowe
- Celem tych metod jest nadanie wag obserwacjom w celu zapewnienia reprezentatywności przestrzennej danych

### Rozgrupowanie danych


```r
library('sp')
punkty_pref <- read.csv('dane/punkty_pref.csv')
coordinates(punkty_pref) <- ~x+y
proj4string(punkty_pref) <- '+init=epsg:2180'
spplot(punkty_pref, "temp")
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-30-1.png)<!-- -->

```r
summary(punkty_pref$temp)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   8.705  12.500  15.380  15.520  17.960  25.520
```

### Rozgrupowanie komórkowe I | (ang. *cell declustering*)

$$w'_j=\frac{\frac{1}{n_i}}{\text{liczba komórek z danymi}} \cdot n$$
, gdzie $n_i$ to liczba obserwacji w komórce, a $n$ to łączna liczba obserwacji

### Rozgrupowanie komórkowe I | (ang. *cell declustering*)


```r
punkty_pref <- read.csv('dane/punkty_pref.csv')
punkty_pref$id <- 1:nrow(punkty_pref)
coordinates(punkty_pref) <- ~x+y
proj4string(punkty_pref) <- '+init=epsg:2180'
spplot(punkty_pref, "id", colorkey=TRUE)
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-31-1.png)<!-- -->

```r
library('rgdal')
library("raster")
library('rgeos')
granica <- readOGR(dsn = "dane", layer = "granica", verbose = FALSE)
siatka_n <- raster(extent(granica))
# siatka_n <- raster(xmn=450000, xmx=485000, ymn=5960000, ymx=5989000)
res(siatka_n) <- c(500, 500)
siatka_n[] <- 0
proj4string(siatka_n) <- CRS(proj4string(punkty_pref))
siatka_n <- mask(siatka_n, gBuffer(granica, width = 500))
siatka_n <- as(siatka_n, "SpatialPolygonsDataFrame")
siatka_n <- siatka_n[!is.na(siatka_n@data$layer), ]
plot(siatka_n)
plot(punkty_pref, add=TRUE)
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-31-2.png)<!-- -->

```r
punkty_pref$liczebnosc <- rep(0, length(punkty_pref))
siatka_nr <- aggregate(punkty_pref['liczebnosc'], by = siatka_n, FUN = length) 
spplot(siatka_nr, "liczebnosc")
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-31-3.png)<!-- -->

```r
liczba <- over(punkty_pref, siatka_nr)
punkty_pref$waga <- ((1/liczba$liczebnosc)/sum(!is.na(siatka_nr$liczebnosc))) * length(punkty_pref)

spplot(punkty_pref, 'waga')
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-31-4.png)<!-- -->

```r
srednia_arytmetyczna <- mean(punkty_pref$temp)
srednia_wazona_c1 <- mean(punkty_pref$temp * punkty_pref$waga, na.rm=TRUE)
```


### Rozgrupowanie komórkowe II | (ang. *cell declustering*)
<!--
- Przygotowanie danych
https://stat.ethz.ch/pipermail/r-sig-geo/2010-February/007710.html

When "interpolating" with nmax=1, you basically assign the value of the 
nearest observation to each grid cell, so, honoustly, it's hard to call 
this interpolation, it is rather something of a discretized Thiessen 
polygon.
-->


```r
library('gstat')
punkty_pref <- read.csv('dane/punkty_pref.csv')
punkty_pref$id <- 1:nrow(punkty_pref)
coordinates(punkty_pref) <- ~x+y
proj4string(punkty_pref) <- '+init=epsg:2180'
spplot(punkty_pref, "id", colorkey=TRUE)
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-32-1.png)<!-- -->

```r
library('raster')
granica <- readOGR(dsn='dane', layer='granica', verbose=FALSE)
siatka_n <- raster(extent(granica))
res(siatka_n) <- c(500, 500)
siatka_n[] <- 0
proj4string(siatka_n) <- CRS(proj4string(punkty_pref))
siatka_n <- mask(siatka_n, granica)
siatka_n <- as(siatka_n, 'SpatialPointsDataFrame')
siatka_n <- siatka_n[!is.na(siatka_n@data$layer), ]
gridded(siatka_n) <- TRUE
plot(siatka_n)
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-32-2.png)<!-- -->


```r
out <-  krige(id~1, punkty_pref, siatka_n, nmax=1)
```

```
## [inverse distance weighted interpolation]
```

```r
spplot(out, "var1.pred")
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-33-1.png)<!-- -->

```r
df <- as.data.frame(table(out[[1]]))
df$waga <- df$Freq/sum(df$Freq)
punkty_pref <- merge(punkty_pref, df, by.x="id", by.y="Var1")
summary(punkty_pref$waga)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
## 0.00389 0.00389 0.00389 0.00552 0.00778 0.01556      61
```

```r
spplot(out, "var1.pred", sp.layout=list("sp.points", punkty_pref))
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-33-2.png)<!-- -->

```r
spplot(punkty_pref["waga"])
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-33-3.png)<!-- -->

```r
srednia_arytmetyczna <- mean(punkty_pref$temp)
srednia_wazona_c2 <- sum(punkty_pref$temp * punkty_pref$waga, na.rm=TRUE)
```

### Rozgrupowanie poligonowe | (ang. *polygon declustering*)
$$w'_j=\frac{area_j}{\sum_{j=1}^{n}area_j} \cdot n$$
, gdzie $area_j$ powierzchnia dla wybranej obserwacji, a $n$ to łączna liczba obserwacji

### Rozgrupowanie poligonowe | (ang. *polygon declustering*)


```r
punkty_pref <- read.csv('dane/punkty_pref.csv')
punkty_pref$id <- 1:nrow(punkty_pref)
coordinates(punkty_pref) <- ~x+y
proj4string(punkty_pref) <- '+init=epsg:2180'
spplot(punkty_pref, "id", colorkey=TRUE)
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-34-1.png)<!-- -->

```r
library('dismo')
v <- voronoi(punkty_pref)
plot(punkty_pref, cex=0.2, col='red')
plot(v, add=TRUE)
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-34-2.png)<!-- -->

```r
library('rgeos')
v_intersect <-intersect(granica, v)
plot(punkty_pref, cex=0.2, col='red')
plot(v_intersect, add=TRUE)
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-34-3.png)<!-- -->

```r
v_intersect$pow <- area(v_intersect)
v_intersect$waga <- v_intersect$pow/sum(v_intersect$pow) * length(punkty_pref)

punkty_pref <- merge(punkty_pref, v_intersect[c('id', 'waga')], by='id')
spplot(punkty_pref, 'waga')
```

![](02-eksp_analiza_danych_files/figure-html/unnamed-chunk-34-4.png)<!-- -->

```r
srednia_arytmetyczna <- mean(punkty_pref$temp, na.rm=TRUE)
srednia_wazona_p <- mean(punkty_pref$temp*punkty_pref$waga, na.rm=TRUE)
```



                              Średnia arytmetyczna
---------------------------  ---------------------
Populacja                                 15.59128
Próba                                     15.52427
Rozgrupowanie komórkowe I                 17.53834
Rozgrupowanie komórkowe II                15.32633
Rozgrupowanie poligonowe                  18.33385

<!--
polygon declustering - http://gis.stackexchange.com/questions/122376/cell-declustering-using-open-source-software
cell declustering - https://stat.ethz.ch/pipermail/r-sig-geo/2010-February/007710.html
http://gaa.org.au/pdf/DeclusterDebias-CCG.pdf
-->
