#!/usr/bin/env Rscript

library(checkmate)
library(glue)
library(lgr)

source("lib/character.R")

logger <- lgr::get_logger("logger", class = lgr::LoggerGlue)
logger$config("logger.yaml")

battle <- function(character_1, character_2, health = 100.0) {
  checkmate::assert_class(character_1, "Character")
  checkmate::assert_class(character_1, "Character")
  checkmate::assert_number(health, lower = 1.0)
  health_1 <- health
  health_2 <- health
  logger$info("---------- BATTLE ----------")
  logger$info("Both characters have {health} hit points! The battle begins:")
  initiative <- runif(1)
  if (initiative < 0.5) {
    logger$info("Character {character_1$name} has initiative!")
  } else {
    logger$info("Character {character_2$name} has initiative!")
  }
  repeat {
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
