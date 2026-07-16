library(tidyverse)

a = 1
b <- 1

if (all.equal(a, b, tolerance = 1e-3)) {
  message('equal')
}
