#!/usr/bin/env Rscript

renv::restore(prompt = FALSE)

version <- "1.0.0"
date <- "2026-07-20"

library(checkmate)
library(optparse)
library(glue)

source("lib/battle.R")

main <- function(cli_args = NULL) {
  parser <- optparse::OptionParser(
    usage = "usage: %prog [-h] -f FILE [-a CHARACTER_1] [-b CHARACTER_2] [-p HEALTH] [--version]",
    prog = "main.R",
    description = "Battles two characters.",
    epilogue = glue("v{version} (c) Micha Birklbauer, 2026")
  ) |>
    optparse::add_option(
      c("-f", "--file"),
      action = "store",
      type = "character",
      dest = "file",
      metavar = "FILE",
      help = "Character file to read characters from (str)",
      required = TRUE
    ) |>
    optparse::add_option(
      c("-a", "--character-1"),
      action = "store",
      type = "integer",
      dest = "c1",
      metavar = "CHARACTER_1",
      default = 1,
      help = "Index of the first character to use (int) [default %default]"
    ) |>
    optparse::add_option(
      c("-b", "--character-2"),
      action = "store",
      type = "integer",
      dest = "c2",
      metavar = "CHARACTER_2",
      default = 2,
      help = "Index of the second character to use (int) [default %default]"
    ) |>
    optparse::add_option(
      c("-p", "--hit-points"),
      action = "store",
      type = "integer",
      dest = "health",
      metavar = "HEALTH",
      default = 130,
      help = "Health of all characters (int) [default %default]"
    )
  is_script <- is.null(cli_args)
  if (is_script) {
    cli_args <- optparse::parse_args(parser)
  } else {
    checkmate::assert_atomic_vector(
      cli_args,
      any.missing = FALSE,
      all.missing = FALSE
    )
    if (length(cli_args)) {
      checkmate::assert_character(cli_args)
    }
    cli_args <- optparse::parse_args(parser, args = cli_args)
  }

  characters <- character_factory(cli_args$file)
  winner <- battle(
    characters[[cli_args$c1]],
    characters[[cli_args$c2]],
    health = cli_args$health
  )

  if (is_script) {
    q(status = 0)
  }
  return(0)
}

main()
