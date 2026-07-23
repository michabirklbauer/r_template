# Template Repository for R Projects and Scripts

This is a template repository for modern R development with [renv](https://rstudio.github.io/renv/)
using [R6](https://r6.r-lib.org/) classes, validation with [checkmate](https://mllg.github.io/checkmate/),
logging with [lgr](https://s-fleck.github.io/lgr/), argument parsing with [optparse](https://github.com/trevorld/r-optparse/),
and a [Shiny](https://shiny.posit.co/) web app interface.
Formatted with [Air](https://posit-dev.github.io/air/),
linted with [Jarl](https://jarl.etiennebacher.com/),
and tested with [testthat](https://testthat.r-lib.org/) using
[GitHub Actions](https://docs.github.com/en/actions).

## Checklist

You should go through the following steps when using this template:

- Replace `YOURUSERNAME` and `IMAGENAME` in `.github/workflows/docker-image.yml` [or delete file].
- Replace data in `data` with your own (test) data [or delete if you don't have data].
- Adjust `.gitattributes` according to your needs [or delete file].
- Adjust `.gitignore` according to your needs.
- Setup your `CITATION.cff` according to your needs [or delete file].
- Update attribution in `Dockerfile` and write image instructions, see also [Docker](/docker).
- Replace copyright name in `LICENSE`.
- Update the main script in `lib/main.R`.
- Delete example `.R` files in `lib/` [and create your own].
- Check if `tests/testthat.R` needs updating.
- Write tests in `tests/testthat/`.
- Document your code inline using [roxygen2 style](https://roxygen2.r-lib.org/).
- Document your code/script by writing a documentation page, see [Documentation](#documentation).
- Adjust this `README.md` to your needs!
