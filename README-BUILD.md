# Building the Cloud Haskell Website

This website is built using [Hakyll](https://jaspervdj.be/hakyll/), a Haskell static site generator, and styled with [Bulma CSS](https://bulma.io/).

## Prerequisites

- GHC (Glasgow Haskell Compiler) 8.10 or later
- Cabal 3.0 or later (or Stack)

## Building the Site

### Using Cabal

1. **Build the site generator:**
   ```bash
   cabal build
   ```

2. **Build the website:**
   ```bash
   cabal run site build
   ```

3. **Preview the website locally:**
   ```bash
   cabal run site watch
   ```
   Then open http://localhost:8000 in your browser.

## Site Generator Commands

The site generator (`site`) supports several commands:

- `build` - Build the website
- `watch` - Start a preview server and watch for changes
- `clean` - Clean generated files
- `rebuild` - Clean and rebuild
- `deploy` - Deploy to GitHub Pages (if configured)

## Project Structure

```
.
├── site.hs              # Hakyll site generator configuration
├── site.cabal           # Cabal package definition
├── templates/           # HTML templates (with Bulma CSS)
│   ├── default.html     # Main layout
│   ├── index.html       # Homepage with hero section
│   ├── documentation.html # Docs with sidebar
│   ├── tutorial.html    # Tutorial pages
│   ├── post.html        # Blog posts
│   └── ...
├── posts/               # Blog posts (Markdown)
├── tutorials/           # Tutorial content
├── css/                 # Stylesheets
│   ├── custom.css       # Custom styles
│   └── syntax.css       # Code syntax highlighting
├── js/                  # JavaScript files
├── img/                 # Images
├── static/              # Other static assets
└── _site/               # Generated site (git-ignored)
```

## Content

- **Blog posts**: Create `.md` files in `posts/` directory
- **Tutorials**: Edit files in `tutorials/` directory
- **Documentation**: Edit `documentation.md`
- **Homepage**: Edit `index.md`

All content uses Markdown with YAML front matter:

```markdown
---
title: Your Title
date: 2024-01-01
---

Your content here...
```

## Design

The site uses:
- **Bulma CSS** framework for responsive, modern styling
- **Font Awesome** for icons
- **Nord-inspired** color scheme for code highlighting
- **Custom CSS** for additional styling (`css/custom.css`)

## Deployment

The site is deployed to GitHub Pages. After building:

```bash
# The _site directory contains the generated static site
# This can be deployed to GitHub Pages or any static host
```

## Development

When making changes:

1. Edit source files (templates, content, CSS)
2. Run `cabal run site watch` to preview changes
3. The site auto-rebuilds when files change
4. Refresh your browser to see updates

## Troubleshooting

**Build errors:**
- Ensure you have GHC and Cabal installed: `ghc --version` and `cabal --version`
- Try cleaning: `cabal run site clean` then rebuild

**Port already in use:**
- The preview server uses port 8000 by default
- Stop any other processes using this port

**Template errors:**
- Check template syntax in `templates/` directory
- Ensure all `$variable$` references are defined in the context

## Resources

- [Hakyll Documentation](https://jaspervdj.be/hakyll/)
- [Bulma Documentation](https://bulma.io/documentation/)
- [Pandoc Markdown](https://pandoc.org/MANUAL.html#pandocs-markdown)
