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
