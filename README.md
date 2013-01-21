macvim-skim
===========

Tools for integrating macvim with Skim.app

Shortcuts:
 * `,v` - view current .tex file in Skim at current line
 * `,p` - rebuild current .tex file with `pdflatex -synctex=1`, then active Skim at current line
 * `,m` - Run the command `make` in the current directory, then activate Skim at current line
 * `,r` - activate Skim at current line, then bring vim back to the front
 * `,t` - `,p` + `,r`: rebuild current file, then bring vim back to the front


INSTALLATION
------------
Easiest way: run `macvim-skim-install.sh`.  By default, installs a shell script
to your `$HOME/bin/` directory, installs the latest `Skim.app` if it's not already
installed, and puts `WhichTab.vim` in your plugins directory.  It will also add
the shortcut lines to your `$HOME/.vimrc`.

If you want to specify a different install directory for the executable file, specify the
`PREFIX` variable, e.g.:

`PREFIX=/usr/local ./macvim-skim-install.sh`

### Manual Install ###
If you want to install manually, Copy macvim-skim to `~/.vim/plugins/`.  Put
`macvim-load-line` on your path.
