reactable2 <- function(data,
                       resizable = TRUE,
                       filterable = TRUE,
                       searchable = TRUE,
                       defaultPageSize = 10,
                       showPageSizeOptions = TRUE,
                       borderless = TRUE,
                       striped = TRUE,
                       highlight = TRUE,
                       fullWidth = TRUE,
                       width = "auto",
                       theme = reactable::reactableTheme(cellPadding = "0px 8px"),
                       label = TRUE,
                       wrap = FALSE,
                       download = FALSE,
                       col_def = NULL,
                       ...) {
  # Display variable label as hover text
  if (label & is.null(col_def)) {
    label <- metalite::get_label(data)

    col_header <- function(value, name) {
      htmltools::div(title = as.character(label[value]), value)
    }

    col_def <- reactable::colDef(header = col_header)
  }

  element_id <- basename(tempfile())

  tbl <- reactable::reactable(
    data = data,
    resizable = resizable,
    filterable = filterable,
    searchable = searchable,
    defaultPageSize = defaultPageSize,
    defaultColDef = col_def,
    showPageSizeOptions = showPageSizeOptions,
    borderless = borderless,
    striped = striped,
    highlight = highlight,
    fullWidth = fullWidth,
    width = width,
    theme = theme,
    wrap = wrap,
    elementId = element_id,
    ...
  )

  if (download) {
    on_click <- paste0("Reactable.downloadDataCSV('", element_id, "')")

    htmltools::browsable(
      htmltools::tagList(
        htmltools::tags$button("Download as CSV", onclick = on_click),
        tbl
      )
    )
  } else {
    tbl
  }
}

#' Convert reactable to a data frame
#'
#' @param x  A `reactable` HTML widget
#'
#' @return A data frame
#'
reactable_to_df <- function(x){

  # table data
  tbl1 <- do.call(cbind, jsonlite::fromJSON(x$x$tag$attribs$data))

  # table columns
  columns <- x$x$tag$attribs$columns
  tbl2 <- list()
  for(i in seq_along(columns)){
    if(! columns[[i]]$id %in% ".details"){
      if(is.null(columns[[i]]$show)){
        tbl2[[i]] <- unlist(columns[[i]][c("id", "name")])
      }
    }
  }
  tbl2 <- data.frame(do.call(rbind, tbl2))

  # output
  tbl <- data.frame(tbl1[, tbl2[["id"]]])

  tbl[, 1] <- gsub("\U2000", " ", tbl[, 1])
  attr(tbl, "column_header") <- paste(tbl2$name, collapse = "|")

  tbl
}
