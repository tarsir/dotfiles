# tarsir's dotfiles

These are my dotfiles, consisting of:

- some bash/nushell files
- some other common configs for applications
- `.tool-versions` for `asdf`
- a whole lot of Neovim config
- `setup.sh`, a script to install all my usual dependencies
- `make_symlinks.sh`, a script to make symlinks or otherwise move stuff to the right place

## How to Use

Simply clone the repo, then run:

```sh
./setup.sh -a
./make_symlinks.sh
```

### `make_symlinks.sh`

This script does a little more than symlinking, such as:

- Backs up existing `.bashrc` and `.gitbash`
- Removes current versions of those files
- Copies configs for ssh, gitui, starship, and nushell
- Copies nvim config

### `setup.sh`

Alternative options for `setup.sh` include:

- `-s/--sys` only installs system packages, supporting `apt` and `pacman`
- `-a/--asdf` runs some setup for my `asdf` languages
- `-r/--rust` installs rust and installs some tools with cargo
- `-b/--brew` installs some homebrew packages

## Notes

- Installing `postgres` via `mise` in WSL probably requires a couple of small tweaks:
  - `sudo apt install bison flex pkgconf`
    - https://github.com/smashedtoatoms/asdf-postgres/issues/94
  - `HOMEBREW_PREFIX="/tmp/disabled" mise i postgres`
    - https://github.com/smashedtoatoms/asdf-postgres/issues/99
