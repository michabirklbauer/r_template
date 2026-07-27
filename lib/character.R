#!/usr/bin/env Rscript

library(tidyverse)
library(checkmate)
library(glue)
library(R6)

#' R6 Class representing a character
#'
#' Notes:
#' Minimum and maximum damage are automatically switched depending on which is
#' greater.
#' @examples
#' source("lib/main.R")
#' jb <- Character$new(name = "John Baldur")
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
    #' @field name Name of the character (read-only).
    name = function() private$.name,
    #' @field race Race of the character (read-only).
    race = function() private$.race,
    #' @field min_damage Minimum damage the character deals (read-only).
    min_damage = function() private$.min_damage,
    #' @field max_damage Maximum damage the character deals (read-only).
    max_damage = function() private$.max_damage,
    #' @field avg_damage Average damage dealt by the character (read-only).
    avg_damage = function() private$.avg_damage
  ),
  public = list(
    #' @description
    #' Creates a new Character.
    #' @param name Name of the character (type: string).
    #' @param race Race of the character (type: "Elf", "Half-Elf", "Human").
    #'   Defaults to `NULL`.
    #' @param min_damage Minimum damage the character deals (type: numeric).
    #'   Defaults to `0.0`.
    #' @param max_damage Maximum damage the character deals (type: numeric).
    #'   Defaults to `0.0`.
    #' @returns A new `Character` instance (type: Character).
    #' @examples
    #' source("lib/main.R")
    #' jb <- Character$new(name = "John Baldur")
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
      private$.min_damage <- min(min_damage, max_damage)
      private$.max_damage <- max(min_damage, max_damage)
      private$.avg_damage <- (private$.min_damage + private$.max_damage) / 2.0
    },
    #' @description
    #' Creates a copy of the class instance with optional attribute updates.
    #' @param update A list mapping attribute names to their updated values (type: list).
    #'   Defaults to an empty list (creates an exact copy of the instance).
    #' @returns A new character with optionally updated attributes (type: Character).
    #' @examples
    #' source("lib/main.R")
    #' jb <- Character$new(name="John Baldur")
    #' jb_copy <- jb$copy_with_update(update = list(race = "Human"))
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
    #' @description
    #' Gets the attack damage of the next attack.
    #' @returns The attack damage of the attack (type: numeric).
    #' @examples
    #' source("lib/main.R")
    #' jb <- Character$new(name="John Baldur")
    #' jb$attack()
    attack = function() {
      private$.min_damage +
        (private$.max_damage - private$.min_damage) * runif(1)
    },
    #' @description
    #' Plots the attribute values of the character.
    #' @returns A plot of the character attribute values (type: `ggplot2::ggplot`).
    #' @examples
    #' source("lib/main.R")
    #' jb <- Character$new(name="John Baldur")
    #' jb$plot()
    plot = function() {
      data.frame(
        damage_type = factor(
          c("Minimum", "Average", "Maximum"),
          levels = c("Minimum", "Average", "Maximum")
        ),
        damage_value = c(
          private$.min_damage,
          private$.avg_damage,
          private$.max_damage
        )
      ) |>
        ggplot(aes(x = damage_type, y = damage_value)) +
        geom_bar(
          stat = "identity",
          color = "black",
          fill = "dodgerblue3",
          width = 0.7
        ) +
        ggtitle(glue("Character: {private$.name}")) +
        xlab("Damage Type") +
        ylab("Damage") +
        geom_text(aes(label = damage_value), vjust = -0.3, size = 3.0) +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 90, hjust = 1))
    }
  ),
  lock_objects = TRUE,
  lock_class = TRUE,
  cloneable = FALSE
)

#' Creates a list of characters from a file
#'
#' @param filename The filename of the character `csv` file (type: string).
#' @param ... Additional parameters are passed to `readr::read_csv()`.
#' @returns The parsed list of characters (type: list of Character).
#' @examples
#' source("lib/main.R")
#' characters <- character_factory("data/characters.csv")
character_factory <- function(filename, ...) {
  checkmate::assert_string(filename)

  df <- readr::read_csv(filename, ...)

  characters <- list()
  for (i in rownames(df)) {
    parsed_character <- Character$new(
      name = as.character(df[i, "name"]),
      race = as.character(df[i, "race"]),
      min_damage = as.numeric(df[i, "min_damage"]),
      max_damage = as.numeric(df[i, "max_damage"])
    )
    characters[[i]] <- parsed_character
  }

  return(characters)
}
