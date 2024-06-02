#' Validate extra rows are added not added to the left hand side
#'
#' @export
#' 
#' @description 
#' `r lifecycle::badge('deprecated')`
#' Perform a "safe" left join where it is guaranteed that no additional rows are
#' added to the left hand side table. For more information on left joins see 
#' (\code{\link[dplyr:left_join]{dplyr::left_join}}).
#'
#' @inheritDotParams dplyr::left_join
#' @param action What should happen when the number of rows changes from a join?
#'   Options include: 'error', 'warning', or 'message'. By default 'error'.
#' @param relationship What is the expected relationship between `x` and `y`?
#'   At this time the only available option is '*:1', indicating a many to one
#'   relationship between `x` and `y`. In the future more options may be added.
#'
#' @return
#' An object of the same type as `x`. The order of the rows and columns of `x`
#' is preserved as much as possible. The output has the following properties:
#'
#' @examples
#' # The relationship between `x` and `y` is '*:1'. No extra rows will be added
#' # to the left hand side.
#' x <- data.frame(key = c("a", "a", "b"), value_x = c(1, 4, 2))
#' y <- data.frame(key = c("a", "b"), value_y = c(1, 1))
#' safe_left_join(x, y)
#'
#' # The relationship between `x` and `y` is '1:*'. An error should be raised
#' # because additional rows will be added to the left hand side.
#' \dontrun{x <- data.frame(key = c("a", "b"), value_x = c(1, 2))
#' y <- data.frame(key = c("a", "a"), value_y = c(1, 1))
#' safe_left_join(x, y)}
#'
#' # Alternatively instead of raising an error a warning or message can be
#' # outputted.
#' x <- data.frame(key = c("a", "b"), value_x = c(1, 2))
#' y <- data.frame(key = c("a", "a"), value_y = c(1, 1))
#' safe_left_join(x, y, action = "warning")
#' safe_left_join(x, y, action = "message")
safe_left_join <- function(..., action = "error", relationship = "*:1") {
  # Warn user about deprecation
  lifecycle::deprecate_warn("0.2.0", "safe_left_join(relationship = 'relationship-type')", "dplyr::left_join()")

  # Validate parameters
  action_options <- c("error", "warning", "message")

  if (!(action %in% action_options)) {
    stop(glue::glue(
      "`action` must be one of: ",
      "{glue::glue_collapse(action_options, ', ')}"
    ))
  }

  relationship_options <- c("*:1")
  relationship_future_options <- c("*:1", "1:*", "1:1", "*:*")

  if (!(relationship %in% relationship_options)) {
    stop(glue::glue(
      "`action` must be one of: ",
      "{glue::glue_collapse(relationship_options, ', ')}"
    ))
  }

  # Parse parameters
  params <- list(...)
  if (is.null(params$x)) {
    x <- params[[1]]
  } else {
    x <- params$x
  }

  # Perform the join
  data <- dplyr::left_join(...)

  # Create the message to display
  msg <- glue::glue(
    "Input data x had {nrow(x)} rows. ",
    "After performing the join the data has {nrow(data)} rows."
  )

  # Test if the selected relationship has been respected and raise the
  # appropriate error, warning, or message
  if (nrow(x) != nrow(data)) {
    if (action == "message") {
      message(msg)
    } else if (action == "warning") {
      warning(msg)
    } else {
      stop(msg)
    }
  }

    {
    }

  data
}
