# Documentation

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
