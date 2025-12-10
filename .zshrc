# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

autoload -U colors && colors
setopt PROMPT_SUBST

# Plugins you want
plugins=(
  git
  z
  sudo
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Preferred editor
export EDITOR="nano"

# Disable terminal bell
setopt NO_BEEP

# History settings (better defaults)
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

# Automatically correct small typos
setopt CORRECT

# Enable command auto-completion
autoload -Uz compinit
compinit

# Enable colors
autoload -U colors && colors
setopt PROMPT_SUBST

# Aliases
alias cls="clear"
alias ll="ls -lah"
alias gbtop= "btop"
# Prompt theme is loaded from greyred.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$HOME/.local/bin:$PATH"


eval "$(starship init zsh)"

echo "alias fastfetch='printf \"\n\"; fastfetch'" >> ~/.zshrc
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
export PATH="$HOME/.local/bin:$PATH"
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
alias fastfetch='printf "
"; fastfetch'
