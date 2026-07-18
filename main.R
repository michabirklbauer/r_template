#!/usr/bin/env Rscript

library(tidyverse)
library(checkmate)
library(glue)
library(lgr)
library(R6)

logger <- lgr::get_logger("logger", class = lgr::LoggerGlue)
logger$config("logger.yaml")

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
      checkmate::assert_string(race, null.ok = T)
      checkmate::assert_choice(race, c("Elf", "Half-Elf", "Human"), null.ok = T)
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

battle <- function(character_1, character_2, health = 100.0) {
  checkmate::assert_class(character_1, "Character")
  checkmate::assert_class(character_1, "Character")
  checkmate::assert_number(health, lower = 1.0)
  health_1 <- health
  health_2 <- health
  initiative <- runif(1)
  if (initiative < 0.5) {
    logger$info("Character {character_1$name} has initiative!")
  } else {
    logger$info("Character {character_2$name} has initiative!")
  }
  while (T) {
    if (initiative < 0.5) {
      attack <- character_1$attack()
      logger$info("Character {character_1$name} deals {attack} damage!")
      health_2 <- health_2 - attack

      if (health_2 <= 0) {
        break
      }
      attack <- character_2$attack()
      logger$info("Character {character_2$name} deals {attack} damage!")
      health_1 <- health_1 - attack
      if (health_1 <= 0) {
        break
      }
    } else {
      attack <- character_2$attack()
      logger$info("Character {character_2$name} deals {attack} damage!")
      health_1 <- health_1 - attack
      if (health_1 <= 0) {
        break
      }
      attack <- character_1$attack()
      logger$info("Character {character_1$name} deals {attack} damage!")
      health_2 <- health_2 - attack
      if (health_2 <= 0) {
        break
      }
    }
  }
  if (health_1 <= 0) {
    logger$info("Character {character_2$name} won!")
    return(character_2)
  }
  logger$info("Character {character_1$name} won!")
  return(character_1)
}

characters <- character_factory("data/characters.csv")
winner <- battle(characters[[1]], characters[[2]], health = 130.0)
