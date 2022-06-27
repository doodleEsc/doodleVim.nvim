# DoodleVim
Fast Neovim Configuration.

![](https://cdn.jsdelivr.net/gh/doodleEsc/blog-images/20220627112917.png)

![](https://cdn.jsdelivr.net/gh/doodleEsc/blog-images/20220627104042.png)

## Required

* Neovim >= 0.7.0
* Python3
* tree-sitter
* git
* [fd](https://github.com/sharkdp/fd)
* [ripgrep](https://github.com/BurntSushi/ripgrep)

## Installation

1. clone the repo
    ```shell
    git clone https://github.com/doodleEsc/nvim.git ~/.config/nvim
    ```
2. run `nvim` and all the plugins will be installed automatically.

## Interact With System Clipboard

`Neovim` needs a `clipboard provider` to handle copy and paste, see `:help provider-clipboard`

doodleEsc provides a script to handle copying and pasting, Which works with
`system clipboard`, `tmux` and `ssh`

```
mv ~/.config/nvim/clipboard-provider /usr/local/bin/
```

Note:
* configuration in tmux
    ```
    set -s set-clipboard external
    bind Escape copy-mode                                                              
	bind -T copy-mode-vi v send-keys -X begin-selection                                
	bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'clipboard-provider copy' 
	bind p run "tmux set-buffer \"$(clipboard-provider paste)\"; tmux paste-buffer -p" 
    ```

* `xclip` and `X11-forwarding` needed in remote ssh

* your terminal need to support [OSC52](https://en.wikipedia.org/wiki/ANSI_escape_code#OSC_(Operating_System_Command)_sequences)

    | Terminal | OSC52 support |
    |----------|:-------------:|
    | [Alacritty](https://github.com/alacritty/alacritty) | **yes** |
    | [foot](https://codeberg.org/dnkl/foot) | **yes** |
    | [GNOME Terminal](https://github.com/GNOME/gnome-terminal) (and other VTE-based terminals) | [not yet](https://bugzilla.gnome.org/show_bug.cgi?id=795774) |
    | [hterm (Chromebook)](https://chromium.googlesource.com/apps/libapps/+/master/README.md) | [**yes**](https://chromium.googlesource.com/apps/libapps/+/master/nassh/doc/FAQ.md#Is-OSC-52-aka-clipboard-operations_supported) |
    | [iTerm2](https://iterm2.com/) | **yes** |
    | [kitty](https://github.com/kovidgoyal/kitty) | **yes** |
    | [Konsole](https://konsole.kde.org/) | [not yet](https://bugs.kde.org/show_bug.cgi?id=372116) |
    | [screen](https://www.gnu.org/software/screen/) | **yes** |
    | [st](https://st.suckless.org/) | **yes** (but needs to be enabled, see [here](https://git.suckless.org/st/commit/a2a704492b9f4d2408d180f7aeeacf4c789a1d67.html)) |
    | [Terminal.app](https://en.wikipedia.org/wiki/Terminal_(macOS)) | no, but see [workaround](https://github.com/roy2220/osc52pty) |
    | [tmux](https://github.com/tmux/tmux) | **yes** |
    | [Windows Terminal](https://github.com/microsoft/terminal) | **yes** |
    | [rxvt](http://rxvt.sourceforge.net/) | **yes** (to be confirmed) |
    | [urxvt](http://software.schmorp.de/pkg/rxvt-unicode.html) | **yes** (with a script, see [here](https://github.com/ojroques/vim-oscyank/issues/4)) |
    | [xterm.js](https://xtermjs.org/) (Hyper terminal) | [not yet](https://github.com/xtermjs/xterm.js/issues/3260) |
    | [wezterm](https://github.com/wez/wezterm) | [**yes**](https://wezfurlong.org/wezterm/escape-sequences.html#operating-system-command-sequences) |
