# Template Repository for R Projects and Scripts

A template repository for modern R development with [renv](https://rstudio.github.io/renv/)
using [R6](https://r6.r-lib.org/) classes, validation with [checkmate](https://mllg.github.io/checkmate/),
logging with [lgr](https://s-fleck.github.io/lgr/), argument parsing with [optparse](https://github.com/trevorld/r-optparse/),
and a [Shiny](https://shiny.posit.co/) web app interface.
Formatted with [Air](https://posit-dev.github.io/air/),
linted with [Jarl](https://jarl.etiennebacher.com/),
and tested with [testthat](https://testthat.r-lib.org/) using
[GitHub Actions](https://docs.github.com/en/actions).

## Repository Structure

- `run.R` is the base R script for running the repository's application. It should not be modified!
- The main R script logic should go into `lib/main.R`.
- The [Shiny](https://shiny.posit.co/) app code should go into `lib/shiny.R`.
- Any additional code should go into R scripts in `lib/`.
- Tests should go into the directory `tests/testthat/`.
- The file `tests/testthat.R` should stay unmodified.
- Modification of the `tests/testthat.R` file is only required if code outside of `lib/main.R` is imported - but that is a bad practice!
- Documentation should go into the `docs/` directory.

## Setup

- Make sure to install the following programs:
  - [rig](https://github.com/r-lib/rig)
  - [Air](https://posit-dev.github.io/air/)
  - [Jarl](https://jarl.etiennebacher.com/)
- Or prompt the user to install them preemptively.
- Execute all shell and R commands in the repository root.

## Managing R Installations

- Use [rig](https://github.com/r-lib/rig) - the R Installation Manager - for managing R installations.
- Use `rig add` to a install an R version:
  - Example: Install a specific R version, e.g. `4.6.1`:
    ```bash
    rig add 4.6.1
    ```
- Use `rig default` to set a default R version, which should be the version required by `renv`:
  - Example: Set a default R version, e.g. `4.6.1`:
    ```bash
    rig default 4.6.1
    ```

## Managing the R Environment

- Use [renv](https://rstudio.github.io/renv/) to manage the projects R environment.
- When launching an R session for the first time in this repository, make sure to call `renv::restore()` in the R session.
- Alternatively, run `Rscript -e "renv::restore()"` in a bash or similar shell.
- Generally, to restore an R environment at any time, run:
  ```bash
  Rscript -e "renv::restore()"
  ```
  or
  ```r
  renv::restore()
  ```
- When a new R dependency is added, create a snapshot of the R environment with `renv::snapshot()`:
  ```bash
  Rscript -e "renv::snapshot()"
  ```
  or
  ```r
  renv::snapshot()
  ```
- To install a new dependency/package use `renv::install()`:
  ```bash
  Rscript -e "renv::install('pkg')"
  ```
  or
  ```r
  renv::install("pkg")
  ```
- To install a package from [Bioconductor](https://www.bioconductor.org/) use the `bioc::pkg` convention:
  ```bash
  Rscript -e "renv::install('bioc::pkg')"
  ```
  or
  ```r
  renv::install("bioc::pkg")
  ```

## Code Quality and Style

- Use [Jarl](https://jarl.etiennebacher.com/) for linting.
- Run `jarl check .` to make sure all the R code in the repository passes linting.
- Use [Air](https://posit-dev.github.io/air/) for code formatting.
- Run `air format` to format all R files.
- Check with `air format --check` that all R files in the repository are properly formatted.
- Make sure that variables and functions are `snake_case` and classes are `CamelCase`. Constants should be capitalized `SNAKE_CASE`.
- Use [R6](https://r6.r-lib.org/) classes for class implementations.
- Function parameters should be type checked using [checkmate](https://mllg.github.io/checkmate/).
- Use [lgr](https://s-fleck.github.io/lgr/) for logging state and events of R code.
- Use [optparse](https://github.com/trevorld/r-optparse/) in the `lib/main.R` file to parse commandline arguments.

## Testing

- Use [testthat](https://testthat.r-lib.org/) for testing R code.
- Tests should go into the directory `tests/testthat/`.
- The file `tests/testthat.R` should stay unmodified.
- Modification of the `tests/testthat.R` file is only required if code outside of `lib/main.R` is imported - but that is a bad practice!
- Run `Rscript -e "source('tests/testthat.R')"` to run all tests. The process should exit with code 0 if all tests pass.

## Documentation

- Use [roxygen2](https://roxygen2.r-lib.org/) style for inline documentation.
- Use the files in `docs/` for setting up `html` documentation.
- The `html` documentation is built using [VitePress](https://vitepress.dev/).

### Adjusting the `html` Documentation

- Adjust the `docs/.vitepress/config.mts` file to reflect the repository use case and name.
- Change the markdown files in `docs/md/` to reflect the repository use case.
- The documentation can be built locally by doing the following:
  - Installing [Node.js](https://nodejs.org/).
  - Installing [pnpm](https://pnpm.io/).
  - Navigating to the `docs/` directory with `cd docs`.
  - Installing dependencies with `pnpm`, make sure this is run in the `docs/` directory:
    ```bash
    pnpm i
    ```
  - Showing a live preview, make sure this is run in the `docs/` directory:
    ```bash
    pnpm docs:dev
    ```
  - Building the site locally, make sure this is run in the `docs/` directory:
    ```bash
    pnpm docs:build
    ```

### Alternatives for `html` Documentation

- [Quarto](https://quarto.org/) would be a possible and recommended alternative for building documentation pages.
- If the repository is used for building an R package, consider using [pkgdown](https://pkgdown.r-lib.org/).
- Make sure to clarify with the user which documentation approach should be taken when initially setting up the repository!

## Docker

- To containerize the repository with [Docker](https://www.docker.com/) refer to the [renv documentation](https://rstudio.github.io/renv/articles/docker.html).

### Installing Image System Dependencies

- Additional system dependencies might need to be installed in the Dockerfile, depending on the R environment.
- Identifying system dependencies mostly involves some trial and error but boils down to the following steps:
  - Checking the output of [renv::sysreqs()](https://rstudio.github.io/renv/reference/sysreqs.html),
    e.g. using:
    ```r
    renv::sysreqs(distro = "ubuntu:24.04", report = TRUE, collapse = TRUE)
    ```
  - Checking the output of `renv::restore()` on the first image build.
  - Debugging the build error messages you get.

### Managing Image Build Context

- It's recommended to build the image using a clean repository state, e.g. using:
  ```bash
  git clean -f -d -X
  ```
- Alternatively consider using a [.dockerignore](https://docs.docker.com/build/concepts/context/#dockerignore-files) file.

## CI/CD

- Workflows for [GitHub Actions](https://docs.github.com/en/actions) can be found in `.github/workflows`.
- Pull requests that target `master` should come from the `develop` branch when using this template.
- The `branch-protection.yml` workflow can be removed if pull requests targeting `master` should be allowed from any branch.
- The `gh-pages.yml` workflow automatically deploys the `html` documentation to [GitHub Pages](https://docs.github.com/en/pages).
