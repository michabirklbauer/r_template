# Dockerfile with SCRIPT TITLE
# author: YOUR NAME
# version: 1.0.0

FROM ghcr.io/r-lib/rig/debian:latest

LABEL maintainer="you@yourname.com"

RUN mkdir app
COPY ./ app/
WORKDIR app

# refer to Docker section in the README
RUN apt-get update
RUN apt-get install -y \
    cmake libfontconfig1-dev libfreetype6-dev libx11-dev libxml2-dev pandoc \
    libwebpmux3

RUN rig add 4.6.1
RUN rig default 4.6.1
RUN Rscript -e "renv::restore(clean=T)"

CMD ["Rscript", "run.R", "-s"]
