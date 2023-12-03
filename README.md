# metalite.table1

<!-- badges: start -->
[![CRAN
status](https://www.r-pkg.org/badges/version/metalite.table1)](https://CRAN.R-project.org/package=metalite.table1)
[![CRAN
Downloads](https://cranlogs.r-pkg.org/badges/metalite.table1)](https://cran.r-project.org/package=metalite.table1)
[![R-CMD-check](https://github.com/elong0527/metalite.table1/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/elong0527/metalite.table1/actions/workflows/R-CMD-check.yaml)
[![status](https://tinyverse.netlify.com/badge/metalite.table1)](https://tinyverse.netlify.app/)
<!-- badges: end -->
  
## Overview

A table for descriptive statistics is widely used 
in medical research and typically be the first table (i.e. `table1`) 
for a manuscript. 

The `metalite.table1` provide an interactive table1 to 
enhance the communication between statisticians and clinicians. 

For use case in clinical trials, 
[Chapter 4 of the R for clinical study reports and submission](https://r4csr.org/tlf-baseline.html) 
contains more details. 

There are other R packages to create the table1: 

- [`table1`](https://github.com/benjaminrich/table1)

Example: 

```
library(metalite.table1)
metalite_table1(~ AGE + SEX + RACE + BMIBLGR1 | ARM, data = r2rtf::r2rtf_adsl, id = "USUBJID")
```

![](https://raw.githubusercontent.com/elong0527/metalite.table1/main/vignettes/fig/table1.gif)

## Installation

You can install the package via CRAN:

``` r
install.packages("metalite.table1")
```

Or, install from GitHub:

``` r
remotes::install_github("elong0527/metalite.table1")
```

## Highlighted features

- Drill down listings
- Embedded histogram


