
is_absolute_path <- function(path) {
  substr(path, 0, 1) %in% c("~", .Platform$file.sep)
}

maybe_concat_paths <- function(base_path, path) {
  if (is_absolute_path(path)) {
    path
  } else {
    file.path(base_path, path)
  }
}

read_file <- function(file) {
  readChar(file, file.info(file)$size)
}

write_file <- function(x, file) {
  writeChar(x, file)
}

capitalise <- function(x) {
  map_chr(x, function(string) {
    paste0(
      toupper(substring(string, 1, 1)),
      substring(string, 2)
    )
  })
}

# TODO: could devtools export *_dcf() functions or equivalent?
update_dependency <- function(dep, path) {
  desc_path <- file.path(path, "DESCRIPTION")
  desc <- devtools:::read_dcf(desc_path)

  field <- paste0(dep, "Note")
  desc[[field]] <- as.character(utils::packageVersion(dep))

  devtools:::write_dcf(desc_path, desc)
}