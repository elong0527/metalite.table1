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
