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

NODE_PACKAGES=(
	
)
PACMAN_PACKAGES=(
	"tree-sitter"
	"tree-sitter-cli"
	"ripgrep"
	"ruby-lsp"
	"bash-language-server"
	"lua-language-server"
	"yaml-language-server"
	"typescript-language-server"
	"pyright"
	"rust-analyzer"
	"ccls"
)

if [ -z $(which nvim 2>/dev/null) ]; then
	read -p "nvim not could not be found. Install? [Y/n] " USER_CONFIRM
	PACMAN_PACKAGES+=("nvim")
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
if [ -z which node 2> /dev/null ]; then
	read -p "node not could not be found. Install? [Y/n] " USER_CONFIRM
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

if [ -z which gem 2> /dev/null ]; then
	read -p "gem not could not be found. Install? [Y/n] " USER_CONFIRM
	sudo pacman -S ruby
	gem install ruby-lsp
fi
