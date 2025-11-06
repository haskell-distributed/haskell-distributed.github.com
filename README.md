# Cloud Haskell Documentation

Official documentation website for the Haskell Distributed libraries.

**Live site:** https://haskell-distributed.github.io

## Overview

This site provides documentation, tutorials, and resources for Cloud Haskell - a set of libraries for Erlang-style concurrent and distributed programming in Haskell.

## Technology Stack

- **Static Site Generator:** [Hakyll](https://jaspervdj.be/hakyll/) (Haskell-based)
- **CSS Framework:** [Bulma](https://bulma.io/)
- **Design Inspiration:** Modern documentation sites like Tokio and Irmin

## Building the Site

See [README-BUILD.md](README-BUILD.md) for detailed build instructions.

Quick start:
```bash
cabal build
cabal run site build
cabal run site watch  # Preview at http://localhost:8000
```

## Contributing

Contributions are welcome! Please feel free to submit pull requests for:
- Documentation improvements
- Tutorial additions
- Bug fixes
- Design enhancements

## License

The Cloud Haskell Platform is open source and available under the BSD3 license.