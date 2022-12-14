get_label <- function(data) {
  label <- vapply(data, function(x) {
    if (is.null(attr(x, "label"))) {
      return(NA_character_)
    } else {
      attr(x, "label")
    }
  }, FUN.VALUE = character(1))

  ifelse(is.na(label), names(data), label)
}

assign_label <- function(data,
                         var = names(data),
                         label = names(data)) {
  # input checking
  stopifnot(length(var) == length(label))
  stopifnot(!any(duplicated(var)))

  # check missing label
  name <- names(data)
  diff <- setdiff(name, var)

  if (length(diff) > 0) {
    message(
      "missing variables set label as itself\n",
      paste(diff, collapse = "\n")
    )

    var <- c(var, diff)
    label <- c(label, diff)
  }

  # assign label
  for (i in seq(name)) {
    attr(data[[i]], "label") <- label[names(data[i]) == var]
  }

  data
}
