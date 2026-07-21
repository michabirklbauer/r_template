#!/usr/bin/env Rscript

library(tidyverse)
library(checkmate)
library(R6)

Character <- R6Class(
  "Character",
  public = list(
    name = NULL,
    race = NULL,
    min_damage = NULL,
    max_damage = NULL,
    avg_damage = NULL,
    initialize = function(name, race = NULL, min_damage = 0, max_damage = 0) {
      checkmate::assert_string(name)
      checkmate::assert_string(race, null.ok = TRUE)
      checkmate::assert_choice(
        race,
        c("Elf", "Half-Elf", "Human"),
        null.ok = TRUE
      )
      checkmate::assert_number(min_damage)
      checkmate::assert_number(max_damage)
      self$name <- name
      self$race <- race
      if (min_damage > max_damage) {
        self$min_damage <- max_damage
        self$max_damage <- min_damage
      } else {
        self$min_damage <- min_damage
        self$max_damage <- max_damage
      }
      self$avg_damage <- (self$min_damage + self$max_damage) / 2.0
    },
    attack = function() {
      self$min_damage + (self$max_damage - self$min_damage) * runif(1)
    }
  )
)

character_factory <- function(filename) {
  checkmate::assert_string(filename)
  df <- readr::read_csv(filename)
  characters <- list()
  for (i in rownames(df)) {
    parsed_character <- Character$new(
      as.character(df[i, "name"]),
      as.character(df[i, "race"]),
      as.numeric(df[i, "min_damage"]),
      as.numeric(df[i, "max_damage"])
    )
    characters[[i]] <- parsed_character
  }
  return(characters)
}
