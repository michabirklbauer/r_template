# r_template

A work-in-progress template for R projects and scripts.

## Checklist

## Helpful Commands

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
