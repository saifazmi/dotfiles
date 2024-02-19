Terminal Commands and Hacks
===========================

### Terminal Clock

Puts a console clock in top right corner. You can add other infos such as cpu and mem usage too.

```bash
$ while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done & 
```

**// terminate:** fg ^c  
**// source:** https://www.reddit.com/r/commandline/comments/3eat0f/found_this_console_clock_in_my_collection/

### Tmux Colours
Print a list of colours for tmux
```bash
$ for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
  done
```

**// source:** https://superuser.com/questions/285381/how-does-the-tmux-color-palette-work

### Check if a usb is the same size as it claims to be
How to test that a USB stick is actually the size it claims: 
```bash
$ dd if=/dev/random bs=1M count=[size of disk in MB] of=randomfile
$ dd if=randomfile of=/dev/usbstick
$ dd if=randomfile | sha256
$ dd if=/dev/usbstick | sha256
```
If the hashes match, the disk is the size claimed.

### Fix corrupt ZSH history file
```bash
$ mv .zsh_history .zsh_history_bad
$ strings .zsh_history_bad > .zsh_history
$ fc -R .zsh_history
```
**// source:** https://superuser.com/questions/957913/how-to-fix-and-recover-a-corrupt-history-file-in-zsh#957924

### Print terminal colours
```bash
for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
```
**// source:** https://github.com/romkatv/powerlevel10k/blob/17cd9e354a283edeb657d340e1bbc0a30de5f967/README.md?plain=1#L1330
