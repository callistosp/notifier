
notify_windows <- function(msg, title, image) {

  ## toaster is nicer, but only works from windows 8
  if (windows_version() < "6.2.9200") {
    notify_notifu(msg, title, image)

  } else {
    notify_toaster(msg, title, image)
  }
}

notify_notifu <- function(msg, title, image) {

  notifu <- system.file(package = packageName(), "notifu", "notifu.exe")

  if (!file.exists(notifu)) {
    stop("Cannot find notifu.exe executable, ", sQuote("notifier"),
         " installation is broken", call. = FALSE)
  }

  if (is.null(image)) {
    image <- normalizePath(system.file(package = packageName(), "R.ico"))
  }

  args <- c(
    "/m", shQuote(msg),
    "/p", shQuote(title),
    "/i", shQuote(image)
  )

  system2(notifu, args, wait = FALSE)

  invisible()
}

notify_toaster <- function(msg, title, image) {

  toaster <- system.file(package = packageName(), "toaster", "toast.exe")

  if (!file.exists(toaster)) {
    stop("Cannot find toast.exe executable, ", sQuote("notifier"),
         " installation is broken", call. = FALSE)
  }

  if (is.null(image)) {
    image <- normalizePath(system.file(package = packageName(), "R.png"))
  }

  args <- c(
    "-m", shQuote(msg),
    "-t", shQuote(title),
    "-p", shQuote(image)
  )

  system2(toaster, args)

  invisible()
}
