if v:version < 700
    finish
endif

if exists("g:disable_codecomplete")
    finish
endif

if !exists("g:completekey")
    let g:completekey = "<tab>"   "hotkey
endif

if !exists("g:rs")
    let g:rs = '`<'    "region start
endif

if !exists("g:re")
    let g:re = '>`'    "region stop
endif

if !exists("g:user_defined_snippets")
    let g:user_defined_snippets = "$VIMRUNTIME/plugin/my_snippets.vim"
endif

autocmd BufReadPost,BufNewFile * call CodeCompleteStart()

function! CodeCompleteStart()
    exec "inoremap <buffer> ".g:completekey." <c-r>=SwitchRegion()<cr>"
endfunction

function! SwitchRegion()
    if match(getline('.'),g:rs.'.*'.g:re)!=-1 || search(g:rs.'.\{-}'.g:re)!=0
        if search(g:rs, 'c', line('')) == 0
            normal 0
        endif
        call search(g:rs,'c',line('.'))
        normal v
        call search(g:re,'e',line('.'))
        if &selection == "exclusive"
            exec "norm l"
        endif
        return "\<c-\>\<c-n>gv\<c-g>"
    else
        return "\<c-o>A"
    endif
endfunction
