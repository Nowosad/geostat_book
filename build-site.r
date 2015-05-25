library(rmarkdown)

# Type in the .rmd filenames in the order you wish them to be displayed.
rmdFileNames <- c(
  "index.rmd", 
  "example1.rmd",
  "example2.rmd",
  "example3.rmd"
)

# Fixes directory structure and remove any old build directory.
htmlFileNames <- gsub(".rmd", ".html", rmdFileNames, fixed = TRUE)
rmdFileNames <- paste("rmd/", rmdFileNames, sep="")
unlink("build", recursive = TRUE)

# Render the .rmd files to html. Type in your desired pandoc metadata.
lapply(
  rmdFileNames, 
  rmarkdown::render, 
  output_dir = "../build",
  html_document(
    smart = TRUE,
    self_contained = FALSE,
    lib_dir = "../www/assets",
    template = "../www/templates/default.html",
    theme = NULL,
    highlight = NULL,
    mathjax = NULL,
    pandoc_args = c(
      "--metadata", "booktitle=Book Title",
      "--metadata", "link1=http://example.org",
      "--metadata", "linktext1=example.org",
      "--metadata", "link2=http://example.org",
      "--metadata", "linktext2=example.org",
      "--metadata", "lang=en"
    )
  )
)

# Insert the table of contents and page navigation.
source("scripts/toc.r")
source("scripts/page-nav.r")

# Prepare build directory
source("scripts/build-dir.r")
