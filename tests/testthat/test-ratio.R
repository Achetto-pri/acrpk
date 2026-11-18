test_that("fev1_fvc_ratio() 返回比值，除零与缺失均为 NA", {
  expect_equal(fev1_fvc_ratio(c(2.1, 3.0), c(3.2, 4.1)), c(2.1 / 3.2, 3.0 / 4.1))
  expect_true(is.na(fev1_fvc_ratio(1, 0)))
  expect_true(is.na(fev1_fvc_ratio(NA_real_, 1)))
})
