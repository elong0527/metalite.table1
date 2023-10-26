# metalite.table1

## Overview

`metalite.table1` is an R package for interactive "table1". 

Example: 

```
library(metalite.table1)
metalite_table1(~ AGE + SEX + RACE + BMIBLGR1 | ARM, data = r2rtf::r2rtf_adsl, id = "USUBJID")
```

![](https://raw.githubusercontent.com/elong0527/metalite.table1/main/vignettes/fig/table1.gif)

## Highlighted features

- Drill down into listings
- Embedded histogram


