################################################################################
# Creates and inserts the html page navigation.
################################################################################
# Define first page navigation html
navFirst <- "<a class=\"navigation navigation-next navigation-unique\" href=\"<!-- BEGIN href -->\"><i class=\"fa fa-angle-right\"></i></a>"

#===============================================================================
# Page navigation for the first page
#===============================================================================
# Replace placeholder text in navFirst
navFirst <- sub("<!-- BEGIN href -->", htmlFileNames[2], navFirst, fixed = TRUE)

# Insert page navigation into html file
htmlFile <- readLines(paste("build/", htmlFileNames[1], sep=""))
htmlFile <- sub("<!-- BEGIN page-nav -->", navFirst, htmlFile, fixed = TRUE)
writeLines(htmlFile, paste("build/", htmlFileNames[1], sep=""))

#===============================================================================
# Page navigation for the middle pages
#===============================================================================
if (length(htmlFileNames) > 2) {
  for (i in 2:(length(htmlFileNames)-1)) {
    # Define middle page navigation html
    navMiddle <- "<a class=\"navigation navigation-prev\" href=\"<!-- BEGIN href-prev -->\"><i class=\"fa fa-angle-left\"></i></a>\n<a class=\"navigation navigation-next\" href=\"<!-- BEGIN href-next -->\"><i class=\"fa fa-angle-right\"></i></a>"
    
    # Replace placeholder text in navMiddle
    navMiddle <- sub("<!-- BEGIN href-prev -->", htmlFileNames[i-1], navMiddle, fixed = TRUE)
    navMiddle <- sub("<!-- BEGIN href-next -->", htmlFileNames[i+1], navMiddle, fixed = TRUE)
    
    # Insert page navigation into html file
    htmlFile <- readLines(paste("build/", htmlFileNames[i], sep=""))
    htmlFile <- sub("<!-- BEGIN page-nav -->", navMiddle, htmlFile, fixed = TRUE)
    writeLines(htmlFile, paste("build/", htmlFileNames[i], sep=""))
  }
}

#===============================================================================
# Page navigation for the last page
#===============================================================================
# Define last page navigation html
navLast <- "<a class=\"navigation navigation-prev navigation-unique\" href=\"<!-- BEGIN href -->\"><i class=\"fa fa-angle-left\"></i></a>"

# Replace placeholder text in navLast
navLast <- sub("<!-- BEGIN href -->", htmlFileNames[length(htmlFileNames)-1], navLast, fixed = TRUE)

# Insert page navigation into html file
htmlFile <- readLines(paste("build/", htmlFileNames[length(htmlFileNames)], sep=""))
htmlFile <- sub("<!-- BEGIN page-nav -->", navLast, htmlFile, fixed = TRUE)
writeLines(htmlFile, paste("build/", htmlFileNames[length(htmlFileNames)], sep=""))
