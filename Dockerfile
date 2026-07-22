# Dockerfile with SCRIPT TITLE
# author: YOUR NAME
# version: 1.0.0

FROM ghcr.io/r-lib/rig/debian:latest

LABEL maintainer="you@yourname.com"

RUN mkdir app
COPY ./ app/
WORKDIR app

RUN rig add 4.6.1
RUN rig default 4.6.1
RUN Rscript -e "renv::restore(clean=T)"

CMD ["Rscript", "run.R", "-s"]
