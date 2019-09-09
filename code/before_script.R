library(methods)
library(ggplot2)
library(rcartocolor)
knitr::opts_chunk$set(warning = FALSE,
                      message = FALSE,
                      out.width = "\\textwidth",
                      fig.align = "center",
                      fig.width = 9,
                      fig.show = "hold")
options(scipen = 99 * 99)
p1_base = ggplot() +
        coord_equal() +
        rcartocolor::scale_fill_carto_c(palette = "ag_Sunset",
                                        na.value = "#ffffff") +
        theme_void() +
        scale_x_discrete(expand = c(0, 0)) +
        scale_y_discrete(expand = c(0, 0)) +
        labs(fill = "")