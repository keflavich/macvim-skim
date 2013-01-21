function! WhichTab(filename)
    " Try to determine whether file is open in any tab.  
    " Return number of tab it's open in
    let buffername = bufname(a:filename)
    if buffername == ""
        return 0
    endif
    let buffernumber = bufnr(buffername)

    " tabdo will loop through pages and leave you on the last one;
    " this is to make sure we don't leave the current page
    let currenttab = tabpagenr()
    let tab_arr = []
    tabdo let tab_arr += tabpagebuflist()

    " return to current page
    exec "tabnext ".currenttab

    " Start checking tab numbers for matches
    let i = 0
    for tnum in tab_arr
        let i += 1
        echo "tnum: ".tnum." buff: ".buffernumber." i: ".i
        if tnum == buffernumber
            return i
        endif
    endfor

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

function! WhichTabNo(bufNo)
    " returns a list of tabnos where the buf is found or 0 for none.
    " tabnos start at 1, so 0 is always invalid
    " from http://stackoverflow.com/questions/8839846/vim-check-if-a-file-is-open-in-current-tab-window-and-activate-it/14427211#14427211
    let tabNos = []
    for tabNo in range(1, tabpagenr("$"))
        for bufInTab in tabpagebuflist(tabNo)
            if (bufInTab == a:bufNo)
                call add(tabNos, tabNo)
            endif
        endfor
    endfor
    let numBufsFound = len(tabNos)
    return (numBufsFound == 0) ? 0 : tabNos
endfunction
