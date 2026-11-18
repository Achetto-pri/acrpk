#' FEV1/FVC ratio
#'
#' 一秒用力呼气容积与用力肺活量之比，低于 0.70 通常提示阻塞性通气功能障碍。
#'
#' @param fev1 numeric. 一秒用力呼气容积（L）。
#' @param fvc numeric. 用力肺活量（L）。
#'
#' @return numeric. 与 `fev1` 等长的比值；`fvc` 为 0 或缺失时为 `NA`。
#'
#' @examples
#' fev1_fvc_ratio(c(2.1, 3.0), c(3.2, 4.1))
#'
#' @export
fev1_fvc_ratio <- function(fev1, fvc) {
  ratio <- fev1 / fvc
  ratio[!is.finite(ratio)] <- NA_real_
  ratio
}
