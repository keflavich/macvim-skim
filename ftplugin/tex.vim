if !exists("g:macvim_skim_app_path")
    let g:macvim_skim_app_path='/Applications/Skim.app'
endif

" Activate skim
nnoremap <buffer> <localleader>v
    \ :w<CR>
    \ :silent !<C-r>=g:macvim_skim_app_path<CR>/Contents/SharedSupport/displayline
    \ -r <C-r>=line(".")<CR>
    \ %<.pdf %<CR><CR>

nnoremap <buffer> <localleader>p
    \ :w<CR>
    \ :silent !pdflatex -synctex=1 --interaction=nonstopmode %:p <CR>
    \ :silent !<C-r>=g:macvim_skim_app_path<CR>/Contents/SharedSupport/displayline
    \ -r <C-r>=line(".")<CR>
    \ %<.pdf %<CR><CR>

nnoremap <buffer> <localleader>m
    \ :w<CR>
    \ !make <CR>
    \ :silent !<C-r>=g:macvim_skim_app_path<CR>/Contents/SharedSupport/displayline
    \ -r <C-r>=line(".")<CR>
    \ %<.pdf %<CR><CR>
" " Reactivate Vim
nnoremap <buffer> <localleader>r
    \ :w<CR>
    \ :silent !<C-r>=g:macvim_skim_app_path<CR>/Contents/SharedSupport/displayline
    \ -r <C-r>=line(".")<CR>
    \ %<.pdf %<CR>
    \ :silent !osascript -e "tell application \"MacVim\" to activate" <CR><CR>

nnoremap <buffer> <localleader>t
    \ :w<CR>
    \ :silent !pdflatex -synctex=1 --interaction=nonstopmode %:p <CR>
    \ :silent !<C-r>=g:macvim_skim_app_path<CR>/Contents/SharedSupport/displayline
    \ -r <C-r>=line(".")<CR>
    \ %<.pdf %<CR>
    \ :silent !osascript -e "tell application \"MacVim\" to activate" <CR><CR>



