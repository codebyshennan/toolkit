# How to use

[Source](https://medium.com/codex/how-and-why-you-should-split-your-bashrc-or-zshrc-files-285e5cc3c843)

## Breakdown

`init.sh` contains the stuff needed by the shell (zsh) like its initializer, plugins, theme, etc.

`general.sh` contains all the stuff that doesn’t belong in the current split files, and too few to warrant a dedicated file. This will be the default file for stuff that couldn’t be easily classified.
