#!/usr/bin/env Rscript
if (!require(rsconnect)) install.packages("Cairo")
bookdown::publish_book(name = "Geostatystyka", account = "nowosad", render = c("none"), server = "bookdown.org")
