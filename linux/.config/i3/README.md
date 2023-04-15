Getting Started with i3wm
==========================

Installation
-------------
Install the **i3** [package group](https://www.archlinux.org/groups/x86_64/i3/).  
```
$ pacman -S i3-wm i3blocks i3lock i3status
```

The Basics
-----------
Choose a `$Mod` key, this can be the `Win` or `Alt` key.

### Basic default shortcuts
- Terminal: `Mod + Enter`
- Quit Window: `Mod + Shift + Q`
- Open Dmenu: `Mod + D`

### Tiling default shortcuts
- Open VERTICALLY: `Mod + V`
- Open HORIZONTALLY: `Mod + H`

### Moving b/w tiles
Move: `Mod + <Arrow Keys>` OR `Mod + j, k, l, ;`

### Switching window modes
- Stacking mode: `Mod + S`
- Tabbed mode: `Mod + W`
- Tiling mode: `Mod + E`

### Resize mode
- Enter resize mode: `Mod + R`
- Wider: `RIGHT arrow`
- Narrower: `LEFT arrow`
- Shorter: `UP arrow`
- Taller: `DOWN arrow`

### Moving windows
- Move to RIGHT: `Mod + Shift + RIGHT arrow`
- Move to LEFT: `Mod + Shift + LEFT arrow`
- Move to UP: `Mod + Shift + UP arrow`
- Move to DOWN: `Mod + Shift + DOWN arrow`

### Workspaces
- Switching b/w workspaces: `Mod + <WS_NUM>`
- Move window to workspace: `Mod + Shift + <WS_NUM>`

### Misc
- Full screen: `Mod + F`
- Move floating windows: `Mod + Mouse Left and Drag`

Config
-------
The config file is generated by the wizard on the first launch of i3 and saved at `~/.config/i3/config` OR `~/.i3/config`

The `config` file contains the definition of all the default key bindings and behaviours, so _tread carefully_.

The config file can be generated by running the following command:
```
$ i3-config-wizard
```

### Defining a keybinding

#### Syntax:
`bindsym <key-stroke> <behaviour>`

#### Example:
`bindsym $mod+shift+x exec i3lock`

> After making changes to the config file, i3 needs to be restarted for those changes to take effect. Use `Mod + Shift + R` to restart i3.

### Start apps with i3

#### Syntax:
`exec <app_name>`

#### Example:
`exec spotify`

### Wallpapers
Using `feh` package to set wallpaper

#### Syntax:
`$ feh bg-scale <path-to-img>`

#### Example:
`exec_always feh --bg-fill ~/Pictures/wall.png || feh --bg-fill ~/Pictures/wall.jpg`

> `exec_always` will always run the command, even on i3 restart, where as `exec` will only run when we first login to i3

### Variables in config file

#### Syntax:
`set $<var_name> "value"`

#### Example:
`set $workspace1 "1: Terminal"`

### Open windows in specific workspace
We need to find the window class for the window we want to force to open in a specific workspace. To do that we use `xprop` package.

#### Syntax:
`assign [class="<WM_CLASS>"] <workspace-reference>`

#### Example:
`assign [class="Firefox"] $workspace2`