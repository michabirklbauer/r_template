test_that("Simple Character creation works", {
  expect_equal(
    {
      jb <- Character$new("John Baldur")
      jb$name
    },
    "John Baldur"
  )
})
