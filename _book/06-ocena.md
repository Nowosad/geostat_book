---
knit: bookdown::preview_chapter
---

# Ocena jakości estymacji [UWAGA POMIESZANY ME Z RESZTĄ!!]





## Statystyki jakości estymacji
### Statystyki jakości estymacji
- Służą do oceny i porównania jakości estymacji
- Do podstawowych statystyk ocen jakości estymacji należą:
    - Średni błąd estymacji (ME, ang. *mean error*)
    - Pierwiastek średniego błędu kwadratowego (RMSE, ang. *root square prediction error*)
    - Współczynnik korelacji
    - Rozkład błędu (np. 5. percentyl, mediana, 95. percentyl)
    
### Statystyki jakości estymacji
- Idealna estymacja dawałaby brak błędu oraz wspołczynnik korelacji pomiędzy pomiarami (całą populacją) i szacunkiem równy 1
- Wysokie, pojedyncze wartości błędu mogą świadczyć, np. o wystapieniu wartości odstających

    
### Średni błąd estymacji
- Optymalnie wartość średniego błędu estymacji powinna być jak najbliżej 0

$$ ME=\frac{\sum_{i=1}^{n}(\hat{v}_i-v_i)}{n} $$     

### Pierwiastek średniego błędu kwadratowego
- Optymalnie wartość pierwiastka średniego błędu kwadratowego powinna być jak najmniejsza

$$ RMSE=\sqrt{\frac{\sum_{i=1}^{n}(\hat{v}_i-v_i)^2}{n}} $$     

### Współczynnik korelacji
- Optymalnie wartość współczynnika korelacji powinna być jak najwyższa

### Statystyki jakości estymacji | Mapa

![](06-ocena_files/figure-html/mapa-1.png)<!-- -->


### Statystyki jakości estymacji | Histogram


![](06-ocena_files/figure-html/hist-1.png)<!-- -->

### Statystyki jakości estymacji | Wykres rozrzutu


![](06-ocena_files/figure-html/point-1.png)<!-- -->


## Walidacja wyników estymacji

### Walidacja wyników estymacji
- Dokładne dopasowanie modelu do danych może w efekcie nie dawać najlepszych wyników
- W efekcie ważne jest stosowanie metod pozwalających na wybranie optymalnego modelu
- Do takich metod należy, między innymi, walidacja podzbiorem (ang. *jackknifing*) oraz kroswalidacja (ang. *crossvalidation*)

### Walidacja podzbiorem 
- Polega na podziale zbioru danych na dwa podzbiory - treningowy i testowy
- Zbiór treningowy służy do estymacji wartości
- Wynik estymacji porównywany jest z rzeczywistymi wartościami ze zbioru testowego
- Zaletą tego podejścia jest stosowanie danych niezależnych od estymacji
- Wadą jest konieczność posiadania dużego zbioru danych

### Walidacja podzbiorem 


```r
library('caret')
set.seed(124)
indeks <- as.vector(createDataPartition(wolin_lato_los$X2002.08.20_TPZ, p=0.75, list=FALSE))
indeks
```

