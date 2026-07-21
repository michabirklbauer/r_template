import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  base: "/r_template/",
  srcDir: "md",
  title: "R Template",
  description: "A template repository for R projects.",
  head: [
    [
      "link",
      {
        rel: "icon",
        href: "https://bioart.niaid.nih.gov/api/bioarts/411/files/633468.png",
      },
    ],
  ],
  markdown: {
   theme: {
     light: "catppuccin-latte",
     dark: "catppuccin-mocha",
    },
  },
  themeConfig: {
    logo: {
      src: "https://bioart.niaid.nih.gov/api/bioarts/411/files/633468.png",
      alt: "logo",
    },
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: "Home", link: "/" },
      { text: "Template", link: "/template" },
      { text: "Tooling", link: "/tooling" },
    ],
    sidebar: [
      {
        items: [
          { text: "Template", link: "/template" },
          { text: "Tooling", link: "/tooling" },
        ],
      },
    ],
    socialLinks: [{ icon: "github", link: "https://github.com/michabirklbauer/r_template" }],
    search: {
        provider: 'local'
    },
  },
})
