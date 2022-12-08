#' Interactive table1
#'
#' @param formula a formula
#' @param data a data frame
#' @param id a variable name
#' @param var_listing a character vector of additional variables included in the listing.
#' @param download a character to enable download button. Allowed value include
#' @param type a character value to control section title (e.g. "Subjects", "Records")
#' "none", "listing", "table", and 'all'.
#'
#' @export
metalite_table1 <- function(formula,
                            data,
                            id,
                            var_listing = NULL,
                            download = "none",
                            type = NULL) {
  if (formula[[2]][[1]] == "|") {
    var <- all.vars(formula[[2]][[2]])
    group <- all.vars(formula[[2]][[3]])
  } else {
    var <- all.vars(formula[[2]])
    data$group <- "All"
    attr(data, "group") <- "All"
    group <- "group"
  }

  data[[group]] <- factor(data[[group]])

  var_label <- get_label(data)[var]

  plan <- metalite::plan(
    analysis = "metalite.table1:::interactive_table1",
    population = "all",
    observation = "inf",
    parameter = var
  )

  plan$column_header <- FALSE
  plan$column_header[1] <- TRUE

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
      var_listing = var_listing,
      download = download,
      type = type))
  )
}
