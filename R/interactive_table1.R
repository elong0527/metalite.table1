interactive_table1 <- function(meta,
                               population,
                               observation = NULL,
                               parameter,
                               keep_total = TRUE,
                               keep_missing = TRUE,
                               total = TRUE,
                               column_header = TRUE,
                               show_listing = TRUE,
                               var_listing = NULL,
                               download = "none",
                               type = NULL,
                               defaultPageSize = 50,
                               name_width = 220,
                               max_row = 50000,
                               ...) {
  download <- match.arg(download, choices = c("none", "listing", "table", "all"))

  if (is.null(type)) {
    type <- ifelse(any(duplicated(
      meta$data_observation[[meta$population[[1]]$id]]
    )), "Records", "Subjects")
  }

  par <- metalite::collect_adam_mapping(meta, parameter)$var

  if (all(is.na(meta$data_population[[par]]))) {
    return(NULL)
  }

  listing <- nrow(meta$data_population) <= max_row
  if (!listing) {
    message("Drill-down listing is not provided because there are more than ", max_row, " rows in the datasets")
  }
  listing <- show_listing & listing

  tbl <- metalite::collect_n_subject(meta,
    population = population,
    parameter = parameter,
    listing = listing,
    histogram = TRUE,
    type = type,
    var_listing = var_listing,
    display_total = total
  )

  if(! is.null(tbl$listing)){
    names(tbl$listing)[is.na(names(tbl$listing))] <- "Missing"
  }

  # Display details in reactable
  details_ggplot2 <- function(index) {
    detail <- tbl$listing
    detail[[tbl$table$name[1 + keep_total]]] <- tbl$histogram

    name <- tbl$table[index, ][["name"]]

    x <- detail[[name]]

    if ("data.frame" %in% class(x)) {
      if (nrow(x) > 0) {
        return(reactable2(x, download = download %in% c("listing", "all")))
      }
    }


    if ("ggplot" %in% class(x)) {
      return(htmltools::plotTag(x, alt = "plots", width = 600))
    }

    NULL
  }

  # Handle special character and title case
  name_display <- tbl$table$name
  name_display <- gsub("<=", "\U2264", name_display)
  name_display <- gsub(">=", "\U2265", name_display)

  # Add spaces for sub-category
  space <- rep("\U2000\U2000", length(name_display))
  space[1:2] <- ""

  name_display <- paste(space, name_display)

  # update table
  tbl$table <- cbind(name_display = name_display, tbl$table)

  if (!keep_missing) {
    tbl$table <- tbl$table[-nrow(tbl$table), ]
  }

  if (column_header) {
    col_def <- NULL
  } else {
    col_def <- reactable::colDef(name = "")
  }

  if (!keep_total) {
    tbl$table <- tbl$table[-1, ]
  }

  reactable2(tbl$table,
    sortable = FALSE,
    searchable = FALSE,
    filterable = FALSE,
    defaultPageSize = defaultPageSize,
    showPageSizeOptions = nrow(tbl$table) > defaultPageSize,
    wrap = TRUE,
    label = FALSE,
    columns = list(
      name_display = reactable::colDef(name = "", minWidth = name_width),
      name = reactable::colDef(show = FALSE)
    ),
    col_def = col_def,
    download = download %in% c("table", "all"),
    details = details_ggplot2,
    ...
  )
}
