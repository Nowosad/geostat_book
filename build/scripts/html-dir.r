################################################################################
# Prepare build directory.
################################################################################
# Copy over other site files.
file.copy(
  c(
    "build/html/assets/", 
    "build/html/robots.txt", 
    "build/html/.htaccess"
  ), 
  "html/", 
  recursive = TRUE
)

# Fix file and directory permissions
dirsBuild <- list.dirs("html/.", full.names = TRUE, recursive = TRUE)
filesBuild <- list.files("html/.", all.files=TRUE, full.names = TRUE, recursive = TRUE)
Sys.chmod(dirsBuild, mode = "0755", use_umask = TRUE)
Sys.chmod(filesBuild, mode = "0644", use_umask = TRUE)
