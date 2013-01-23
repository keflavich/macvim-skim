function! MVS_Focus(filename, line)
  " See if the given filename is found to be loaded in any tab/window
  " if so, raise window, switch to file's tab, window, and jump line
  let oldSwitchBufOpt = &switchbuf
  let &switchbuf = "useopen,usetab"
  let bufNo = bufnr('\(^\|/\)' . a:filename . '$')
  if (!bufNo || !bufloaded(bufNo))
    return 0
  endif
  call foreground()
  exec "sbuffer" bufNo
  let &switchbuf = oldSwitchBufOpt " restore user's switchbuf option
  exe ":silent! :".a:line
  " see if you like this... could also pass a number of lines down to highlight
  exe ":normal V"
  call REcho(printf("Focused on %s line %d by macvim-skim.", fnamemodify(bufname("%"), ":f"), a:line))
  return 1
endfunction

" Redraw-echo (:he echo-redraw) -- more reliable echo!
function! REcho(msg)
  redraw | echo a:msg
endfunction


function! WhichTab(filename)
    " Try to determine whether file is open in any tab.  
    " Return number of tab it's open in
    " If it's open in multiple tabs, return the leftmost
    let bufNo = bufnr('\(^\|\/\)' . a:filename . '$')

    let tabNos = []
    for tabNo in range(1, tabpagenr("$"))
        for bufInTab in tabpagebuflist(tabNo)
            if (bufInTab == bufNo)
                call add(tabNos, tabNo)
            endif
        endfor
    endfor
    let numBufsFound = len(tabNos)
    return (numBufsFound == 0) ? 0 : tabNos[0]

endfunction

function! WhichWindow(filename)
    " Try to determine whether the file is open in any GVIM *window*
    let serverlist = split(serverlist(),"\n")

    "let currentserver = ????
    for server in serverlist
        let remotetabnum = remote_expr(server, 
            \"WhichTab('".a:filename."')")
        if remotetabnum != 0
            return server
        endif
    endfor

endfunction
