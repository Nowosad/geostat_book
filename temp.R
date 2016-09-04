bookdown::publish_book()
beepr::beep()

# bookdown::publish_book(name='geostat_book', account='nowosad', render='server')
# 
# RStudio version 0.99.1119 on Ubuntu 14.04
# devtools::install_github("hadley/devtools")
# devtools::install_github('rstudio/bookdown')
# bookdown::publish_book(render='none')
install.packages('beepr')
beepr::beep(0)

#pdf
Sys.setenv(RSTUDIO_PANDOC="/usr/lib/rstudio/bin/pandoc")

bookdown::render_book("index.Rmd", "bookdown::pdf_book", output_dir='pdf_ania')
beepr::beep(0)

bookdown::render_book(input="index.Rmd")
bookdown::publish_book(name='Geostatystyka', account='nowosad')
beepr::beep(0)

#ebook
bookdown::render_book("index.Rmd", "bookdown::epub_book")
beepr::beep()

#clean
bookdown::clean_book(FALSE)
bookdown::clean_book(TRUE)

