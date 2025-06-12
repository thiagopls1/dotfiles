#!/usr/bin/env bash
export USER_REPO = "thiagopls1/dotfiles"
git clone --bare git@github.com:$USER_REPO.git $HOME/.dotfiles
# define config alias locally since the dotfiles
# aren't installed on the system yet
echo "Creating alias for git dotfiles..."
git config --global alias.dotfiles '!git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'
echo "Done. Alias is set as 'git dotfiles'"

# create a directory to backup existing dotfiles to
mkdir -p .dotfiles-backup
git dotfiles checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles from git@github.com:$USER_REPO.git";
  else
    echo "Moving existing dotfiles to ~/.dotfiles-backup";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi
# checkout dotfiles from repo
git dotfiles checkout
git dotfiles config status.showUntrackedFiles no
