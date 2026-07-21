#!/usr/bin/env Rscript

# This file is part of the standard setup for testthat.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

library(testthat)

source("lib/main.R")

test_results <- testthat::test_dir(
  "tests/testthat",
  stop_on_failure = TRUE,
  stop_on_warning = TRUE
)

status <- as.data.frame(test_results)
failed <- sum(status$failed)
errors <- any(status$error)
warnings <- sum(status$warning)

success <- all(c(failed == 0, !errors, warnings == 0))
exit_code <- if (success) 0 else 1

stopifnot(success)
q(status = exit_code)
