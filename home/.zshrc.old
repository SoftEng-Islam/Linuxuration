# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(
    git
    extract
    fzf
    zsh-autocomplete
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
)


source $ZSH/oh-my-zsh.sh

# User configuration
source ~/.oh-my-zsh/themes/softeng.zsh-theme

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Ignore commands that start with spaces and duplicates.

export HISTCONTROL=ignoreboth

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Don't add certain commands to the history file.

export HISTIGNORE="&:[bf]g:c:clear:history:exit:q:pwd:* --help"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Use custom `less` colors for `man` pages.

export LESS_TERMCAP_md="$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)"
export LESS_TERMCAP_me="$(tput sgr0 2> /dev/null)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Make new shells get the history lines from all previous
# shells instead of the default "last window closed" history.

export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
#alias open="xdg-open"
alias make="make -j`nproc`"
alias ninja="ninja -j`nproc`"
alias n="ninja"
alias c="clear"
alias rmpkg="sudo pacman -Rsn"
alias cleanch="sudo pacman -Scc"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias update="sudo pacman -Syu"

# Help people new to Arch
alias apt="man pacman"
alias apt-get="man pacman"
alias please="sudo"
alias tb="nc termbin.com 9999"

# Cleanup orphaned packages
alias cleanup="sudo pacman -Rsn $(pacman -Qtdq)"

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# source ~/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Fish-like syntax highlighting and autosuggestions
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Use history substring search
# source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh




# pkgfile "command not found" handler
source /usr/share/doc/pkgfile/command-not-found.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export FZF_BASE=/usr/share/fzf


# # If you come from bash you might have to change your $PATH.
# # export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# # Path to your Oh My Zsh installation.
# export ZSH="$HOME/.oh-my-zsh"

# # Set name of the theme to load --- if set to "random", it will
# # load a random theme each time Oh My Zsh is loaded, in which case,
# # to know which specific one was loaded, run: echo $RANDOM_THEME
# # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="softeng"
# # Load custom theme
# # source ~/.oh-my-zsh/themes/softeng.zsh-theme

# # Set list of themes to pick from when loading at random
# # Setting this variable when ZSH_THEME=random will cause zsh to load
# # a theme from this variable instead of looking in $ZSH/themes/
# # If set to an empty array, this variable will have no effect.
# # ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# # Uncomment the following line to use case-sensitive completion.
# # CASE_SENSITIVE="true"

# # Uncomment the following line to use hyphen-insensitive completion.
# # Case-sensitive completion must be off. _ and - will be interchangeable.
# # HYPHEN_INSENSITIVE="true"

# # Uncomment one of the following lines to change the auto-update behavior
# # zstyle ':omz:update' mode disabled  # disable automatic updates
# # zstyle ':omz:update' mode auto      # update automatically without asking
# # zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# # Uncomment the following line to change how often to auto-update (in days).
# # zstyle ':omz:update' frequency 13

# # Uncomment the following line if pasting URLs and other text is messed up.
# # DISABLE_MAGIC_FUNCTIONS="true"

# # Uncomment the following line to disable colors in ls.
# # DISABLE_LS_COLORS="true"

# # Uncomment the following line to disable auto-setting terminal title.
# # DISABLE_AUTO_TITLE="true"

# # Uncomment the following line to enable command auto-correction.
# # ENABLE_CORRECTION="true"

# # Uncomment the following line to display red dots whilst waiting for completion.
# # You can also set it to another string to have that shown instead of the default red dots.
# # e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# # Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# # COMPLETION_WAITING_DOTS="true"

# # Uncomment the following line if you want to disable marking untracked files
# # under VCS as dirty. This makes repository status check for large repositories
# # much, much faster.
# # DISABLE_UNTRACKED_FILES_DIRTY="true"

# # Uncomment the following line if you want to change the command execution time
# # stamp shown in the history command output.
# # You can set one of the optional three formats:
# # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# # or set a custom format using the strftime function format specifications,
# # see 'man strftime' for details.
# # HIST_STAMPS="mm/dd/yyyy"

# # Would you like to use another custom folder than $ZSH/custom?
# # ZSH_CUSTOM=/path/to/new-custom-folder

# # Which plugins would you like to load?
# # Standard plugins can be found in $ZSH/plugins/
# # Custom plugins may be added to $ZSH_CUSTOM/plugins/
# # Example format: plugins=(rails git textmate ruby lighthouse)
# # Add wisely, as too many plugins slow down shell startup.
# plugins=(
#     git
#     extract
#     fzf
#     zsh-autocomplete
#     zsh-autosuggestions
#     zsh-syntax-highlighting
#     zsh-history-substring-search
# )

# source $ZSH/oh-my-zsh.sh

# # User configuration

# # export MANPATH="/usr/local/man:$MANPATH"

# # You may need to manually set your language environment
# # export LANG=en_US.UTF-8

# # Preferred editor for local and remote sessions
# # if [[ -n $SSH_CONNECTION ]]; then
# #   export EDITOR='vim'
# # else
# #   export EDITOR='nvim'
# # fi

# # Compilation flags
# # export ARCHFLAGS="-arch $(uname -m)"

# # Set personal aliases, overriding those provided by Oh My Zsh libs,
# # plugins, and themes. Aliases can be placed here, though Oh My Zsh
# # users are encouraged to define aliases within a top-level file in
# # the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# # - $ZSH_CUSTOM/aliases.zsh
# # - $ZSH_CUSTOM/macos.zsh
# # For a full list of active aliases, run `alias`.
# #
# # Example aliases
# # alias zshconfig="mate ~/.zshrc"
# # alias ohmyzsh="mate ~/.oh-my-zsh"
# #set -x

