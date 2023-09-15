export ZSH="$HOME/.local/oh-my-zsh"
PATH="$HOME/.local/bin:$PATH"

# oh-my-zsh
if [[ ! -d $ZSH ]];then
    if [[ -f ~/.zshrc ]]; then
        mv ~/.zshrc ~/.zshrc.backup
    fi

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

plugins=(git npm pip python)
source $ZSH/oh-my-zsh.sh

# powerlevel10k
P10K_DIR="$HOME/.local/powerlevel10k"

if [[ ! -d $P10K_DIR ]];then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"

source ~/.config/powerlevel10k/p10k.zsh
source "$P10K_DIR/powerlevel10k.zsh-theme"

# nix
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then . "$HOME/.nix-profile/etc/profile.d/nix.sh"; fi

# zplug
ZPLUG_DIR="$HOME/.local/zplug"

if [[ ! -d $ZPLUG_DIR ]];then
    git clone --depth 1 https://github.com/b4b4r07/zplug "$ZPLUG_DIR"
fi

source "$ZPLUG_DIR/init.zsh"

zplug "mafredri/zsh-async", from:github, defer:0
zplug "lib/completion", from:oh-my-zsh
zplug "romkatv/powerlevel10k", as:theme, depth:1

if ! zplug check --verbose; then
    printf "Install zplug plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# alias
alias v="nvim"
alias ls="logo-ls"
alias lh="logo-ls -a"
alias l="logo-ls -l"

# neovims
configurations=(
    "HydraVim:h"
    "NvChad:c"
    "AstroVim:a"
)

for config_alias in "${configurations[@]}"; do
    IFS=":" read -r config_name config_alias <<< "$config_alias"
    alias "$config_alias"="NVIM_APPNAME=$config_name nvim"
    items+=("$config_name")
done

function nvims() {
    config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
    if [[ -z $config ]]; then
        echo "Nothing selected"
        return 0
    elif [[ $config == "default" ]]; then
        config=""
    fi
    NVIM_APPNAME=$config nvim "$@"
}

bindkey -s ^a "nvims\n"
