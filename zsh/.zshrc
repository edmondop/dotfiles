export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi


#------------------------------------------------------------
# ZSH Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# ZSH custom
alias ls=colorls
# tmuxifier
alias vim=nvim
export EDITOR=vim

neofetch

# -------------- dotfiles install ---------------
source /Users/edmondoporcu/Development/dotfiles/zsh/shell/ec2-devenv.sh
source /Users/edmondoporcu/Development/dotfiles/zsh/shell/go.sh
source /Users/edmondoporcu/Development/dotfiles/zsh/shell/node.sh
source /Users/edmondoporcu/Development/dotfiles/zsh/shell/python.sh
source /Users/edmondoporcu/Development/dotfiles/zsh/shell/ruby.sh
source /Users/edmondoporcu/Development/dotfiles/zsh/shell/sdkman.sh
source /Users/edmondoporcu/Development/dotfiles/zsh/shell/starship.sh
source /Users/edmondoporcu/Development/dotfiles/zsh/shell/tmux.sh

# -------------- dotfiles install ---------------
