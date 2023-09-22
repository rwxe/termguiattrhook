" ==============================================================================
" Name:         termguiattrhook
" Description:  Override cterm attributes with gui attribute
" Author:       github: rwxe
" Version:      0.0.0.1
" License:      MIT
" Created:      Sep 12, 2023
" README:       
"               This plugin is used to override cterm attributes with gui 
"               attributes for all highlight groups. 
"
"               Please see the help documentation for details. 
"               Run `:help termguiattrhook` to view the help document, or 
"               go to the `termguiattrhook/doc` directory to view it.
"               Most of the code is actually written by AI. If you have a 
"               better implementation, please welcome PR.
" ==============================================================================

" Enable by default
if !exists('g:termguiattrhook_enable')
    let g:termguiattrhook_enable = 1
endif

" Called at startup by default
if !exists('g:termguiattrhook_on_startup')
    let g:termguiattrhook_on_startup = 1
endif

" Recalled when the colorscheme changes by default
if !exists('g:termguiattrhook_on_colorscheme_change')
    let g:termguiattrhook_on_colorscheme_change = 1
endif

" Show call log to `:messages` by default
if !exists('g:termguiattrhook_show_call_log')
    let g:termguiattrhook_show_call_log = 1
endif

let s:_call_log = "TermGuiAttrHook: attributes gui -> cterm"

let s:_vim_entered = 0

"Command `:TermGuiAttrHook` for manually call
command TermGuiAttrHook call TermGuiAttrHook() 
function! TermGuiAttrHook()
    if !g:termguiattrhook_enable
        return
    endif
    " Loop through all highlight groups
    for group in getcompletion('', 'highlight')
        " Get the configuration of the current highlight group
        let group_config = execute('hi ' . group)
        " Use regex matching to find the value of the gui attribute
        let gui_match = matchlist(group_config, 'gui\s*=\s*\zs\S\+\ze')
        " Filter out empty strings and save matched non-empty strings in a list
        let gui_values = filter(gui_match, 'v:val != ""')
        " If is non-empty list, take the first value and assign it to the cterm attribute
        if !empty(gui_values)
            let gui_value = gui_values[0]
            " Assign the value of the gui attribute to the cterm attribute
            execute 'hi ' . group . ' cterm=' . gui_value
        endif
    endfor

    if g:termguiattrhook_show_call_log 
        if s:_vim_entered
            echom s:_call_log
        else
            autocmd VimEnter * echom s:_call_log
        endif
    endif
endfunction




if g:termguiattrhook_on_startup
    call TermGuiAttrHook()
endif

let s:_vim_entered=1

if g:termguiattrhook_on_colorscheme_change
    augroup termguiattrhook
        autocmd!
        autocmd ColorScheme * call TermGuiAttrHook()
    augroup END
endif

