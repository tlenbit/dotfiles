# if not running interactively, don't do anything:
[[ $- != *i* ]] && return

# ZSH
export ZSH=/home/jc/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# linuxbrew
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

# z
. /home/jc/.linuxbrew/etc/profile.d/z.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# go
export GOROOT="/usr/local/go"
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/Documents/code/go
export PATH=$PATH:$GOPATH/bin

# aliases
# alias sx='sxiv -t *'
alias c='xclip -selection clipboard'
alias showifi='nmcli dev wifi'
alias rr='ranger --choosedir=$HOME/rangerdir; LASTDIR=`cat $HOME/rangerdir`; cd "$LASTDIR"'
alias glances='sudo docker run -v /var/run/docker.sock:/var/run/docker.sock:ro --pid host -it docker.io/nicolargo/glances'

# https://www.smashingmagazine.com/2015/06/efficient-image-resizing-with-imagemagick/
# smartresize inputfile.png 300 outputdir/
smartresize() {
   mogrify -path $3 -filter Triangle -define filter:support=2 -thumbnail $2 -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB $1
}
