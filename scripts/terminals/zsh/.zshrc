# Path to your oh-my-zsh installation.
ZSH=~/.oh-my-zsh/

# Load Oh My Zsh framework
source $ZSH/oh-my-zsh.sh

# Load custom theme
source ~/.oh-my-zsh/themes/softeng.zsh-theme

# Load zsh-autocomplete plugin
source ~/.oh-my-zsh/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# List of plugins to load with Oh My Zsh
plugins=(
    fzf
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Zsh-autosuggestions configuration
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_FZF=true

# Bind keys in emacs mode (default)
bindkey -e

# Bind Ctrl+P to trigger fzf history search
zle -N fzf-history-widget
bindkey '^P' fzf-history-widget

# Detect the AUR helper (yay or paru)
if pacman -Qi yay &>/dev/null; then
    aurhelper="yay"
elif pacman -Qi paru &>/dev/null; then
    aurhelper="paru"
fi

# Aliases for common commands
alias c='clear' # Clear terminal
alias l='eza -lh --icons=auto' # Long list with icons
alias ls='eza -1 --icons=auto' # Short list with icons
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # Long list all with icons
alias ld='eza -lhD --icons=auto' # Long list directories with icons
alias lt='eza --icons=auto --tree' # List folder as tree with icons
alias un='$aurhelper -Rns' # Uninstall package
alias up='$aurhelper -Syu' # Update system/packages/AUR
alias pl='$aurhelper -Qs' # List installed packages
alias pa='$aurhelper -Ss' # List available packages
alias pc='$aurhelper -Sc' # Remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # Remove unused packages
alias vc='code' # Open Visual Studio Code

# Handy change directory shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Always mkdir a path
alias mkdir='mkdir -p'

# Optimized history settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt HIST_IGNORE_ALL_DUPS

# Fuzzy search in history as you type
function fzf-history-widget {
    LBUFFER=$(history -n 1 | fzf --height 40% --layout=reverse --border --query="$LBUFFER" --prompt="History > ")
    zle redisplay
}

# Optimize completion
zcompdump="${HOME}/.zcompdump-softeng-5.9"
if [[ ! -s $zcompdump || $ZDOTDIR/.zcompdump -nt $zcompdump ]]; then
    zcompile "${zcompdump}"
fi

# Command not found handler: suggest packages containing the command
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
    if (( ${#entries[@]} )) ; then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}" ; do
            local fields=( ${(0)entry} )
            if [[ "$pkg" != "${fields[2]}" ]] ; then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}

# Install packages with Arch and AUR helpers
function in {
    local -a inPkg=("$@")
    local -a arch=()
    local -a aur=()

    for pkg in "${inPkg[@]}"; do
        if pacman -Si "${pkg}" &>/dev/null ; then
            arch+=("${pkg}")
        else
            aur+=("${pkg}")
        fi
    done

    if [[ ${#arch[@]} -gt 0 ]]; then
        sudo pacman -S "${arch[@]}"
    fi

    if [[ ${#aur[@]} -gt 0 ]]; then
        ${aurhelper} -S "${aur[@]}"
    fi
}

# Uncomment to use Powerlevel10k configuration if available
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load fzf with Zsh integration
source <(fzf --zsh)
