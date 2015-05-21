################################################################################
# Create self-contained build folder and cleanup files
################################################################################

# Delete old build folder
unlink("build", recursive = TRUE)

# Create build folder only if needed
if (file.exists("source/index.html")) {
  
  # Create new build folder
  dir.create("build") 
  
  # Copy site assets to build folder.
  file.copy("source/assets/", "build/", recursive = TRUE)
  
  # Copy relevant files from source to build folder.
  # Make sure they exist or source will be copied over.
  relevantFileNames <- dir("source/", pattern = "\\.html$|feed.xml$|robots.txt$")
  if (length(relevantFileNames) > 0){
    relevantFileNames <- paste("source/", relevantFileNames, sep="")
    file.copy(relevantFileNames, "build/", recursive = TRUE)
  }
  
  # Copy all rendered html folders from source to build folder.
  # Make sure they exist or source will be copied over.
  htmlFolderNames <- dir("source/", pattern = "\\_files$")
  if (length(htmlFolderNames) > 0){
    htmlFolderNames <- paste("source/", htmlFolderNames, sep="")
    file.copy(htmlFolderNames, "build/", recursive = TRUE)
  }
  
  # Delete only rendered html files and folders from source.
  # Make sure folders exist or source will be deleted!
  unlink(paste("source/", htmlFileNames, sep=""), recursive = TRUE)
  if (length(htmlFolderNames) > 0){
    unlink(htmlFolderNames, recursive = TRUE)
  } 
}
