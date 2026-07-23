# Tooling

It's recommended to use [rig](https://github.com/r-lib/rig) - the R Installation
Manager - for managing R installations.

## Tools

This template uses the following tools:
- [rig](https://github.com/r-lib/rig): R installation manager.
- [renv](https://rstudio.github.io/renv/): R project and dependency management.
- [Air](https://posit-dev.github.io/air/): R formatter and language server.
- [Jarl](https://jarl.etiennebacher.com/): R linter.
- [testthat](https://testthat.r-lib.org/): R testing suit.
- [GitHub Actions](https://docs.github.com/en/actions): Used for running the above automatically.

## Helpful Commands

- [rig](https://github.com/r-lib/rig):
  - Install a specific R version, e.g. `4.6.1`:
    ```bash
    rig add 4.6.1
    ```
  - Set a default R version, e.g. `4.6.1`:
    ```bash
    rig default 4.6.1
    ```
- [renv](https://rstudio.github.io/renv/):
  - Restore an R environment:
    ```bash
    Rscript -e "renv::restore()"
    ```
    or
    ```r
    renv::restore()
    ```
  - Snapshot an R environment:
    ```bash
    Rscript -e "renv::snapshot()"
    ```
    or
    ```r
    renv::snapshot()
    ```
  - Install a package:
    ```bash
    Rscript -e "renv::install('pkg')"
    ```
    or
    ```r
    renv::install("pkg")
    ```
  - Install a package from [Bioconductor](https://www.bioconductor.org/):
    ```bash
    Rscript -e "renv::install('bioc::pkg')"
    ```
    or
    ```r
    renv::install("bioc::pkg")
    ```
- [Air](https://posit-dev.github.io/air/):
  - Format files:
    ```bash
    air format
    ```
  - Alternatively, setup `air` editor integration as described
    [here](https://posit-dev.github.io/air/editors.html).
  - Check if files are properly formatted:
    ```bash
    air format --check
    ```
- [Jarl](https://jarl.etiennebacher.com/):
  - Lint with `jarl`:
    ```bash
    jarl check .
    ```
- [testthat](https://testthat.r-lib.org/):
  - Test with `testthat`:
    ```bash
    Rscript -e "source('tests/testthat.R')"
    ```
- Run application:
  - CLI mode (example for this application):
    ```bash
    Rscript run.R -f data/characters.csv
    ```
  - [Shiny](https://shiny.posit.co/) mode (example for this application):
    ```bash
    Rscript run.R -s
    ```
