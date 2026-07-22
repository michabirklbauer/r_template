#!/usr/bin/env Rscript

library(tidyverse)
library(checkmate)
library(R6)

Character <- R6Class(
  "Character",
  private = list(
    .name = NULL,
    .race = NULL,
    .min_damage = NULL,
    .max_damage = NULL,
    .avg_damage = NULL
  ),
  active = list(
    name = function() private$.name,
    race = function() private$.race,
    min_damage = function() private$.min_damage,
    max_damage = function() private$.max_damage,
    avg_damage = function() private$.avg_damage
  ),
  public = list(
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
      private$.name <- name
      private$.race <- race
      if (min_damage > max_damage) {
        private$.min_damage <- max_damage
        private$.max_damage <- min_damage
      } else {
        private$.min_damage <- min_damage
        private$.max_damage <- max_damage
      }
      private$.avg_damage <- (private$.min_damage + private$.max_damage) / 2.0
    },
    copy_with_update = function(update = list()) {
      checkmate::assert_list(update)
      Character$new(
        name = if (!is.null(update$name)) {
          update$name
        } else {
          private$.name
        },
        race = if (!is.null(update$race)) {
          update$race
        } else {
          private$.race
        },
        min_damage = if (!is.null(update$min_damage)) {
          update$min_damage
        } else {
          private$.min_damage
        },
        max_damage = if (!is.null(update$max_damage)) {
          update$max_damage
        } else {
          private$.max_damage
        }
      )
    },
    attack = function() {
      private$.min_damage +
        (private$.max_damage - private$.min_damage) * runif(1)
    }
  ),
  lock_objects = TRUE,
  lock_class = TRUE,
  cloneable = FALSE
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