# # Uncomment to use Powerlevel10k configuration if available
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# # Manual sourcing for plugins not handled by Oh My Zsh
# #source ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# #source ~/.oh-my-zsh/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# #source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# #source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# # Detect the AUR helper (yay or paru)
# # if pacman -Qi yay &>/dev/null; then
# #     aurhelper="yay"
# # elif pacman -Qi paru &>/dev/null; then
# #     aurhelper="paru"
# # fi

# # Aliases for common commands
# alias c='clear'  # Clear terminal
# alias l='eza -lh --icons=auto'  # Long list with icons
# alias ls='eza -1 --icons=auto'  # Short list with icons
# alias ll='eza -lha --icons=auto --sort=name --group-directories-first'  # Long list all with icons
# alias ld='eza -lhD --icons=auto'  # Long list directories with icons
# alias lt='eza --icons=auto --tree'  # List folder as tree with icons
# alias un='$aurhelper -Rns'  # Uninstall package
# alias up='$aurhelper -Syu'  # Update system/packages/AUR
# alias pl='$aurhelper -Qs'  # List installed packages
# alias pa='$aurhelper -Ss'  # List available packages
# alias pc='$aurhelper -Sc'  # Remove unused cache
# alias po='$aurhelper -Qtdq | $aurhelper -Rns -'  # Remove unused packages

# # Handy change directory shortcuts
# alias ..='cd ..'
# alias ...='cd ../..'
# alias .3='cd ../../..'
# alias .4='cd ../../../..'
# alias .5='cd ../../../../..'

# # Always mkdir a path
# alias mkdir='mkdir -p'

# # Zsh-autosuggestions configuration
# ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# ZSH_AUTOSUGGEST_USE_FZF=true

# # Optimized history settings
# HISTFILE=~/.zsh_history
# HISTSIZE=1500
# SAVEHIST=1500

# # Load fzf with Zsh integration
# source <(fzf --zsh)

# # Fuzzy search in history as you type
# function fzf-history-widget {
#     LBUFFER=$(history -n 1 | fzf --height 50% --layout=reverse --border --query="$LBUFFER" --prompt="History > ")
#     zle redisplay
# }

# # Keybindings
# bindkey -e  # Use emacs mode (default)
# zle -N fzf-history-widget
# bindkey '^P' fzf-history-widget  # Bind Ctrl+P to trigger fzf history search

# # Optimize completion
# # Define the base name for zcompdump files
# # zcompdump_base="${HOME}/.zcompdump"
# # # Find the zcompdump file without a corresponding .zwc file
# # zcompdump=$(ls ${zcompdump_base}* 2>/dev/null | grep -v '\.zwc$' | head -n 1)
# # # If no suitable zcompdump file is found, create a new one
# # if [[ -z $zcompdump ]]; then
# #     zcompdump="${HOME}/.zcompdump-new"
# # fi
# # # Compile the zcompdump file
# # if [[ ! -s $zcompdump || $ZDOTDIR/.zcompdump -nt $zcompdump ]]; then
# #     zcompile "$zcompdump"
# # fi

# # Command not found handler: suggest packages containing the command
# function command_not_found_handler {
#     local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
#     printf 'zsh: command not found: %s\n' "$1"
#     local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
#     if (( ${#entries[@]} )) ; then
#         printf "${bright}$1${reset} may be found in the following packages:\n"
#         local pkg
#         for entry in "${entries[@]}" ; do
#             local fields=( ${(0)entry} )
#             if [[ "$pkg" != "${fields[2]}" ]] ; then
#                 printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
#             fi
#             printf '    /%s\n' "${fields[4]}"
#             pkg="${fields[2]}"
#         done
#     fi
#     return 127
# }

# # Install packages with Arch and AUR helpers
# function in {
#     local -a inPkg=("$@")
#     local -a arch=()
#     local -a aur=()
#     for pkg in "${inPkg[@]}"; do
#         if pacman -Si "${pkg}" &>/dev/null ; then
#             arch+=("${pkg}")
#         else
#             aur+=("${pkg}")
#         fi
#     done
#     if [[ ${#arch[@]} -gt 0 ]]; then
#         sudo pacman -S "${arch[@]}"
#     fi
#     if [[ ${#aur[@]} -gt 0 ]]; then
#         ${aurhelper} -S "${aur[@]}"
#     fi
# }

# # User configuration
# # export HISTCONTROL=ignoreboth
# # export HISTIGNORE="&:[bf]g:c:clear:history:exit:q:pwd:* --help"
# # export LESS_TERMCAP_md="$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)"
# # export LESS_TERMCAP_me="$(tput sgr0 2> /dev/null)"
# # export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# # alias make="make -j$(nproc)"
# # alias ninja="ninja -j$(nproc)"
# # alias n="ninja"
# # alias rmpkg="sudo pacman -Rsn"
# # alias cleanch="sudo pacman -Scc"
# # alias fixpacman="sudo rm /var/lib/pacman/db.lck"
# # alias update="sudo pacman -Syu"
# # alias apt="man pacman"
# # alias apt-get="man pacman"
# # alias please="sudo"
# # alias tb="nc termbin.com 9999"
# # alias cleanup="sudo pacman -Rsn $(pacman -Qtdq)"
# # alias jctl="journalctl -p 3 -xb"
# # alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# # Uncomment the following line if pasting URLs and other text is messed up
# # DISABLE_MAGIC_FUNCTIONS="true"

# # Uncomment the following line to enable command auto-correction
# # ENABLE_CORRECTION="true"

# # Uncomment the following line to display red dots whilst waiting for completion
# #COMPLETION_WAITING_DOTS="true"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/softeng/.bun/_bun" ] && source "/home/softeng/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
