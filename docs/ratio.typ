#set document(title: "acrpk 函数文档 — fev1_fvc_ratio")
#set page(margin: (x: 2.2cm, y: 1.8cm), numbering: "1")
#set heading(numbering: "1.")
#set text(size: 10pt)
#set par(justify: true, leading: 0.62em)
#show heading.where(level: 1): set block(above: 1.05em, below: 0.5em)

#show raw.where(block: false): set text(fill: rgb("#7a2f2f"))
#show raw.where(block: true): it => block(
  width: 100%,
  inset: 8pt,
  radius: 3pt,
  fill: luma(246),
  stroke: 0.4pt + luma(220),
)[
  #set text(fill: rgb("#333333"))
  #it
]

#align(center)[
  #text(size: 15pt, weight: "bold")[`fev1_fvc_ratio()`]
  #v(0.3em)
  #text(size: 10pt, fill: luma(110))[acrpk — 肺功能数据工具集]
]

#v(0.8em)

= 用途

计算一秒用力呼气容积（FEV1）与用力肺活量（FVC）之比，即临床上的一秒率。
该指标用于判定阻塞性通气功能障碍：比值下降说明气道排气受限，而肺总量正常或
增高，是哮喘、慢阻肺等疾病的常用判读依据。

= 函数签名

```r
fev1_fvc_ratio(fev1, fvc)
```

#table(
  columns: (auto, 1fr),
  inset: 5pt,
  stroke: (bottom: 0.5pt + luma(200)),
  [*参数*], [*说明*],
  [`fev1`], [一秒用力呼气容积（L）。数值向量。],
  [`fvc`], [用力肺活量（L）。数值向量，长度应与 `fev1` 相同。],
  [*返回*], [与 `fev1` 等长的数值向量；`fvc` 为 0 或缺失时该位置为 `NA`。],
)

两个参数按 R 的常规向量运算逐元素相除，因此可以直接作用在整列数据上。

= 计算方式

$ "ratio"_i = frac("FEV1"_i, "FVC"_i) $

代码只有两行：先做除法，再把非有限值统一置为缺失。

```r
ratio <- fev1 / fvc
ratio[!is.finite(ratio)] <- NA_real_
```

第二步是必要的：R 中 `1 / 0` 得到 `Inf` 而不是 `NA`，而肺功能数据里 FVC 为 0
通常意味着该次测试无效，返回 `Inf` 会污染后续的均值与回归。

= 判读参考

#table(
  columns: (auto, auto, 1fr),
  inset: 5pt,
  stroke: (bottom: 0.5pt + luma(200)),
  [*比值*], [*含义*], [*说明*],
  [`>= 0.70`], [正常], [阻塞性通气功能障碍的可能性低。],
  [`< 0.70`], [阻塞], [需结合 FEV1 占预计值百分比分级；老年人群阈值另有争议。],
  [`NA`], [无效], [FVC 为 0 或原始数据缺失，应回查肺功能仪导出记录。],
)

= 示例

```r
fev1_fvc_ratio(c(2.1, 3.0), c(3.2, 4.1))
#> [1] 0.6562500 0.7317073
```

第一条记录比值低于 0.70，提示阻塞；第二条在正常范围内。

边界情况：

```r
fev1_fvc_ratio(1, 0)      # 除零 -> NA，而非 Inf
fev1_fvc_ratio(NA, 1)     # 缺失值原样传播
```

= 依赖与测试

函数只用 base R，无额外依赖。对应的单元测试位于
`tests/testthat/test-ratio.R`，覆盖数值正确性、除零、缺失值与返回长度四类情形。
