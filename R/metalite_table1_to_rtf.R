#' Convert `metalite_table1` to an RTF file
#'
#' @param x Output of `metalite_table1`.
#' @inheritParams r2rtf::write_rtf
#' @inheritParams r2rtf::rtf_title
#' @inheritParams r2rtf::rtf_body
#'
#' @return a string of the RTF file path
#'
#' @export
metalite_table1_to_rtf <- function(
    x,
    file,
    title = "Baseline Characteristics",
    col_rel_width = NULL){

  # prepare input
  tbl <- lapply(tbl[[1]], reactable_to_df)

  colheader <- attr(tbl[[1]], "column_header")
  tbl <- do.call(rbind, tbl)
  rownames(tbl) <- NULL

  n_col <- ncol(tbl)

  if(is.null(col_rel_width)){
    col_rel_width = c(5, rep(2, n_col - 1))
  }

  # output RTF
  tbl |>
    r2rtf::rtf_title(title) |>
    r2rtf::rtf_colheader(colheader,
                         col_rel_width = col_rel_width
    ) |>
    r2rtf::rtf_body(
      col_rel_width = col_rel_width,
      text_justification = c("l", rep("c", n_col - 1)),
      text_indent_first = -240,
      text_indent_left = 180
    ) |>
    r2rtf::rtf_encode() |>
    r2rtf::write_rtf(file)

  return(file)
}

