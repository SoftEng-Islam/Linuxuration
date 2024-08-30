# Path to your Oh My Zsh installation
ZSH=~/.oh-my-zsh/

# Load Oh My Zsh framework
source $ZSH/oh-my-zsh.sh

# Load custom theme
source ~/.oh-my-zsh/themes/softeng.zsh-theme

# Load fzf with Zsh integration
source <(fzf --zsh)

# Uncomment to use Powerlevel10k configuration if available
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Plugin and feature setup
plugins=(
    git
    fzf
    zsh-autocomplete
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
)

# Manual sourcing for plugins not handled by Oh My Zsh
source ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Zsh-autosuggestions configuration
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_FZF=true

# Keybindings
bindkey -e  # Use emacs mode (default)
zle -N fzf-history-widget
bindkey '^P' fzf-history-widget  # Bind Ctrl+P to trigger fzf history search

# Detect the AUR helper (yay or paru)
if pacman -Qi yay &>/dev/null; then
    aurhelper="yay"
elif pacman -Qi paru &>/dev/null; then
    aurhelper="paru"
fi

# Aliases for common commands
alias c='clear'  # Clear terminal
alias l='eza -lh --icons=auto'  # Long list with icons
alias ls='eza -1 --icons=auto'  # Short list with icons
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'  # Long list all with icons
alias ld='eza -lhD --icons=auto'  # Long list directories with icons
alias lt='eza --icons=auto --tree'  # List folder as tree with icons
alias un='$aurhelper -Rns'  # Uninstall package
alias up='$aurhelper -Syu'  # Update system/packages/AUR
alias pl='$aurhelper -Qs'  # List installed packages
alias pa='$aurhelper -Ss'  # List available packages
alias pc='$aurhelper -Sc'  # Remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -'  # Remove unused packages
alias code='com.visualstudio.code . &'

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
HISTSIZE=1500
SAVEHIST=1500
setopt appendhistory
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST

# Fuzzy search in history as you type
function fzf-history-widget {
    LBUFFER=$(history -n 1 | fzf --height 40% --layout=reverse --border --query="$LBUFFER" --prompt="History > ")
    zle redisplay
}

# Optimize completion
# Define the base name for zcompdump files
zcompdump_base="${HOME}/.zcompdump"

# Find the zcompdump file without a corresponding .zwc file
zcompdump=$(ls ${zcompdump_base}* 2>/dev/null | grep -v '\.zwc$' | head -n 1)

# If no suitable zcompdump file is found, create a new one
if [[ -z $zcompdump ]]; then
    zcompdump="${HOME}/.zcompdump-new"
fi

# Compile the zcompdump file
if [[ ! -s $zcompdump || $ZDOTDIR/.zcompdump -nt $zcompdump ]]; then
    zcompile "$zcompdump"
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

# User configuration
export HISTCONTROL=ignoreboth
export HISTIGNORE="&:[bf]g:c:clear:history:exit:q:pwd:* --help"
export LESS_TERMCAP_md="$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)"
export LESS_TERMCAP_me="$(tput sgr0 2> /dev/null)"
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
alias make="make -j$(nproc)"
alias ninja="ninja -j$(nproc)"
alias n="ninja"
alias rmpkg="sudo pacman -Rsn"
alias cleanch="sudo pacman -Scc"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias update="sudo pacman -Syu"
alias apt="man pacman"
alias apt-get="man pacman"
alias please="sudo"
alias tb="nc termbin.com 9999"
alias cleanup="sudo pacman -Rsn $(pacman -Qtdq)"
alias jctl="journalctl -p 3 -xb"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Uncomment the following line if pasting URLs and other text is messed up
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS="true"
