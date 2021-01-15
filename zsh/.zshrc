[[ -f ~/.profile ]] && . ~/.profile

# zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH="/usr/share/oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# z
. /usr/share/z/z.sh

export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="chromium"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS='--height 50% --preview-window bottom:80% --preview "bat --style=numbers --color=always {} | head -500"'
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --preview-window right:70% --color "fg+:#ffffff,fg:#808e9b"'

export PATH="$HOME/.cargo/bin:$PATH"
# export PATH="$HOME/.local/bin:$PATH"

# ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

function fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | 
  fzf --height 50% --preview-window bottom:80% \
    --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' \
    --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

function _ranger_here() {
    ranger --choosedir=$HOME/.rangerdir < $TTY
    LASTDIR=`cat $HOME/.rangerdir`
    cd "$LASTDIR"
    zle reset-prompt
}

function _rofi_filebrowser_here() {
    $HOME/.config/rofi/bin/file-browser.sh
    zle reset-prompt
}

function _rofi_find_here() {
    search=$(rofi -dmenu -p "Search" -width "20%")

    if [ -n "$search" ];then
      fif "$search"
    fi

    zle reset-prompt
}

unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

zle -N _ranger_here
bindkey '^O' _ranger_here

zle -N _rofi_filebrowser_here
bindkey '^S' _rofi_filebrowser_here

zle -N _rofi_find_here
bindkey '^F' _rofi_find_here


export KEYTIMEOUT=1
bindkey -rpM viins '^['
bindkey -rpM vicmd '^['

# aliases
alias c='xclip -selection clipboard'
alias e=$EDITOR
alias h=hexyl

alias ls='exa' # ls
alias l='exa -lbF --git' # list, size, type, git
alias ll='exa --tree --level=2 --long --classify --header --git' # long list
alias lS='exa -1' # one column, just names

alias g=gitui
alias f=fif