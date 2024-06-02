
<!-- README.md is generated from README.Rmd. Please edit that file -->

# safejoin

<!-- badges: start -->

[![R build
status](https://github.com/SamEdwardes/safejoin/workflows/R-CMD-check/badge.svg)](https://github.com/SamEdwardes/safejoin/actions)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/safejoin)](https://cran.r-project.org/package=safejoin)

<!-- badges: end -->

## 🚧 Deprecation notice 🚧

As of `safejoin` version 0.2.0 the package has been deprecated. As of
version [`1.1.1`](https://dplyr.tidyverse.org/news/index.html#dplyr-111)
dplyr has a `relationship` argument that provides the same functionality
that `safejoin` was created for. See the dplyr docs
<https://dplyr.tidyverse.org/reference/mutate-joins.html> for complete
details.

Please use `dplyr::left_join()` with the `relationship` argument
instead.

## About

The goal of safejoin is to guarantee that when performing joins that
extra rows are not added to your data. safejoin is a wrapper around the
[`dplyr::left_join`](https://dplyr.tidyverse.org/reference/mutate-joins.html)
function.

- [Docs](https://safejoin-r.netlify.app/)
- [GitHub](https://github.com/SamEdwardes/safejoin/)
- [CRAN](https://CRAN.R-project.org/package=safejoin)

## Installation

You can install the released version of safejoin from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("safejoin")
```

Install development version from GitHub:

``` r
devtools::install_github("SamEdwardes/safejoin", ref = "dev")
```

## Example

Depending on your need safejoin can raise an error, a warning, or a
message. By default safejoin will raise an error.

**Error**:

``` r
library(safejoin)
x <- data.frame(key = c("a", "b"), value_x = c(1, 2))
y <- data.frame(key = c("a", "a"), value_y = c(1, 1))
safe_left_join(x, y, by = "key")
#> Warning: The `relationship` argument of `safe_left_join()` relationship-type as of
#> safejoin 0.2.0.
#> ℹ Please use `dplyr::left_join()` instead.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Error in safe_left_join(x, y, by = "key"): Input data x had 2 rows. After performing the join the data has 3 rows.
```

**Warning**:

``` r
safe_left_join(x, y, by = "key", action="warning")
#> Warning in safe_left_join(x, y, by = "key", action = "warning"): Input data x
#> had 2 rows. After performing the join the data has 3 rows.
#>   key value_x value_y
#> 1   a       1       1
#> 2   a       1       1
#> 3   b       2      NA
```

**Message**:

``` r
safe_left_join(x, y, by = "key", action="message")
#> Input data x had 2 rows. After performing the join the data has 3 rows.
#>   key value_x value_y
#> 1   a       1       1
#> 2   a       1       1
#> 3   b       2      NA
```

When a join is “safe” `safe_left_join` will have the exact same behavior
as
[`dplyr::left_join`](https://dplyr.tidyverse.org/reference/mutate-joins.html).

``` r
x <- data.frame(key = c("a", "b"), value_x = c(1, 2))
y <- data.frame(key = c("a", "b"), value_y = c(1, 1))
safe_left_join(x, y, by = "key")
#>   key value_x value_y
#> 1   a       1       1
#> 2   b       2       1
```

## Other useful packages

There are other packages that help solve similar problems. Most notably
<https://github.com/cynkra/dm> provides great features to treat data
frames like a data base.

## Reference and Attribution

safejoin is created and maintained by Sam Edwardes.
