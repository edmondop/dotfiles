export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git aws zsh-fzf-history-search)
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
export EDITOR=nvim
neofetch

# -------------- dotfiles install ---------------
source /home/edmondo/dotfiles/.zshrc_imports

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/edmondo/.sdkman"
[[ -s "/home/edmondo/.sdkman/bin/sdkman-init.sh" ]] && source "/home/edmondo/.sdkman/bin/sdkman-init.sh"
