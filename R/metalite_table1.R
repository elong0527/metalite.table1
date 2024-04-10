#' Interactive Table of Descriptive Statistics in HTML
#'
#' @param formula an object of class "formula".
#' @param data a data frame that contain variables described in the `formula`.
#' @param id a character value to indicate subject/record id variable name in `data`.
#' @param var_listing a character vector of additional variables included in the drill down listing.
#' @param total a logical value to display or hide "Total" column.
#' @param header a logical vector with length 1 or same length of the variables in `formula` to show the `Number of xxx` row of each variable.
#' Default is to show the row for the first variable.
#' @param download a character value to enable download button. Allowed values include
#' "none", "listing", "table", and 'all'.
#' @param record_name a character value to control section title (e.g. "Subjects", "Records").
#' @param ... additional arguments passed to `reactable`. More details refer \url{https://glin.github.io/reactable/reference/reactable.html}
#'
#' @return a `shiny.tag.list` object that contain a `reactable` HTML widget for
#' interactive table of describptive statistics.
#'
#' @examples
#' if (interactive()) {
#'   metalite_table1(~ AGE + SEX | TRT01A, data = r2rtf::r2rtf_adsl, id = "SUBJID")
#' }
#'
#' @export
metalite_table1 <- function(formula,
                            data,
                            id = NULL,
                            var_listing = NULL,
                            total = TRUE,
                            header = NULL,
                            download = "none",
                            record_name = NULL,
                            ...) {
  if (nrow(data) == 0) {
    stop("There is no records in the input dataset")
  }

  if(is.null(id)){
    data$.id <- 1:nrow(data)
    id = ".id"
    show_listing <- FALSE
  }else{
    show_listing <- TRUE
  }

  if (formula[[2]][[1]] == "|") {
    var <- all.vars(formula[[2]][[2]])
    group <- all.vars(formula[[2]][[3]])
    if(length(group) > 1){
      stop("Only one group variable is supported")
    }
  } else {
    var <- all.vars(formula[[2]])
    data$group <- "All"
    attr(data, "group") <- "All"
    group <- "group"
  }

  if(! length(header) %in% c(0, 1, length(var))){
    stop("The length of `header` should be either 1 or the same number of variables")
  }

  data[[group]] <- factor(data[[group]])

  var_label <- metalite::get_label(data)[var]

  plan <- metalite::plan(
    analysis = "metalite.table1:::interactive_table1",
    population = "all",
    observation = "inf",
    total = total,
    parameter = var,
    ...
  )

  if(is.null(header)){
    plan$column_header <- FALSE
    plan$column_header[1] <- TRUE
  }else{
    plan$column_header <- header
  }

  plan$keep_total <- plan$column_header

  meta <- metalite::meta_adam(observation = data)

  meta <- metalite::define_plan(meta, plan = plan)

  meta <- metalite::define_population(meta,
    id = id,
    name = "all",
    group = group,
    subset = NULL,
    label = "All Subjects",
    var = var
  )

  meta <- metalite::define_observation(meta,
    id = id,
    name = "inf",
    subset = NULL,
    label = "All observations"
  )

  for (i in seq(var)) {
    meta <- metalite::define_parameter(meta,
      name = var[i],
      var = var[i],
      label = var_label[i],
      subset = NULL
    )
  }

  meta <- metalite::define_analysis(meta,
    name = "metalite.table1:::interactive_table1",
    label = "Interactive Table 1"
  )

  meta <- metalite::meta_build(meta)

  htmltools::browsable(
    htmltools::tagList(metalite::meta_run(
      meta,
      show_listing = show_listing,
      var_listing = var_listing,
      download = download,
      type = record_name
    ))
  )
}

#' Convert to html
#'
#' @param x an output from `metalite_table1`.
#'
#' @return HTML string of `reactable` HTML widget for
#' interactive table of describptive statistics.
#'
#' @export
metalite_table1_to_html <- function(x) {
  attributes(x)$browsable_html <- NULL
  print(x)
}
