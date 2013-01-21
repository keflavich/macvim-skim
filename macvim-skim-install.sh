#!/bin/sh

# set install path
if [ ! $PREFIX ];
then
    PREFIX=$HOME
fi
if [ ! $VIMDIR ];
then
    VIMDIR=$HOME/.vim/
fi

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

# Add lines to ~/.vim/ftplugin/tex.vim 
if [ -e $VIMDIR/ftplugin/tex.vim ];
then
    if [[ `grep 'map ,[rvpmt]' ${VIMDIR}/ftplugin/tex.vim` == "" ]]; 
    then
        echo "Found a tex.vim in ${VIMDIR}/ftplugin/.  Appending to it."
        cat ftplugin/tex.vim >> $VIMDIR/ftplugin/tex.vim
    else
        echo "Found a tex.vim in ${VIMDIR}/ftplugin/, and the Skim bindings appear to already be installed"
    fi
else
    cp ftplugin/tex.vim $VIMDIR/ftplugin/tex.vim
fi

# set Skim settings
defaults write net.sourceforge.skim-app.skim SKTeXEditorCommand "macvim-load-line"
defaults write net.sourceforge.skim-app.skim SKTeXEditorArguments "'\"%file\" %line'"
