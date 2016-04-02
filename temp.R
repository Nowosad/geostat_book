bookdown::publish_book()
bookdown::publish_book(name='geostat_book', account='nowosad', render='server')

RStudio version 0.99.1119 on Ubuntu 14.04
devtools::install_github("hadley/devtools")
devtools::install_github('rstudio/bookdown')
bookdown::publish_book(render='none')


bookdown::render_book('index.Rmd', output_format='bookdown::pdf_book')
