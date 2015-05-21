################################################################################
# Creates and inserts the table of contents html fragment.
################################################################################
library(stringr)

# multiple substitute gsub function.
mgsub <- function(pattern, replacement, x, ...) {
  if (length(pattern)!=length(replacement)) {
    stop("pattern and replacement do not have the same length.")
  }
  result <- x
  for (i in 1:length(pattern)) {
    result <- gsub(pattern[i], replacement[i], result, ...)
  }
  result
}

# Characters that need to be removed in header element id generated by pandoc
metaChar <- c(" ", "=", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "+", "[", 
                "]", "{", "}", "<", ">", ",", ";", ":", "?", "/", "\\", "|", "'", 
                "\"")
# Corresponding substitutions for the header element id generated by pandoc
idChar <- c("-", rep("", length(metaChar)-1))

#===============================================================================
# Create an html fragment that wil be used as the table of contents (summary)
# The first level will link to each page. The second level will link to second 
# level headers inside the page.
#===============================================================================
# The first page (index) will only use the level one header
rmdFile <- readLines(rmdFileNames[1])

# Find where fenced code blocks are and store their location
# We cant have R comments (#) confused with markdown headers (#)
fenceLocation <- which(str_sub(rmdFile, start = 1, end = 3) == "```")
codeMatrix <- matrix(fenceLocation, ncol = 2, byrow = TRUE)

# Delete the fenced code blocks if they exist
if (length(fenceLocation) > 0) {
  for (j in 1:nrow(codeMatrix)) {
    val <- codeMatrix[j,1]:codeMatrix[j,2]
    rmdFile[val] <- ""
  }
}

# Find the level 1 header
headersOne <- grep("title:", rmdFile, fixed=TRUE, value=TRUE) # Get Title
headersOne <- sub("title:", "", headersOne) # Remove "title:" and make sure there aren't any others
headersOne <- str_trim(headersOne) # Remove any whitespace
headersOne <- gsub("\"", "", headersOne) # Remove escapes and quotes

toc <- paste("<li><a href=\"index.html\">",
             headersOne,
             "</a></li>\n",
             "<li>\n<ol>\n", 
             sep = ""
             )

# Create toc for each page (after index page) and then insert it into html.
for (i in 2:length(rmdFileNames)) {
  rmdFile <- readLines(rmdFileNames[i])
  
  # Find where fenced code blocks are and store their location
  # We cant have R comments (#) confused with markdown headers (#)
  fenceLocation <- which(str_sub(rmdFile, start = 1, end = 3) == "```")
  codeMatrix <- matrix(fenceLocation, ncol = 2, byrow = TRUE)
  
  # Delete the fenced code blocks if they exist
  if (length(fenceLocation) > 0) {
    for (j in 1:nrow(codeMatrix)) {
      val <- codeMatrix[j,1]:codeMatrix[j,2]
      rmdFile[val] <- ""
    }
  }

  # Find the level 1 and all level 2 headers
  headersOne <- grep("title:", rmdFile, fixed=TRUE, value=TRUE) # Get Title
  headersOne <- sub("title:", "", headersOne) # Remove "title:" and make sure there aren't any others
  headersOne <- str_trim(headersOne) # Remove any whitespace
  headersOne <- gsub("\"", "", headersOne) # Remove escapes and quotes
  
  headersTwo <- grep("^## {1}", rmdFile, value=TRUE) # Get Title
  headersTwo <- gsub("##", "", headersTwo) # Remove "##"
  headersTwo <- str_trim(headersTwo) # Remove any whitespace
  
  # Create level 1 html code for the page
  toc <- paste(toc,
               "<li><a title=\"",
               headersOne, 
               "\" ",
               "href=\"", 
               htmlFileNames[i], 
               "\">", 
               headersOne, 
               "</a>\n",
               "<ol>\n",
               sep = "")
  
  # Create level 2 html code for each pages second level header
  for (m in 1:length(headersTwo)) {
    # Regexp to match pandocs id element
    headersTwoSub <- mgsub(metaChar, idChar, headersTwo[m], fixed = TRUE) # substitute meta characters
    headersTwoSub <- gsub("-+", "-", headersTwoSub) # Remove any repeated hyphens
    headersTwoSub <- gsub("-$|^-", "", headersTwoSub) # Remove any begining or ending hyphens
    
    toc <- paste(toc,
                 "<li><a title=\"",
                 headersTwo[m], 
                 "\" ",
                 "href=\"",
                 htmlFileNames[i],
                 "#",
                 tolower(headersTwoSub),
                 "\">", 
                 headersTwo[m], 
                 "</a>",
                 "</li>\n",
                 sep = "")
  }
  
  toc <- paste(toc, "</ol>\n</li>\n", sep = "")
  
}

toc <- paste(toc, "</ol>\n</li>\n", sep = "")

# Insert toc into html file
for (i in 1:length(htmlFileNames)) {
  htmlFile <- readLines(paste("source/", htmlFileNames[i], sep=""))
  htmlFile <- sub("<!-- BEGIN toc -->", toc, htmlFile, fixed = TRUE)
  writeLines(htmlFile, paste("source/", htmlFileNames[i], sep=""))
}
