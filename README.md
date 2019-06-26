# dotfiles

```
                   -`                    jc@0x7b1
                  .o+`                   --------
                 `ooo/                   OS: Arch Linux x86_64
                `+oooo:                  Host: 20HQS0DN00 ThinkPad X1 Carbon 5th
               `+oooooo:                 Kernel: 5.1.14-arch1-1-ARCH
               -+oooooo+:                Uptime: 1 hour, 51 mins
             `/:-:++oooo+:               Packages: 854 (pacman)
            `/++++/+++++++:              Shell: zsh 5.7.1
           `/++++++++++++++:             Resolution: 1920x1080
          `/+++ooooooooooooo/`           WM: i3
         ./ooosssso++osssssso+`          Theme: Flat-Remix-GTK-Blue-Darkest-Solid-NoBorder [GTK2/3]
        .oossssso-````/ossssss+`         Icons: Papirus-Dark [GTK2/3]
       -osssssso.      :ssssssso.        Terminal: alacritty
      :osssssss/        osssso+++.       Terminal Font: xos4 Terminus
     /ossssssss/        +ssssooo/-       CPU: Intel i7-7500U (4) @ 3.500GHz
   `/ossssso+/:-        -:/+osssso+-     GPU: Intel HD Graphics 620
  `+sso+:-`                 `.-/+oso:    Memory: 2986MiB / 7739MiB
 `++:.                           `-/+/
 .`                                 `/
```

```
 dunst      > notification daemon
 git        > git config and aliases
 gpg        > gpg-agent config
 i3         > tiling window manager
 mutt       > email client
 nvim       > text editor config
 polybar    > status bar
 ranger     > file manager
 redshift   > screen color temperature
 rofi       > application launcher
 spells     > some automation scripts
 ssh        > ssh-agent service config
 tmux       > terminal multiplexer
 urxvt      > 256 color terminal and some extensions
 xmap       > some keybindings
 zsh        > oh-my-zsh plugins and themes
 ```

# Usage
```
git clone https://github.com/0x7b1/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow * # for a complete configuration
stow git # for a specific configuration
```

> Originaly based on https://github.com/aeolyus/dotfiles
