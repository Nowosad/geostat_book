#!/usr/bin/env Rscript
if (!require(rsconnect)) install.packages('rsconnect')
bookdown::publish_book(name = "Geostatystyka", account = "nowosad", render = c("none"), server = "bookdown.org")
