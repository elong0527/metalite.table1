interactive_table1 <- function(meta,
                               population,
                               parameter,
                               keep_missing = TRUE,
                               column_header = TRUE,
                               var_listing = NULL,
                               download = "none",
                               ...){

  download = match.arg(download, choices = c("none", "listing", "table", 'all'))

  par <- metalite::collect_adam_mapping(meta, parameter)$var

  if(all(is.na(meta$data_population[[par]]))){
    return(NULL)
  }

  tbl <- metalite::collect_n_subject(meta,
                                     population = population,
                                     parameter = parameter,
                                     listing = TRUE,
                                     histogram = TRUE,
                                     var_listing = var_listing)

  # Display details in reactable
  details_ggplot2 <- function(index){

    detail <- tbl$listing
    detail[[tbl$table$name[1]]] <- tbl$histogram

    name <- tbl$table[index, ][["name"]]

    x <- detail[[name]]

    if("data.frame" %in% class(x)){
      if(nrow(x) > 0){
        return(reactable2(x, download = download %in% c("listing", "all")))
      }
    }


    if("ggplot" %in% class(x)){
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
  space[1] <- ""

  name_display <- paste(space, name_display)
  name_width <- 220

  # update table
  tbl$table <- data.frame(name_display = name_display, tbl$table)

  if(! keep_missing){
    tbl$table <- tbl$table[- nrow(tbl$table), ]
  }

  if(column_header){
    col_def <- NULL
  }else{
    col_def <- reactable::colDef(name = "")
  }

  reactable2(tbl$table,
             sortable = FALSE,
             searchable = FALSE,
             filterable = FALSE,
             defaultPageSize = 50,
             wrap = TRUE,
             label = FALSE,
             columns = list(
               name_display = reactable::colDef(name = "", minWidth = name_width),
               name = reactable::colDef(show = FALSE)
             ),
             col_def = col_def,
             download = download %in% c("table", "all"),
             details = details_ggplot2)

}
