#!/usr/bin/bash

if [ -z $(which git 2> /dev/null)]; then
	echo "ERROR: Git is not installed."
	exit 1
fi

USER_REPO="thiagopls1/dotfiles"
REPO_URL="https://github.com/$USER_REPO.git"
git clone --bare $REPO_URL $HOME/.dotfiles
# define config alias locally since the dotfiles
# aren't installed on the system yet
echo "Creating alias for git dotfiles..."
git config --global alias.df '!git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
echo "Done. Alias is set as 'git dotfiles'"

# Checkout dotfiles from repo
git df checkout

# Check if `git dotfiles checkout` executed without errors
if [ $? = 0 ]; then
	echo "Checked out dotfiles from git@github.com:$USER_REPO.git";
else
	echo "Moving existing dotfiles to ~/.dotfiles-backup"
	# create a directory to backup existing dotfiles to
	mkdir -p $HOME/.dotfiles-backup
	mv $HOME/.dotfiles $HOME/.dotfiles-backup;
fi

git df checkout
git df config status.showUntrackedFiles no
