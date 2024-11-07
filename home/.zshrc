# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export QT_QPA_PLATFORMTHEME=qt5ct

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ------------------------ #
# ------ User Theme ------ #
# ------------------------ #
# Load custom theme
# source ~/.oh-my-zsh/themes/theme.zsh-theme
PROMPT=$'%{\e[0;95m%}%B┌─[%b%{\e[0m%}%{\e[1;33m%}%n%{\e[1;95m%}@%{\e[0m%}%{\e[0;32m%}%m%{\e[0;95m%}%B]%b%{\e[0m%} %b%{\e[0;95m%}%B(%b%{\e[1;33m%}%~%{\e[0;95m%}%B)%b%{\e[0m%}
%{\e[0;95m%}%B└─%B(%{\e[1;94m%}$%{\e[0;95m%}%B) <$(git_prompt_info)>%{\e[0m%}%b '
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b'


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  fzf
  extract
  # zsh-completions
  # zsh-autocomplete
  # zsh-autosuggestions
  # zsh-syntax-highlighting
  # zsh-history-substring-search
)
source $ZSH/oh-my-zsh.sh

# Optimized history settings
HISTFILE=~/.zsh_history
HISTSIZE=2500
SAVEHIST=2500
setopt appendhistory

# -- pnpm --
export PNPM_HOME="/home/softeng/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# -- pnpm end --

# -- nvm --
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# -- nvm end --

# bun completions
[ -s "/home/softeng/.bun/_bun" ] && source "/home/softeng/.bun/_bun"
# -- bun --
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# -- bun end --

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)
# Fuzzy search in history as you type
function fzf-history-widget {
  LBUFFER=$(history -n 1 | fzf --height 50% --layout=reverse --border --query="$LBUFFER" --prompt="History > ")
  zle redisplay
}
# Keybindings
bindkey -e  # Use emacs mode (default)
zle -N fzf-history-widget
# bindkey '^P' fzf-history-widget  # Bind Ctrl+P to trigger fzf history search


# ------------------------------------------ #
# ----------- User configuration ----------- #
# ------------------------------------------ #
# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"
# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Ignore commands that start with spaces and duplicates.
export HISTCONTROL=ignoreboth

# Don't add certain commands to the history file.
export HISTIGNORE="&:[bf]g:c:clear:history:exit:q:pwd:* --help"

# Use custom `less` colors for `man` pages.
export LESS_TERMCAP_md="$(
  tput bold 2>/dev/null
  tput setaf 2 2>/dev/null
)"
export LESS_TERMCAP_me="$(tput sgr0 2>/dev/null)"

# Make new shells get the history lines from all previous
# shells instead of the default "last window closed" history.
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# The following line to use case-sensitive completion.
CASE_SENSITIVE="false"
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="false"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="false"

# # Uncomment the following line if you want to change the command execution time
# # stamp shown in the history command output.
# # You can set one of the optional three formats:
# # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# # or set a custom format using the strftime function format specifications,
# # see 'man strftime' for details.
# # HIST_STAMPS="mm/dd/yyyy"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi


# ----------------------------- #
# -------- Set Aliases -------- #
# ----------------------------- #
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# Set-up icons for files/folders in terminal
alias l='eza -lh --icons=auto'  # Long list with icons
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'
alias ld='eza -lhD --icons=auto'  # Long list directories with icons
alias lt='eza --icons=auto --tree'  # List folder as tree with icons

# Handy change directory shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias mkdir='mkdir -p' # Always mkdir a path
alias open="xdg-open"
alias make="make -j$(nproc)"
alias ninja="ninja -j$(nproc)"
alias n="ninja"
alias c="clear" # Clear terminal
alias tb="nc termbin.com 9999"
# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"
# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# ------------------------- #
# -------- Plugins -------- #
# ------------------------- #
# Fish-like syntax highlighting and autosuggestions
source /home/softeng/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/softeng/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# Use history substring search
source /home/softeng/.oh-my-zsh/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# pkgfile "command not found" handler
source /usr/share/doc/pkgfile/command-not-found.zsh

# --------------------------------- #
# Zsh-autosuggestions configuration #
# --------------------------------- #
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_FZF=true

# Enable Wayland support for different applications
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  export WAYLAND=1
  export QT_QPA_PLATFORM='wayland;xcb'
  export GDK_BACKEND='wayland,x11'
  export MOZ_DBUS_REMOTE=1
  export MOZ_ENABLE_WAYLAND=1
  export _JAVA_AWT_WM_NONREPARENTING=1
  export BEMENU_BACKEND=wayland
  export CLUTTER_BACKEND=wayland
  export ECORE_EVAS_ENGINE=wayland_egl
  export ELM_ENGINE=wayland_egl
fi

export FZF_BASE=/usr/share/fzf


# ---------------------------- #
# Configuration for Arch Linux #
# ---------------------------- #
# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux
if ! grep -q "arch" /etc/os-release; then
  # Compilation flags
  export ARCHFLAGS="-arch $(uname -m)"
  # Detect the AUR helper (yay or paru)
  if pacman -Qi yay &>/dev/null; then
    aurhelper="yay"
  elif pacman -Qi paru &>/dev/null; then
    aurhelper="paru"
  fi
  # Arch aliases
  alias un='$aurhelper -Rns'  # Uninstall package
  alias up='$aurhelper -Syu'  # Update system/packages/AUR
  alias pl='$aurhelper -Qs'  # List installed packages
  alias pa='$aurhelper -Ss'  # List available packages
  alias pc='$aurhelper -Sc'  # Remove unused cache
  alias po='$aurhelper -Qtdq | $aurhelper -Rns -'  # Remove unused packages
  alias rmpkg="sudo pacman -Rsn"
  alias cleanch="sudo pacman -Scc"
  alias fixpacman="sudo rm /var/lib/pacman/db.lck"
  alias update="sudo pacman -Syu"
  # Cleanup orphaned packages
  alias cleanup="sudo pacman -Rsn $(pacman -Qtdq)"
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
fi

# ----------------------- #
# Configuration for NixOS #
# ----------------------- #
if ! grep -q "nix" /etc/os-release; then
  # NIXOS configs
fi
# Created by `pipx` on 2024-11-07 21:19:31
export PATH="$PATH:/home/softeng/.local/bin"
