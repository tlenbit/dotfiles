# if not running interactively, don't do anything:
[[ $- != *i* ]] && return

# zsh
export ZSH=/home/jc/.oh-my-zsh
ZSH_THEME="cdimascio-lambda"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# z
. $HOME/sw/z/z.sh

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# go
export GOROOT="/usr/local/go"
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/Documents/deps/go
export PATH=$PATH:$GOPATH/bin

# Processing
export PATH=$PATH:$HOME/sw/processing-3.3.7

# aliases
alias c='xclip -selection clipboard'
alias showifi='nmcli dev wifi'
alias glances='sudo docker run -v /var/run/docker.sock:/var/run/docker.sock:ro --pid host -it docker.io/nicolargo/glances'
# alias rr='ranger --choosedir=$HOME/rangerdir; LASTDIR=`cat $HOME/rangerdir`; cd "$LASTDIR"'
# alias t='thunar'

# image resize.
# eg. $ smartresize inputfile.png 300 outputdir/ # WARNING: if ./ will replace current image
# based on: https://www.smashingmagazine.com/2015/06/efficient-image-resizing-with-imagemagick/
smartresize() {
   mogrify -path $3 -filter Triangle -define filter:support=2 -thumbnail $2 -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB $1
}

# docker
dstopc() { sudo docker stop $(sudo docker ps -a -q); } # Stop all containers
drmc() { sudo docker rm $(sudo docker ps -a -q); } # Remove all containers
dlsc() { sudo docker ps -a; } # List all containers
dstart() { systemctl start docker; }
dstatus() { systemctl status docker; }
dstop() { systemctl stop docker; }

# python
alias p3='python3'
