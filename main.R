#!/usr/bin/env Rscript

renv::restore(prompt = FALSE)

source("lib/battle.R")

characters <- character_factory("data/characters.csv")
winner <- battle(characters[[1]], characters[[2]], health = 130.0)
