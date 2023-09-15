# Dotfiles

## Pacman
```sh
pacman -S git neovim curl unzip ripgrep neofetch btop mangohud npm python python-pip 
```

## NPM
```sh
npm install -g live-server
```

## Install
```sh
git clone git@github.com:Diogo-ss/dotfiles.git
cd dotfiles
mv * ~/.config
ln -s ~/.config/zsh/.zshrc ~/.zshrc
```

### Nvims
```sh
git clone https://github.com/NvChad/NvChad ~/.config/NvChad --depth 1
git clone https://github.com/HydraVim/HydraVim ~/.config/HydraVim --depth 1
git clone https://github.com/AstroNvim/AstroNvim ~/.config/AstroVim --depth 1
```
