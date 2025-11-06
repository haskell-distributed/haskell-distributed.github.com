---
title: Code Highlighting Test
---

# Code Highlighting Test

This page demonstrates the code highlighting styles.

## Inline Code

Here is some `inline code` that should be readable and match the site's blue color scheme.

You can use inline code like `import Control.Distributed.Process` in your text.

More examples: `ProcessId`, `send`, `expect`, `newLocalNode`, `runProcess`

The inline code now uses the primary color scheme:
- Background: Light blue (`#e8f0f8`)
- Text: Dark blue (`#4c6a8f`) - matches the primary-dark color
- Border: Subtle blue-grey (`#d0dde9`)

This creates a cohesive look with the rest of the site, complementing the hero gradient and primary blue (`#5e81ac`) used throughout.

## Code Blocks

### Haskell Code

```haskell
-- Simple process example
import Control.Distributed.Process
import Control.Distributed.Process.Node

-- | Simple ping server
pingServer :: Process ()
pingServer = do
  say "Ping server started"
  forever $ do
    ping <- expect :: Process String
    say $ "Got ping: " ++ ping
    send ping "pong"

-- | Main function
main :: IO ()
main = do
  putStrLn "Starting distributed system"
  node <- newLocalNode
  runProcess node pingServer
```

### Plain Code Block

```
This is a plain code block
Without syntax highlighting
But it should still be readable
```

## Features

- **Dark background**: `#3b4252` (Nord-inspired)
- **Light text**: `#d8dee9` for high contrast
- **Colored syntax**: Keywords, types, strings, etc.
- **Readable inline code**: Light background with colored text

## Color Palette

- Keywords: `#81a1c1` (blue)
- Types: `#8fbcbb` (cyan)
- Strings: `#a3be8c` (green)
- Functions: `#88c0d0` (light cyan)
- Comments: `#616e88` (grey, italic)
- Numbers: `#b48ead` (purple)