```
##   [1]   1   2   3   4   5   6   7   8   9  10  12  13  14  16  17  18  19
##  [18]  21  23  24  25  26  27  28  29  30  32  33  35  39  40  42  43  44
##  [35]  45  46  47  48  49  50  51  52  54  55  56  57  58  59  60  61  62
##  [52]  63  64  67  68  70  71  72  75  76  77  78  79  81  82  83  85  86
##  [69]  87  88  89  90  91  92  93  94  95  96  97  98 102 103 104 105 106
##  [86] 107 108 109 111 112 114 115 116 117 118 120 122 123 124 125 127 128
## [103] 129 130 134 136 138 141 142 144 146 147 148 150 151 152 153 155 156
## [120] 157 158 159 160 161 162 163 164 168 169 170 171 173 174 175 177 179
## [137] 180 181 183 184 185 186 187 188 189 190 192 194 195 196 197 198 199
## [154] 200 201 203 204 205 206 207 208 209 210 211 212 213 214 215 217 218
## [171] 219 220 221 223 225 228 230 231 232 233 234 235 236 237 239 240 241
## [188] 242 243 244 246 248 249 250 251 252 253 254 255 257 258 259 262 264
## [205] 265 266 267 268 269 270 271 272 273 274 275 277 279 280 281 286 288
## [222] 289 290 291 292 293 295 297 298 300 301 303 305 307 309 310 311 314
## [239] 315 316 317 318 319 320 321 322 323 324 327 328 329 330 331 334 335
## [256] 336 337 338 339 340 342 343 344 346 347 348 349 350 351 353 354 355
## [273] 357 359 360 361 366 368 369 372 374 376 377 382 383 384 385 386 390
## [290] 391 392 393 395 397 398 399 400 403 404 405 406 407 408 409 411 413
## [307] 415 419 421 422 423 424 425 426 427 428 429 430 433 435 438 439 440
## [324] 441 442 443 444 445 446 448 450 452 453 454 455 458 459 461 466 467
## [341] 468 471 473 474 475 476 477 478 479 481 482 483 484 485 486 488 489
## [358] 490 491 492 493 494 495 496 498 500 501 502 503 504 505 506 507 509
## [375] 512 513 514 515 516 517 518 519 520 521 522 524 525 526 527 528 529
## [392] 530 531 532 533 534 537 538 539 540 541 542 543 544 547 548 549 550
## [409] 551 552 554 555 556 557 558 559 560 561 562 564 565 566 567 568 569
## [426] 570 574 576 577 578 579 580 581 582 583 584 585 586 587 588 589 592
## [443] 593 594 595 596 597 598 601 602 603 604 605 606 607 608 609 610 611
## [460] 614 615 616 617 619 620 621 622 623 624 625 626 627 628 629 630 631
## [477] 632 633 634 635 636 637 638 640 641 643 644 645 646 647 648 649 650
## [494] 651 652 653 656 657 658 659 660 661 664 665 667 668 669 670 671 672
## [511] 673 674 675 676 677 678 679 680 681 682 683 684 685 687 689 693 694
## [528] 695 696 699 700 701 702 703 705 706 713 714 716 718 719 720 722 723
## [545] 724 726 727 729 730 733 734 735 736 737 738 739 740 741 742 743 744
## [562] 745 746 750
```

```r
train <- wolin_lato_los[indeks, ]
test <- wolin_lato_los[-indeks, ]
vario <- variogram(X2002.08.20_TPZ~1, data=train)
model_zl2 <- vgm(10, model = 'Sph', range = 4000, add.to = vgm(5, "Gau", 8000, nugget = 5))
model_zl2
```

```
##   model psill range
## 1   Nug     5     0
## 2   Gau     5  8000
## 3   Sph    10  4000
```

```r
fitted_zl2 <- fit.variogram(vario, model_zl2)
plot(vario, model=fitted_zl2)
```

