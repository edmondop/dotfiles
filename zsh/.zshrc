export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git aws)
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi


#------------------------------------------------------------
# ZSH custom
alias ls=colorls
alias vim=nvim
export EDITOR=vim

neofetch
# -------------- dotfiles install ---------------
source /Users/edmondoporcu/Development/dotfiles/.zshrc_imports
