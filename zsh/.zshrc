[[ -f ~/.profile ]] && . ~/.profile

# zsh
export ZSH="/home/jc/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# z
. /usr/share/z/z.sh

export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="chromium"

# aliases
alias c='xclip -selection clipboard'
alias e=$EDITOR

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --preview-window right:70%'

# ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
