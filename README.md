# dotfiles

![Screenshot](_images/2020-08-03_130926.png)

```
alacritty
conky
dunst
firefox
fltrdr
git
gsimplecal
gtk
i3
mpd
mpv
ncmpcpp
networkmanager
nvim
picom
polybar
pulseaudio
qt
ranger
ripgrep
rofi
scripts
sublime-text
sxiv
thunar
timidity
vlc
vscode
webdav
x
xdg
zathura
zsh
```

# Usage
```
git clone https://github.com/0x7b1/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow * -t $HOME # for a complete configuration
stow git -t $HOME # for a specific configuration
stow -v -R -t $HOME vim
```

> Originally based on https://github.com/aeolyus/dotfiles
