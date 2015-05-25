################################################################################
# Prepare build directory.
################################################################################
# Copy over other site files.
file.copy(
  c("www/assets/", "www/robots.txt", "www/feed.xml", "www/.htaccess"), 
  "build/", 
  recursive = TRUE
)

# Fix file and directory permissions
dirsBuild <- list.dirs("build/.", full.names = TRUE, recursive = TRUE)
filesBuild <- list.files("build/.", all.files=TRUE, full.names = TRUE, recursive = TRUE)
Sys.chmod(dirsBuild, mode = "0755", use_umask = TRUE)
Sys.chmod(filesBuild, mode = "0644", use_umask = TRUE)