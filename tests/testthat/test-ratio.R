test_that("fev1_fvc_ratio() 逐元素计算比值", {
  expect_equal(fev1_fvc_ratio(c(2.1, 3.0), c(3.2, 4.1)), c(2.1 / 3.2, 3.0 / 4.1))
})

test_that("fev1_fvc_ratio() 把非有限值转成 NA", {
  expect_true(is.na(fev1_fvc_ratio(1, 0)))        # Inf
  expect_true(is.na(fev1_fvc_ratio(0, 0)))        # NaN
  expect_true(is.na(fev1_fvc_ratio(NA_real_, 1))) # 缺失
})

test_that("fev1_fvc_ratio() 保持长度与类型", {
  ratio <- fev1_fvc_ratio(c(1, 2, 3), c(2, 2, 2))
  expect_length(ratio, 3)
  expect_type(ratio, "double")
})
