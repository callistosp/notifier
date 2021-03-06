
windows_version <- (function() {

  version <- NULL

  function() {
    if (!is.null(version)) return(version)
    
    ver <- tryCatch(
      system("cmd /c ver", intern = TRUE, ignore.stderr = TRUE),
      error = function(e) NA_character_
    )
    
    if (identical(ver, NA_character_)) {
      version <<- ver
      return(ver)
    }
    
    ver <- paste(ver, collapse = "")  
    ver <- sub("^.*Version[ ]+([0-9\\.]+).*$", "\\1", ver,
               perl = TRUE, ignore.case = TRUE)
    ver <- package_version(ver)

    version <<- ver
    version
  }
})()
