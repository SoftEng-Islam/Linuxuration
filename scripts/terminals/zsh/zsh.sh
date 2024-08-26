#!/bin/bash
# ZSH and oh-my-zsh
# Install ZSH & oh-my-zsh
sudo pacman -S --noconfirm zsh fzf zsh-syntax-highlighting zsh-autosuggestions zsh-theme-powerlevel10k zsh-completions zsh-doc zsh-history-substring-search
git clone https://github.com/marlonrichert/zsh-autocomplete ~/.oh-my-zsh/custom/plugins/zsh-autocomplete
cd ~/.oh-my-zsh/custom/plugins/ && git clone https://github.com/zsh-users/zsh-history-substring-search.git

sudo cp -r /usr/share/zsh/plugins/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/
sudo cp -r /usr/share/zsh/plugins/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/
#sudo cp -r /usr/share/zsh/plugins/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/

sudo ln -s /usr/share/zsh/plugins/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
sudo ln -s /usr/share/zsh/plugins/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
#sudo ln -s /usr/share/zsh/plugins/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search

chsh -s /bin/zsh
source ~/.zshrc
