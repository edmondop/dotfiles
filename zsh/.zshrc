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
export EDITOR=nvim
fastfetch

# -------------- dotfiles install ---------------
if [[ $(hostname) == edmondo-Laptop-13-AMD* ]]; then
  source $HOME/Development/dotfiles/.zshrc_imports
else
  source $HOME/dotfiles/.zshrc_imports
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/edmondo/.sdkman"
[[ -s "/home/edmondo/.sdkman/bin/sdkman-init.sh" ]] && source "/home/edmondo/.sdkman/bin/sdkman-init.sh"