![](06-ocena_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

```r
test_sk <- krige(X2002.08.20_TPZ~1, train, test, model=fitted_zl2, beta=23.6)
```

```
## [using simple kriging]
```

```r
summary(test_sk)
```

```
## Object of class SpatialPointsDataFrame
## Coordinates:
##       min     max
## X  451860  482250
## Y 5962620 5985510
## Is projected: TRUE 
## proj4string :
## [+init=epsg:32633 +proj=utm +zone=33 +datum=WGS84 +units=m +no_defs
## +ellps=WGS84 +towgs84=0,0,0]
## Number of points: 186
## Data attributes:
##    var1.pred        var1.var     
##  Min.   :19.14   Min.   : 8.354  
##  1st Qu.:21.19   1st Qu.: 9.340  
##  Median :22.77   Median : 9.858  
##  Mean   :23.57   Mean   : 9.959  
##  3rd Qu.:25.51   3rd Qu.:10.377  
##  Max.   :33.44   Max.   :12.363
```

```r
reszta_sk <-  test_sk$var1.pred - test$X2002.08.20_TPZ
summary(reszta_sk)
```

```
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
## -12.99000  -1.28700   0.46090  -0.05885   1.79100   7.78600
```

```r
ME <- sum(reszta_sk)/length(reszta_sk)
ME
```

```
## [1] -0.05885324
```

```r
RMSE <- sqrt(sum(reszta_sk^2)/length(reszta_sk))
RMSE
```

```
## [1] 3.173024
```

```r
srednia_reszta <- test$X2002.08.20_TPZ - mean(test$X2002.08.20_TPZ)
R2 <- 1 - sum(reszta_sk^2)/sum(srednia_reszta^2)
R2
```

```
## [1] 0.5150169
```

```r
test_sk$reszty <- reszta_sk
spplot(test_sk, "reszty")
```

![](06-ocena_files/figure-html/unnamed-chunk-1-2.png)<!-- -->


### Kroswalidacja
- W przypadku kroswalidacji te same dane wykorzystywane są do budowy modelu, estymacji, a następnie do oceny prognozy
- Procedura kroswalidacji LOO (ang. *leave-one-out cross-validation*)

1. Zbudowanie matematycznego modelu z dostępnych obserwacji
2. Dla każdej znanej obserwacji następuje:
    - Usunięcie jej ze zbioru danych
    - Użycie modelu do wykonania predykcji w miejscu tej obserwacji
    - Wyliczenie reszty (ang. *residual*), czyli różnicy pomiędzy znaną wartością a obserwacją
3. Podsumowanie otrzymanych wyników
    
- W pakiecie **gstat**, kroswalidacja LOO jest dostępna w funkcjach *krige.cv* oraz *gstat.cv*

### Kroswalidacja 



```r
vario <- variogram(X2002.08.20_TPZ~1, data=wolin_lato_los)
model_zl2 <- vgm(10, model = 'Sph', range = 4000, add.to = vgm(5, "Gau", 8000, nugget = 5))
fitted_zl2 <- fit.variogram(vario, model_zl2)

cv_sk <- krige.cv(X2002.08.20_TPZ~1, wolin_lato_los, model=fitted_zl2, beta=23.6)
summary(cv_sk)
```

```
## Object of class SpatialPointsDataFrame
## Coordinates:
##       min     max
## X  451470  483570
## Y 5962620 5985510
## Is projected: NA 
## proj4string : [NA]
## Number of points: 750
## Data attributes:
##    var1.pred        var1.var         observed        residual        
##  Min.   :18.10   Min.   : 8.320   Min.   :17.11   Min.   :-11.56584  
##  1st Qu.:21.16   1st Qu.: 9.186   1st Qu.:20.48   1st Qu.: -1.57822  
##  Median :22.61   Median : 9.571   Median :21.89   Median : -0.38231  
##  Mean   :23.57   Mean   : 9.673   Mean   :23.56   Mean   : -0.01102  
##  3rd Qu.:25.62   3rd Qu.:10.027   3rd Qu.:25.81   3rd Qu.:  0.96534  
##  Max.   :33.78   Max.   :12.626   Max.   :41.79   Max.   : 13.74115  
##      zscore               fold      
##  Min.   :-3.740951   Min.   :  1.0  
##  1st Qu.:-0.502235   1st Qu.:188.2  
##  Median :-0.119653   Median :375.5  
##  Mean   :-0.001631   Mean   :375.5  
##  3rd Qu.: 0.314956   3rd Qu.:562.8  
##  Max.   : 4.526214   Max.   :750.0
```

```r
spplot(cv_sk, "residual")
```

![](06-ocena_files/figure-html/loovv-1.png)<!-- -->


<!-- 


```r
# ok_loocv <- krige.cv(X2002.08.20_TPZ~1, wolin_lato_los, model=model_zl2)
# summary(ok_loocv)
```


- Tutaj inne przykłady
- Wykresy z loocv
- wykresy porównujące



```r
# ok_fit <- gstat(formula=X2002.08.20_TPZ~1, data=wolin_lato_los, model=model_zl2)
# ok_loocv <- gstat.cv(OK_fit, debug.level=0, random=FALSE)
# spplot(pe[6])
```




```r
#
```

## 
- prezentacja 5 Ani
- spatinter folder
- AIC

## Walidacja wyników estymacji

### Walidacja wyników estymacji |  Kriging zwykły - LOO crossvalidation
krige.cv


```r
# OK_fit <- gstat(id="OK_fit", formula=X2002.08.20_TPZ~1, data=wolin_lato_los, model=fitted)
# pe <- gstat.cv(OK_fit, debug.level=0, random=FALSE)
# spplot(pe[6])
# 
# z <- predict(OK_fit, newdata = grid, debug.level = 0)
# grid2 <- grid
# grid2$OK_pred <- z$OK_fit.pred
# grid2$OK_se <- sqrt(z$OK_fit.var)
# library('rasterVis')
# spplot(grid2, 'OK_pred')
# spplot(grid2, 'OK_se')
```

### Walidacja wyników estymacji |  K  Kriging uniwersalny - LOO crossvalidation


```r
# KU_fit <- gstat(id="KU_fit", formula=X2002.08.20_TPZ~odl_od_morza, data=wolin_lato_los, model=fitted_ku)
# pe <- gstat.cv(KU_fit, debug.level=0, random=FALSE)
# spplot(pe[6])

# dodanie odległości od morza do siatki !!
# z_KU <- predict(KU_fit, newdata = grid, debug.level = 0)
# grid$KU_pred <- z$KU_fit.pred
# grid$KU_se <- sqrt(z$KU_fit.var)
# library('rasterVis')
# spplot(grid, 'KU_pred')
# spplot(grid, 'KU_se')
```


-->


