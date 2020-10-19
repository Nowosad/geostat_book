library(DiagrammeR)
library(DiagrammeRsvg)
library(magrittr)
library(rsvg)

pg = DiagrammeR::mermaid('
                graph TB;
                Pozyskanie[<center>Pozyskanie <br>i wstępna weryfikacja danych</center>];
                Pozyskanie-->Eksploracja[<center>Nieprzestrzenna i przestrzenna <br>eksploracja danych</center>];
                Eksploracja-->Analiza[<center>Analiza <br>i interpretacja <br>struktury przestrzennej</center>];
                Analiza -->Modelowanie["<center>Modelowanie matematyczne <br>struktury przestrzennej (autokorelacji przestrzennej) </center>"];
                
                Modelowanie -->Estymacja;
                Modelowanie -->Optymalizacja;
                Estymacja -->Symulacja;
                
                Modelowanie -->Symulacja;
                Estymacja -->Optymalizacja;
                Symulacja -->Optymalizacja;
                Optymalizacja -->Pozyskanie;
                
                ')

pg
# plotly::export(pg,
#                file = "figs/diag.png",
#                vwidth = 466,
#                vheight = 529)
