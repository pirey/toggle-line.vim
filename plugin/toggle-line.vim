" toggle statusline and tabline, because sometimes its just get in your way

if exists('g:loaded_toggle_line')
    finish
endif

let g:loaded_toggle_line = 1

if exists('g:toggle_line_show')
    let s:show = get(g:, 'toggle_line_show', 0)
else
    let s:show = &laststatus > 0 || &showtabline > 0
endif

function! s:is_shown() abort
    return get(s:, 'show', 0)
endfunction

function! s:is_tmux_running() abort
    return $TMUX != ''
endfunction

function! s:show_tmuxline() abort
    if s:is_tmux_running()
        silent !tmux set -g status on
    endif
endfunction

function! s:hide_tmuxline() abort
    if s:is_tmux_running()
        silent !tmux set -g status off
    endif
endfunction

function! s:show_line() abort
    call s:show_tmuxline()
    let s:show = 1
    set laststatus=2 showtabline=2
endfunction

function! s:hide_line() abort
    call s:hide_tmuxline()
    let s:show = 0
    set laststatus=0 showtabline=0
endfunction

function! s:toggle() abort
    if s:is_shown()
        call s:hide_line()
    else
        call s:show_line()
    endif
endfunction

function! s:resume() abort
    " TODO add option to reset state on resume / focus gained
    call s:main()
endfunction

function! s:main() abort
    if s:is_shown()
        call s:show_line()
    else
        call s:hide_line()
    endif
endfunction

command! ToggleLine :call s:toggle()

" mapping {{{
nnoremap <silent> <Plug>ToggleLine  :call <SID>toggle()<CR>

if empty(mapcheck("<space>ts", "n"))
  nmap <space>ts <Plug>ToggleLine
endif
" }}}

" autocmd {{{
augroup toggle_line
    autocmd!
    autocmd VimLeave,VimSuspend,FocusLost * call s:show_tmuxline()
    autocmd VimResume,FocusGained * call s:resume()
augroup END
" }}}

" init {{{
call s:main()
" }}}
