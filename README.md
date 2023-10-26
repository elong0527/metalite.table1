# metalite.table1

<!-- badges: start -->
[![R-CMD-check](https://github.com/elong0527/metalite.table1/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/elong0527/metalite.table1/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->
  
## Overview

A table for descriptive statistics is widely used 
in medical research and typically be the first table (i.e. `table1`) 
for a manuscript. 

There are R packages and examples to create the table1: 

- [`table1`](https://github.com/benjaminrich/table1)

For use case in clinical trials, 
[Chapter 4 of the R for clinical study reports and submission](https://r4csr.org/tlf-baseline.html) 
contains more details. 

The `metalite.table1` provide an interactive table1 to 
enhance the communication between statisticians and clinicians. 

Example: 

```
library(metalite.table1)
metalite_table1(~ AGE + SEX + RACE + BMIBLGR1 | ARM, data = r2rtf::r2rtf_adsl, id = "USUBJID")
```

![](https://raw.githubusercontent.com/elong0527/metalite.table1/main/vignettes/fig/table1.gif)

## Highlighted features

- Drill down into listings
- Embedded histogram


