# Homebrew tap

```
brew install --cask pulkitxm/tap/edith
```

Edith is a native menu bar control center for the Mac: live usage limits for
Claude and Codex, clipboard history, a local music player, a notch shelf, and the
rest of the shelf of utilities it replaces. Free and open source under the GPL-3.0.

The cask installs `Edith.app` and puts the `ed` and `edh` command line tools on
your `PATH`. Note that `ed` shadows the POSIX line editor of the same name; run
`/usr/bin/ed` when you want that one.

Edith updates itself through Sparkle, so the cask is marked `auto_updates true`
and a routine `brew upgrade` leaves it alone. Force Homebrew to fetch the newest
release with:

```
brew upgrade --cask --greedy edith
```

## This repository is generated

`Casks/edith.rb` is written by the release workflow in
[pulkitxm/edith](https://github.com/pulkitxm/edith), which hashes the disk image
it just published and pushes the result here. Nothing is hand-edited. Open issues
and pull requests against the main repository:

- [Source and issues](https://github.com/pulkitxm/edith)
- [Homebrew documentation](https://github.com/pulkitxm/edith/blob/main/docs/homebrew.md)
- [Website](https://edith.pulkit.page)
