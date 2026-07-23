# r_template

A work-in-progress template for R projects and scripts.

## Checklist

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
- [air](https://posit-dev.github.io/air/):
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
- [jarl](https://jarl.etiennebacher.com/):
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
