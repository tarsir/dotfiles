# tarsir's dotfiles

These are my two most-used dotfiles for development on *nix/OSX systems along with any
requisite files that are basically just for easier organization.

## How to Use

Simply clone the repo, then run the `setup_symlinks.sh` script.

```bash
git clone https://github.com/tarsir/dotfiles.git
cd dotfiles
chmod a+x setup_symlinks.sh
./setup_symlinks.sh
```

It also takes a backup of the current version of any of these files that exist and
puts them in a directory called `backups` off of the repository root.

This might not work if you have your .bashrc and .vimrc housed somewhere other than
your user home (`~`). I could add an optional argument to the setup script, but
I'm lazy.

Enjoy!
