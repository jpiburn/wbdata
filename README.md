
<!-- README.md is generated from README.Rmd. Please edit that file -->
wbdata
======

The goal of wbdata is to ... 

Installation
------------

You can install the released version (not yet) of wbdata from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("wbdata")
```

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
library(wbdata)

cn <- get_countries()

cn
#> # A tibble: 304 x 18
#>    iso3c iso2c country       capital_city  longitude latitude region_iso3c
#>  * <chr> <chr> <chr>         <chr>             <dbl>    <dbl> <chr>       
#>  1 ABW   AW    Aruba         Oranjestad       -70.0     12.5  LCN         
#>  2 AFG   AF    Afghanistan   Kabul             69.2     34.5  SAS         
#>  3 AFR   A9    Africa        <NA>              NA       NA    <NA>        
#>  4 AGO   AO    Angola        Luanda            13.2    - 8.81 SSF         
#>  5 ALB   AL    Albania       Tirane            19.8     41.3  ECS         
#>  6 AND   AD    Andorra       Andorra la V~      1.52    42.5  ECS         
#>  7 ANR   L5    Andean Region <NA>              NA       NA    <NA>        
#>  8 ARB   1A    Arab World    <NA>              NA       NA    <NA>        
#>  9 ARE   AE    United Arab ~ Abu Dhabi         54.4     24.5  MEA         
#> 10 ARG   AR    Argentina     Buenos Aires     -58.4    -34.6  LCN         
#> # ... with 294 more rows, and 11 more variables: region_iso2c <chr>,
#> #   region <chr>, admin_region_iso3c <chr>, admin_region_iso2c <chr>,
#> #   admin_region <chr>, income_level_iso3c <chr>,
#> #   income_level_iso2c <chr>, income_level <chr>,
#> #   lending_type_iso3c <chr>, lending_type_iso2c <chr>, lending_type <chr>
```
