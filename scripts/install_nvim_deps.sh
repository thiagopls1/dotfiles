#!/bin/bash

# declare -A osInfo;
# osInfo[/etc/redhat-release]=yum
# osInfo[/etc/arch-release]=pacman
# osInfo[/etc/gentoo-release]=emerge
# osInfo[/etc/SuSE-release]=zypp
# osInfo[/etc/debian_version]=apt-get
# osInfo[/etc/alpine-release]=apk

# package_manager=''
# for f in ${!osInfo[@]}
# do
#     if [[ -f $f ]];then
#         echo Package manager: ${osInfo[$f]}
#     fi
# done

if ! command -v nvim 2>&1 >/dev/null
then
  echo "nvim not could not be found. Installing..."
	sudo pacman -S nvim
fi


# Install VIM Plug
echo "Installing Vim Plug..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo "Done."

# Telescope dependences
echo "Installing Telescope dependencies..."
sudo pacman -S ripgrep

# Node dependencies
if ! command -v node 2>&1 >/dev/null
then
  echo "node could not be found. Installing..."
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
	nvm install node
	nvm use node
fi

echo "Installing lsp dependencies..."
npm install -g \
	tree-sitter \
	@angular/language-server \
	cssmodules-language-server \
	typescript \
	typescript-language-server \
	vscode-langservers-extracted \
	bash-language-server \

sudo pacman -S lua-language-server

if ! command -v gem 2>&1 >/dev/null
then
  echo "gem could not be found. Installing..."
	sudo pacman -S ruby
	gem install ruby-lsp
fi
