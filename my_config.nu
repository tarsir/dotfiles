alias core-ls = ls
def ls [path?] {
  if $path == null {
    eza -G
  } else {
    eza -G $path
  }
}

alias vim = nvim
alias g.tree = git log --graph --pretty=oneline --abbrev-commit
# alias g.log = "git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(bold white)— %an%C(reset)%C(bold yellow)%d%C(reset)' --abbrev-commit --date=relative"
alias g.co = git checkout
alias g.s = git status
alias g.d = git diff
alias g.b = git branch -v --sort=committerdate
alias g.p = git pull -r
alias g.c = git commit -v
alias g.cv = git commit --no-verify -v
alias g.pf = git push --force-with-lease
use ~/.cache/starship/init.nu

# ASDF setup
$env.ASDF_DIR = ($env.HOME | path join '.asdf')

source "/home/stephen/.asdf/asdf.nu"
