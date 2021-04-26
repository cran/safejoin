context("test-safe_left_join")

x <- dplyr::tribble(
  ~key, ~value_x,
  "a",  1,
  "b",  2,
  "c",  3,
  "c",  3,
  "d",  4
)

safe_y <- dplyr::tribble(
  ~key, ~value_y,
  "a",  1,
  "b",  2,
  "c",  3,
  "d",  4,
  "e",  9
)

dangerous_y <- dplyr::tribble(
  ~key, ~value_y,
  "a",  1,
  "a",  9,
  "b",  2,
  "c",  3,
  "d",  4
)

test_that("A safe join has the correct number of rows.", {
  expect_equal(nrow(safe_left_join(x, safe_y)), 5)
})

test_that("Error is thrown when rows are added to x.", {
  expect_error(safe_left_join(x, dangerous_y))
})

test_that("Message is thrown when rows are added to x.", {
  expect_message(safe_left_join(x, dangerous_y, action = "message"))
})

test_that("Warning is thrown when rows are added to x.", {
  expect_warning(safe_left_join(x, dangerous_y, action = "warning"))
})

test_that("A bad action parameter raises an error.", {
  expect_error(nrow(safe_left_join(x, safe_y, action = "BAD")))
})

test_that("A bad relationship parameter raises an error.", {
  expect_error(nrow(safe_left_join(x, safe_y, relationship = "BAD")))
})
