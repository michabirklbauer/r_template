#!/usr/bin/env Rscript

# Learn more about testing with testthat here:
# https://testthat.r-lib.org/reference/index.html

test_that("Simple Character creation works", {
  expect_match(
    {
      jb <- Character$new(name = "John Baldur")
      jb$name
    },
    "John Baldur",
    fixed = TRUE
  )
})

test_that("Simple Character attack works", {
  expect_equal(
    {
      jb <- Character$new(name = "John Baldur")
      jb$attack()
    },
    0.0
  )
})

test_that("Character factory works", {
  expect_match(
    {
      characters <- character_factory("../../data/characters.csv")
      characters[[1]]$name
    },
    "Astarion",
    fixed = TRUE
  )
})

test_that("Battle works", {
  expect_match(
    {
      utils::capture.output({
        characters <- character_factory("../../data/characters.csv")
        winner <- battle(characters[[1]], characters[[2]], health = 10000)
      })
      winner$name
    },
    "Shadowheart",
    fixed = TRUE
  )
})

test_that("Running script works", {
  expect_equal(
    {
      utils::capture.output({
        exit_status <- main(c("-f", "../../data/characters.csv"))
      })
      exit_status
    },
    0
  )
})
