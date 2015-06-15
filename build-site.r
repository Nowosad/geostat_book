library(rmarkdown)

# Read in toc, create file names, and remove old build folder.
rmdFileNames <- read.csv("rmd/_toc.csv", header = FALSE)
rmdFileNames <- as.character(rmdFileNames$V1)
htmlFileNames <- gsub(".rmd", ".html", rmdFileNames, fixed = TRUE)
rmdFileNames <- paste("rmd/", rmdFileNames, sep="")
unlink("build", recursive = TRUE)

# Renders the rmd files to html.
lapply(rmdFileNames, rmarkdown::render, output_dir = "build")

# Insert the table of contents and page navigation.
source("scripts/toc.r")
source("scripts/page-nav.r")

# Prepare build directory
source("scripts/build-dir.r")
