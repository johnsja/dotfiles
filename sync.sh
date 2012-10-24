#!/bin/bash
cd "$(dirname "$0")"
git pull
function doIt() {
  rsync --exclude ".git/" --exclude ".DS_Store" --exclude "sync.sh" --exclude "install-deps.sh" --exclude ".brew" --exclude ".osx" --exclude "readme.md" --exclude "zsh-theme" -av . ~
  rsync -av zsh-theme/* ~/.oh-my-zsh/themes
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
  fi
fi
unset doIt

# source ~/.zshrc