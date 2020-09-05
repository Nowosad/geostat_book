library(DiagrammeR)
library(DiagrammeRsvg)
library(magrittr)
library(rsvg)

p = DiagrammeR::mermaid("
                graph TB;
                Pozyskanie[<center>Pozyskanie <br>i wstępna weryfikacja danych</center>];
                Pozyskanie-->Eksploracja[<center>Nieprzestrzenna i przestrzenna <br>Eksploracja danych</center>];
                Eksploracja-->Analiza[<center>Analiza <br>i interpretacja <br>struktury przestrzennej</center>];
                Analiza -->Modelowanie[<center>Modelowanie matematyczne <br>struktury przestrzennej</center>];
                Modelowanie -->Estymacja;
                Modelowanie -->Optymalizacja;
                Modelowanie -->Symulacja;
                ")

# plotly::export(p,
#                file = "figs/diag.png",
#                vwidth = 466,
#                vheight = 529)



