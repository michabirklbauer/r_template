[![Format with Air](https://github.com/michabirklbauer/r_template/actions/workflows/air.yml/badge.svg)](https://github.com/michabirklbauer/r_template/actions/workflows/air.yml)
[![Lint with Jarl](https://github.com/michabirklbauer/r_template/actions/workflows/jarl.yml/badge.svg)](https://github.com/michabirklbauer/r_template/actions/workflows/jarl.yml)
[![Test with testthat](https://github.com/michabirklbauer/r_template/actions/workflows/testthat.yml/badge.svg)](https://github.com/michabirklbauer/r_template/actions/workflows/testthat.yml)

# Template Repository for R projects and scripts

A template repository for modern R development with [renv](https://rstudio.github.io/renv/)
using [R6](https://r6.r-lib.org/) classes, validation with [checkmate](https://mllg.github.io/checkmate/),
logging with [lgr](https://s-fleck.github.io/lgr/), argument parsing with [optparse](https://github.com/trevorld/r-optparse/),
and a [Shiny](https://shiny.posit.co/) web app interface.
Formatted with [Air](https://posit-dev.github.io/air/),
linted with [Jarl](https://jarl.etiennebacher.com/),
and tested with [testthat](https://testthat.r-lib.org/) using
[GitHub Actions](https://docs.github.com/en/actions).

## Checklist

- [ ] Replace `YOURUSERNAME` and `IMAGENAME` in `.github/workflows/docker-image.yml` [or delete file].
- [ ] Replace data in `data` with your own (test) data [or delete if you don't have data].
- [ ] Adjust `.gitattributes` according to your needs [or delete file].
- [ ] Adjust `.gitignore` according to your needs.
- [ ] Setup your `CITATION.cff` according to your needs [or delete file].
- [ ] Update attribution in `Dockerfile` and write image instructions, see also [Docker](#docker).
- [ ] Replace copyright name in `LICENSE`.
- [ ] Update the main script in `lib/main.R`.
- [ ] Delete example `.R` files in `lib/` [and create your own].
- [ ] Check if `tests/testthat.R` needs updating.
- [ ] Write tests in `tests/testthat/`.
- [ ] Document your code inline using [roxygen2 style](https://roxygen2.r-lib.org/).
- [ ] Document your code/script by writing a documentation page, see [Documentation](#documentation).
- [ ] Adjust this `README.md` to your needs!

## Managing R Installations

It's recommended to use [rig](https://github.com/r-lib/rig) - the R Installation Manager.

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

## Documentation

This template features inline documentation using [roxygen2](https://roxygen2.r-lib.org/)
syntax. For setting up an online documentation page there is a [VitePress](https://vitepress.dev/)
template included in `docs`. It uses the [Catppuccin](https://catppuccin.com/) theme.

### Adjusting the Documentation

- Adjust the `docs/.vitepress/config.mts` file to your needs.
- Update the markdown files in `docs/md/`.
- The documentation is automatically built via
  [GitHub Actions](https://docs.github.com/en/actions) using this
  [workflow](https://github.com/michabirklbauer/r_template/blob/master/.github/workflows/gh-pages.yml),
  but you can see a live preview or build it locally by doing the following:
  - Install [Node.js](https://nodejs.org/).
  - Install [pnpm](https://pnpm.io/).
  - Navigate to the `docs/` directory:
    ```bash
    cd docs
    ```
  - Install dependencies with `pnpm`:
    ```bash
    pnpm i
    ```
  - Show a live preview:
    ```bash
    pnpm docs:dev
    ```
  - Build the site locally:
    ```bash
    pnpm docs:build
    ```

### Alternatives for Documentation

[Quarto](https://quarto.org/)
would be a possible and recommended alternative for building documentation pages.
If you write an R package you might also want to consider [pkgdown](https://pkgdown.r-lib.org/).

## Docker

If you want to containerize your R project with [Docker](https://www.docker.com/)
there are a few things to keep in mind, as pointed out below. You may also find it
helpful to read through this
[renv documentation](https://rstudio.github.io/renv/articles/docker.html).

### Installing System Dependencies

Depending on your R environment you will need to install additional system dependencies
in your Docker file. This mostly involves some trial and error but boils down to the
following steps:
- Checking the output of [renv::sysreqs()](https://rstudio.github.io/renv/reference/sysreqs.html),
  e.g. using:
  ```r
  renv::sysreqs(distro = "ubuntu:24.04", report = TRUE, collapse = TRUE)
  ```
- Checking the output of `renv::restore()` on the first image build.
- Debugging the build error messages you get.

### Managing Build Context

It's recommended to build the image using a clean repository state, e.g. using:
```bash
git clean -f -d -X
```
Alternatively consider using a [.dockerignore](https://docs.docker.com/build/concepts/context/#dockerignore-files)
file.

## Getting Help

- Help for this template:
  - [rig](https://github.com/r-lib/rig): R installation manager.
  - [renv](https://rstudio.github.io/renv/): R project and dependency management.
  - [Air](https://posit-dev.github.io/air/): R formatter and language server.
  - [Jarl](https://jarl.etiennebacher.com/): R linter.
  - [testthat](https://testthat.r-lib.org/): R testing suit.
  - [GitHub Actions](https://docs.github.com/en/actions): Used for running the above automatically.
- Contact: [micha.birklbauer@gmail.com](mailto:micha.birklbauer@gmail.com)

> [!IMPORTANT]
> The below sections should be adjusted and updated by you!

## Known Issues

[List of known issues](https://github.com/michabirklbauer/r_template/issues)

## Citing

If you are using PLACEHOLDER please cite:
```
Very important title
Important Author, and Another Important Author
Journal of Cool Stuff 2023 12 (3), 4567-4589
DOI: 12.3456/cool-stuff
```

## License

- [MIT](https://github.com/michabirklbauer/r_template/blob/master/LICENSE)

## Contact

- [your.mail@mail.com](mailto:your.mail@mail.com)
