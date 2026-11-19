# acrpk

<!-- badges: start -->
[![R-CMD-check](https://github.com/Achetto-pri/acrpk/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Achetto-pri/acrpk/actions/workflows/R-CMD-check.yaml)
<!-- [![codecov](https://codecov.io/gh/Achetto-pri/acrpk/branch/master/graph/badge.svg)](https://app.codecov.io/gh/Achetto-pri/acrpk) -->
<!-- badges: end -->

The goal of `acrpk` is to provide tools for spirometry (pulmonary function)
data analysis.

## Installation

You can install the development version of `acrpk` from
[GitHub](https://github.com/Achetto-pri/acrpk) with:

``` r
# install.packages("pak")
pak::pak("Achetto-pri/acrpk")
```

## Example

``` r
library(acrpk)

# 一秒率 = FEV1 / FVC
fev1_fvc_ratio(c(2.1, 3.0), c(3.2, 4.1))
#> [1] 0.6562500 0.7317073

# FVC 为 0 时返回 NA，而不是 Inf
fev1_fvc_ratio(1, 0)
#> [1] NA
```

## Documentation

- 函数手册：安装后 `?fev1_fvc_ratio`
- 指标说明与判读依据（Typst 源文件）：[`docs/ratio.typ`](docs/ratio.typ)，
  编译产物见 [`docs/ratio.pdf`](docs/ratio.pdf)

``` bash
typst compile docs/ratio.typ docs/ratio.pdf
```