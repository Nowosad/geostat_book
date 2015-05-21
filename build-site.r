library(rmarkdown)

# Type in the .rmd filenames in the order you wish them to be displayed.
rmdFileNames <- c("index.rmd", 
                  "example1.rmd",
                  "example2.rmd",
                  "example3.rmd"
                  )

# Creates html file names and fixes directory structure for the scripts.
htmlFileNames <- gsub(".rmd", ".html", rmdFileNames, fixed = TRUE)
rmdFileNames <- paste("source/", rmdFileNames, sep="")

# Render the .rmd files to html.
lapply(rmdFileNames, rmarkdown::render)

# Insert the table of contents and page navigation.
source("scripts/toc.r")
source("scripts/page-nav.r")

# Create build folder and cleanup files.
source("scripts/build-folder.r")
