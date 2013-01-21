#!/bin/sh

# set install path
if [ ! $PREFIX ];
then
    PREFIX=$HOME
fi
VIMDIR=$HOME/.vim/

# get relevant scripts
# echo "Getting macvim-load-line from googlecode repository"
# curl -s http://agpy.googlecode.com/svn/trunk/macvim-skim/macvim-load-line > ${PREFIX}/macvim-load-line
# chmod +x ${PREFIX}/macvim-load-line
# echo "Getting WhichTab.vim from googlecode repository"
# curl -s http://agpy.googlecode.com/svn/trunk/macvim-skim/WhichTab.vim > ${VIMDIR}/plugin/WhichTab.vim
chmod +x macvim-skim/macvim-load-line
cp macvim-skim/macvim-load-line $PREFIX/bin/
cp plugin/WhichTab.vim $VIMDIR/plugin/

if [ ! $SKIMPATH ];
then
    SKIMPATH=/Applications/Skim.app
fi

if [ ! -d $SKIMPATH ]
then
    # get Skim.app 
    # should work, but doesn't curl -L http://sourceforge.net/projects/skim-app/files/latest/download?source=files -o Skim.dmg
    echo "Did not find $SKIMPATH.  Downloading and installing latest skim."
    curl -L "http://downloads.sourceforge.net/project/skim-app/Skim/Skim-1.4.1/Skim-1.4.1.dmg?use_mirror=autoselect" -o Skim.dmg
    #curl -L "http://sourceforge.net/projects/skim-app/files/latest/download?source=files" -o Skim.dmg
    hdid Skim.dmg
    cp -r /Volumes/Skim/Skim.app $SKIMPATH
    hdiutil eject /Volumes/Skim
fi

# Add lines to .vimrc 
if [[ `grep 'map ,[rvpmt]' ${HOMEDIR}/.vimrc` == "" ]]; 
then
    echo "Did not find mappings in ${HOMEDIR}/.vimrc.  Appending them."
    echo \" Activate skim >> ${HOMEDIR}/.vimrc
    echo let g:macvim_skim_app_path='/Applications/Skim.app' >> ${HOMEDIR}/.vimrc
    echo 'execute("map ,v :w<CR>:silent !".g:macvim_skim_app_path."/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR><CR>")' >> ${HOMEDIR}/.vimrc
    echo 'execute("map ,p :w<CR>:silent !pdflatex -synctex=1 --interaction=nonstopmode %:p <CR>:silent !".g:macvim_skim_app_path."/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR><CR>")' >> ${HOMEDIR}/.vimrc
    echo 'execute("map ,m :w<CR>:silent !make <CR>:silent !".g:macvim_skim_app_path."/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR><CR>")' >> ${HOMEDIR}/.vimrc
    echo '\" Reactivate VIM' >> ${HOMEDIR}/.vimrc
    echo 'execute("map ,r :w<CR>:silent !".g:macvim_skim_app_path."/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR>:silent !osascript -e "tell application \"MacVim\" to activate" <CR><CR>")' >> ${HOMEDIR}/.vimrc
    echo 'execute("map ,t :w<CR>:silent !pdflatex -synctex=1 --interaction=nonstopmode %:p <CR>:silent !".g:macvim_skim_app_path."/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR>:silent !osascript -e "tell application \"MacVim\" to activate" <CR><CR>")' >> ${HOMEDIR}/.vimrc

fi

# set Skim settings
defaults write net.sourceforge.skim-app.skim SKTeXEditorCommand "macvim-load-line"
defaults write net.sourceforge.skim-app.skim SKTeXEditorArguments "'\"%file\" %line'"
