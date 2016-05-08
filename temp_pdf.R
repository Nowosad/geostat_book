# bookdown::publish_book()
# beepr::beep()

# bookdown::publish_book(name='geostat_book', account='nowosad', render='server')
# 
# RStudio version 0.99.1119 on Ubuntu 14.04
# devtools::install_github("hadley/devtools")
# devtools::install_github('rstudio/bookdown')
# bookdown::publish_book(render='none')
# install.packages('beepr')
# beepr::beep()

#pdf
Sys.setenv(RSTUDIO_PANDOC="/usr/lib/rstudio/bin/pandoc")

bookdown::render_book("index.Rmd", "bookdown::pdf_book")
# beepr::beep()

#ebook
# bookdown::render_book("index.Rmd", "bookdown::epub_book")
# beepr::beep()

#clean
# bookdown::clean_book(TRUE)

