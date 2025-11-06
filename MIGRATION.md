# Migration from Jekyll to Hakyll

This document describes the migration of the Cloud Haskell documentation site from Jekyll to Hakyll with Bulma CSS.

## What Changed

### Static Site Generator
- **Before:** Jekyll (Ruby-based)
- **After:** Hakyll (Haskell-based)

### CSS Framework
- **Before:** Bootstrap (older version)
- **After:** Bulma CSS (modern, responsive)

### Design
- **Before:** Traditional Bootstrap navbar and layout
- **After:** Modern design inspired by Tokio.rs and Irmin.org
  - Hero section on homepage
  - Feature cards highlighting key capabilities
  - Responsive sidebar for documentation
  - Modern color scheme (Nord-inspired)
  - Improved typography
  - Better code syntax highlighting

## Directory Structure Changes

### Renamed/Moved
- `_posts/` → `posts/` (Hakyll convention)
- `_layouts/` → `old_layouts/` (archived)
- `_includes/` → `old_includes/` (archived)

### New Files
```
site.hs              # Hakyll site generator
site.cabal           # Cabal package definition
templates/           # New Bulma-based templates
  ├── default.html
  ├── index.html
  ├── documentation.html
  ├── tutorial.html
  ├── post.html
  ├── blog.html
  └── page.html
css/
  ├── custom.css     # Custom styling
  └── syntax.css     # Code highlighting
.github/workflows/
  └── deploy.yml     # Automated CI/CD
README-BUILD.md      # Build instructions
MIGRATION.md         # This file
Makefile.new         # Build helpers
```

## Key Features

### Homepage
- **Hero Section:** Eye-catching header with gradient background
- **Feature Cards:** Six cards highlighting Cloud Haskell capabilities:
  - Distributed Computing
  - Concurrent Processes
  - Fault Tolerance
  - Pluggable Transports
  - Platform Libraries
  - Type Safety
- **Recent Posts:** Shows latest 3 blog posts
- **Call to Action:** Prominent buttons for getting started

### Documentation
- **Sidebar Navigation:** Organized menu for easy navigation
  - Getting Started
  - Core Libraries
  - Platform Libraries
  - Network Transports
  - Tutorials
  - Resources
- **Responsive:** Sidebar converts to mobile-friendly menu on small screens

### Blog
- **Dedicated Blog Page:** Clean listing of all posts
- **Individual Post Pages:** Improved readability with proper spacing
- **Tags:** Support for categorizing posts

### Tutorials
- **Breadcrumb Navigation:** Easy to track location
- **Info Boxes:** Highlighted sections for important information
- **Code Highlighting:** Nord-themed syntax highlighting

## Building the Site

### Old Way (Jekyll)
```bash
bundle install
bundle exec jekyll serve
```

### New Way (Hakyll)
```bash
cabal build
cabal run site build
cabal run site watch
```

Or use the Makefile:
```bash
make build
make watch
```

## Deployment

### Automated via GitHub Actions
- Builds automatically on push to main/master
- Deploys to GitHub Pages
- Uses caching for faster builds

### Manual
```bash
make build
# _site directory contains the generated site
```

## Content Migration

All existing content has been preserved:
- ✅ Blog posts (in `posts/`)
- ✅ Tutorials (in `tutorials/`)
- ✅ Documentation (`documentation.md`)
- ✅ Other pages (about, contact, team, wiki)
- ✅ Static assets (images, PDFs, etc.)

### Markdown Compatibility
Hakyll uses Pandoc for Markdown processing, which is compatible with Jekyll's Kramdown with additional features.

## Design Elements

### Color Scheme
```css
Primary:     #5e81ac (blue)
Primary Dark: #4c6a8f
Primary Light: #88c0d0
Secondary:   #bf616a (red)
Dark BG:     #2e3440
Light BG:    #eceff4
Code BG:     #3b4252
```

### Typography
- System fonts for performance and native feel
- Improved line height (1.7) for readability
- Better heading hierarchy

### Components
- Cards with hover effects
- Smooth scrolling
- Sticky sidebar navigation
- Responsive navbar with mobile menu
- Modern footer with organized links

## Browser Support

The new design uses modern CSS that works in:
- Chrome/Edge (latest)
- Firefox (latest)
- Safari (latest)
- Mobile browsers (iOS Safari, Chrome Mobile)

## Performance

### Improvements
- **No jQuery dependency** (used by old Bootstrap)
- **Minimal JavaScript** (only navbar toggle)
- **CDN-hosted Bulma** (cached across sites)
- **Static generation** (fast page loads)

## Maintenance

### Adding Content

**Blog Post:**
```markdown
---
title: New Post Title
date: 2024-01-01
---

Content here...
```

**Tutorial:**
Just edit files in `tutorials/` directory.

**Documentation:**
Edit `documentation.md` or template in `templates/documentation.html`.

### Modifying Design

- **Colors:** Edit `css/custom.css`
- **Layout:** Edit templates in `templates/`
- **Navigation:** Edit `templates/default.html`

## Troubleshooting

### Common Issues

**Build fails:**
- Ensure GHC 8.10+ and Cabal 3.0+ are installed
- Run `cabal update`
- Try `cabal clean` then rebuild

**Template errors:**
- Check all `$variables$` are defined in site.hs contexts
- Verify template syntax

**Content not appearing:**
- Check file paths match patterns in site.hs
- Ensure proper YAML front matter

## Resources

- [Hakyll Documentation](https://jaspervdj.be/hakyll/)
- [Bulma Documentation](https://bulma.io/documentation/)
- [Tokio.rs](https://tokio.rs) (design inspiration)
- [Irmin.org](https://irmin.org) (design inspiration)

## Next Steps

1. ✅ Set up GitHub Pages deployment
2. Test the site thoroughly
3. Gather feedback from users
4. Continue improving documentation
5. Add more tutorials

## Rollback (if needed)

If you need to revert to Jekyll:
```bash
mv old_layouts _layouts
mv old_includes _includes
mv posts _posts
# Use old Gemfile and Jekyll configuration
```

## Questions?

Open an issue on GitHub or contact the maintainers.
