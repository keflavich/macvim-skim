if !exists(g:macvim_skim_app_path)
    let g:macvim_skim_app_path='/Applications/Skim.app'
endif

" Activate skim
execute('map ,v :w<CR>:silent !'.g:macvim_skim_app_path.'/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR><CR>')
execute('map ,p :w<CR>:silent !pdflatex -synctex=1 --interaction=nonstopmode %:p <CR>:silent !'.g:macvim_skim_app_path.'/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR><CR>')
execute('map ,m :w<CR>:silent !make <CR>:silent !'.g:macvim_skim_app_path.'/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR><CR>')
" Reactivate VIM
execute('map ,r :w<CR>:silent !'.g:macvim_skim_app_path.'/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR>:silent !osascript -e "tell application \"MacVim\" to activate" <CR><CR>')
execute('map ,t :w<CR>:silent !pdflatex -synctex=1 --interaction=nonstopmode %:p <CR>:silent !'.g:macvim_skim_app_path.'/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR>:silent !osascript -e "tell application \"MacVim\" to activate" <CR><CR>')

