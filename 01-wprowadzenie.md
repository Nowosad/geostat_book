
# Wprowadzenie

## Geostatystyczna analiza danych

> Geostatystyka to gałąź statystyki skupiająca się na przestrzennych lub czasoprzestrzennych zbiorach danych

Geostatystyka jest stosowana obecnie w wielu dyscyplinach, takich jak geologia naftowa, oceanografia, geochemia, logistyka, leśnictwo, gleboznawstwo, hydrologia, meteorologia, czy epidemiologia.
<!--refs-->

Geostatystyczna analiza danych może przyjmować różną postać w zależności od postawionego celu analizy.
Rycina \@ref(fig:01-wprowadzenie-1) przestawia uproszczoną ścieżkę postępowania geostatystycznego.

<div class="figure" style="text-align: center">
<img src="figs/diag.png" alt="Uproszczona ścieżka postępowania geostatystycznego." width="100%" />
<p class="caption">(\#fig:01-wprowadzenie-1)Uproszczona ścieżka postępowania geostatystycznego.</p>
</div>

Punktem wyjścia analizy geostatystycznej jest posiadanie danych przestrzennych opisujących badane zjawisko, np. w **postaci punktowej** (rycina \@ref(fig:01-wprowadzenie-3)).



<div class="figure" style="text-align: center">
<img src="01-wprowadzenie_files/figure-html/01-wprowadzenie-3-1.png" alt="Przykładowe dane reprezentujące pomiary punktowe zmiennej numerycznej." width="100%" />
<p class="caption">(\#fig:01-wprowadzenie-3)Przykładowe dane reprezentujące pomiary punktowe zmiennej numerycznej.</p>
</div>

Dane należy poddać eksploracji w celu ich lepszego poznania, wyszukania relacji między zmiennymi, czy znalezienia potencjalnych błędów (rycina \@ref(fig:01-wprowadzenie-3b)).

<div class="figure" style="text-align: center">
<img src="01-wprowadzenie_files/figure-html/01-wprowadzenie-3b-1.png" alt="Rozkład wartości zmiennej numerycznej." width="100%" />
<p class="caption">(\#fig:01-wprowadzenie-3b)Rozkład wartości zmiennej numerycznej.</p>
</div>

Na ich podstawie chcemy zrozumieć zmienność przestrzenną analizowanej cechy.
Do tego może nam posłużyć wykres nazywany **semiwariogramem** (rycina \@ref(fig:01-wprowadzenie-4)).

<div class="figure" style="text-align: center">
<img src="01-wprowadzenie_files/figure-html/01-wprowadzenie-4-1.png" alt="Wykres, nazywany semiwariogramem, reprezentujący niepodobieństwo wartości wraz z odległością." width="100%" />
<p class="caption">(\#fig:01-wprowadzenie-4)Wykres, nazywany semiwariogramem, reprezentujący niepodobieństwo wartości wraz z odległością.</p>
</div>

**Semiwariogram** opisuje przestrzenną zmienność badanej cechy i za jego pomocą możemy stwierdzić jak to zjawisko zmienia się w przestrzeni.
Dodatkowo za pomocą **mapy semiwariogramu** (rycina \@ref(fig:01-wprowadzenie-5)) możliwe jest stwierdzenie czy istnieją jakieś kierunki w których ta cecha zmienia się zmienia bardziej dynamicznie, a w których ta zmiana jest wolniejsza.

<div class="figure" style="text-align: center">
<img src="01-wprowadzenie_files/figure-html/01-wprowadzenie-5-1.png" alt="Mapa semiwariogramu reprezentująca niepodobieństwo wartości wraz z odległością i kierunkiem." width="100%" />
<p class="caption">(\#fig:01-wprowadzenie-5)Mapa semiwariogramu reprezentująca niepodobieństwo wartości wraz z odległością i kierunkiem.</p>
</div>

Następnie korzystając z wiedzy uzyskanej z semiwariogramu i mapy semiwariogramu, jesteśmy w stanie stworzyć **model semiwariogramu** (rycina \@ref(fig:01-wprowadzenie-6)).

<div class="figure" style="text-align: center">
<img src="01-wprowadzenie_files/figure-html/01-wprowadzenie-6-1.png" alt="Model reprezentowany przez ciągłą linię naniesiony na semiwariogram." width="100%" />
<p class="caption">(\#fig:01-wprowadzenie-6)Model reprezentowany przez ciągłą linię naniesiony na semiwariogram.</p>
</div>

Pozwala on zarówno na lepszy opis zmienności zjawiska, jak również służy do tworzenia **estymacji** czy też **symulacji**.
Estymacja tworzy najbardziej potencjalnie możliwą wartość dla wybranej lokalizacji (rycina \@ref(fig:01-wprowadzenie-7)).

<div class="figure" style="text-align: center">
<img src="01-wprowadzenie_files/figure-html/01-wprowadzenie-7-1.png" alt="Estymacja (oszacowanie) wartości badanej zmiennej dla całego obszaru." width="100%" />
<p class="caption">(\#fig:01-wprowadzenie-7)Estymacja (oszacowanie) wartości badanej zmiennej dla całego obszaru.</p>
</div>

Rolą symulacji (rycina \@ref(fig:01-wprowadzenie-8)) jest natomiast generowanie równie prawdopodobne możliwości rozkładu badanej cechy.

<div class="figure" style="text-align: center">
<img src="01-wprowadzenie_files/figure-html/01-wprowadzenie-8-1.png" alt="Przykłady symulowanych wartości badanej zmiennej dla całego obszaru." width="100%" />
<p class="caption">(\#fig:01-wprowadzenie-8)Przykłady symulowanych wartości badanej zmiennej dla całego obszaru.</p>
</div>

Każdy z powyższych elementów geostatystycznej analizy danych zostanie rozwinięty w dalszych rozdziałach tego skryptu.

<!-- po co to - prosta analiza bez kodu -->
<!-- http://dmowska-zajecia.home.amu.edu.pl/data/uploads/geostatystyka/materialy/1_wprowadzenie.html -->
