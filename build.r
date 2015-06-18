library(rmarkdown)
library(tikzDevice)

# Read in toc, create file names, and remove old folders.
rmdFileNames <- read.csv("rmd/_toc.csv", header = FALSE)
rmdFileNames <- as.character(rmdFileNames$V1) # Need character vector
htmlFileNames <- gsub(".rmd", ".html", rmdFileNames, fixed = TRUE)
texFileNames <- gsub(".rmd", ".tex", rmdFileNames, fixed = TRUE)
rmdFileNames <- paste("rmd/", rmdFileNames, sep="") # Need relative path
unlink("html", recursive = TRUE)
unlink("pdf", recursive = TRUE)

# Set knitr options.
knitr_opts <- function(type = c("html", "tex")) {
  type <- match.arg(type)
  pkg <- list()
  chunk <- list(
    cache = TRUE,
    cache.path = "_cache/",
    fig.path = "figures/",
    comment = "#>",
    collapse = TRUE,
    error = FALSE,
    fig.width = 4,
    fig.height = 4,
    dev.args = list(pointsize = 10)
  )
  if (type == "html") {
    chunk$dev <- "png"
    chunk$fig.ext <- "png"
    chunk$dpi <- 96
    chunk$fig.retina <- 2
  } else {
    chunk$external <- FALSE
    chunk$dev <- "tikz"
    chunk$fig.align <- "center" # If this is not included then tikz file wont be wrapped in "input" in tex file. A bug?
    pkg$width <- 80
  }
  hooks <- list()
  rmarkdown::knitr_options(pkg, chunk, hooks)
}

# Redefine html_document command so that it takes on knitr_opts.
rbook_html <- function(toc = FALSE, ...) {
  base <- rmarkdown::html_document(toc = toc, ...)
  base$knitr <- knitr_opts("html")
  base
}
# Render the rmd files to html.
lapply(
  rmdFileNames, 
  rmarkdown::render, 
  output_dir = "html",
  output_format = "rbook_html"
)
# Copy html files (images) from rmd directory to html directory.
htmlFigureNames <- dir("rmd/figures", pattern = "\\.png$")
htmlFigureNames <- paste("rmd/figures/", htmlFigureNames, sep="")
dir.create("html/figures/")
file.copy(from = htmlFigureNames, to = "html/figures/", recursive = TRUE)

# Insert the table of contents and page navigation into html.
# Copy html files from build directory to html directory.
source("build/scripts/html-toc.r")
source("build/scripts/html-nav.r")
source("build/scripts/html-dir.r")

# Redefine pdf_document command so that it only outputs tex files and takes on
# knitr_opts.
rbook_tex <- function(toc = FALSE, ...) {
  base <- rmarkdown::pdf_document(toc = toc, ...)
  base$pandoc$ext <- ".tex"
  base$knitr <- knitr_opts("tex")
  base
}
# Render the rmd files to tex.
lapply(
  rmdFileNames, 
  rmarkdown::render, 
  output_dir = "pdf",
  output_format = "rbook_tex"
)

# Copy tikz files from rmd directory to pdf directory.
tikzFileNames <- dir("rmd/figures", pattern = "\\.tikz$")
tikzFileNames <- paste("rmd/figures/", tikzFileNames, sep="")
dir.create("pdf/figures/")
file.copy(from = tikzFileNames, to = "pdf/figures/", recursive = TRUE)

# Copy tex files from build directory to pdf directory.
pdfFileNames <- dir("build/pdf/")
pdfFileNames <- paste("build/pdf/", pdfFileNames, sep = "")
file.copy(from = pdfFileNames, to = "pdf/", recursive = TRUE)

# Copy main tex file from rmd directory to pdf directory.
file.copy(from = "rmd/rbook.tex", to = "pdf/", recursive = TRUE)

# Build pdf
wdOld <- getwd()
setwd("pdf")
system("pdflatex -interaction=nonstopmode rbook.tex ")
system("pdflatex -interaction=nonstopmode rbook.tex ")
setwd(wdOld)

# Clean rmd directory
