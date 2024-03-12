mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

load-env {
  "FZF_DEFAULT_COMMAND": "rg --files",
  "FLYCTL_INSTALL": "/home/stephen/.fly",
  "LLVM_INSTALL_PATH": "/home/stephen/local/llvm16-release"
}
