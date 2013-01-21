macvim-skim
===========

Tools for integrating macvim with Skim.app.  Adds shortcuts to vim so that you
can go to the current line in the PDF from a tex document.  Adds a tool to Skim
so that command-clicking on a line brings you to that line in the source code.

Example:
![Screenshot example of intended environment](https://raw.github.com/keflavich/macvim-skim/master/macvim-skim/test/Example_MacvimSkim.png "Screenshot")

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

You can also specify the path to `Skim.app` with the variable `SKIMPATH`

### Manual Install ###
If you want to install manually, Copy macvim-skim to `~/.vim/plugins/`.  Put
`macvim-load-line` on your path.


### Aside ###
Was hosted at http://code.google.com/p/agpy/source/browse/trunk#trunk%2Fmacvim-skim until 1/20/2013.  No issues were posted on agpy, though.
