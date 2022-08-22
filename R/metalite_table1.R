metalite_table1 <- function(formula, data, id){

  if(formula[[2]][[1]] == "|"){
    var = all.vars(formula[[2]][[2]])
    group = all.vars(formula[[2]][[3]])
  }else{
    var = all.vars(formula[[2]])
    data$group = "All"
    attr(data, "group") <- "All"
    group = "group"
  }

  data[[group]] <- factor(data[[group]])

  var_label <- vapply(data, function(x){
                        if(is.null(attr(x, "label"))){
                          return(NA_character_)
                        }else{
                          attr(x, "label")
                        }},
                      FUN.VALUE = character(1))
  var_label <- ifelse(is.na(var_label), names(data), var_label)[var]
  names(var_label) <- NULL

  plan <- metalite::plan(analysis = "interactive_table1",
                         population = "all",
                         observation = "inf",
                         parameter = var)
  plan$column_header = FALSE
  plan$column_header[1] = TRUE


  meta <- metalite::meta_adam(observation = data)

  meta <- metalite::define_plan(meta, plan = plan)

  meta <- metalite::define_population(meta,
                                      id = id,
                                      name = "all",
                                      group = group,
                                      subset = NULL,
                                      label = "All Subjects",
                                      var = var)

  meta <- metalite::define_observation(meta,
                                       id = id,
                                       name = "inf",
                                       subset = NULL,
                                       label = "All observations")

  for(i in seq(var)){
    meta <- metalite::define_parameter(meta,
                                       name = var[i],
                                       var = var[i],
                                       label = var_label[i],
                                       subset = NULL)
  }

  meta <- metalite::define_analysis(meta, name = "interactive_table1", label = "Interactive Table 1")

  meta <- metalite::meta_build(meta)


  meta
}
