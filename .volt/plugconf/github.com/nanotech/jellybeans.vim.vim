" vim:et:sw=2:ts=2

" Plugin configuration like the code written in vimrc.
" This configuration is executed *before* a plugin is loaded.
function! s:on_load_pre()
  set t_Co=256
  let g:jellybeans_use_term_italics = 0
  let g:jellybeans_use_gui_italics = 0
  let g:jellybeans_overrides = {
  \   'background': { 'guibg': '000000' },
  \   'SpecialKey': { 'guifg': '303030', 'guibg': '', 'ctermbg': '' },
  \   'NonText':    { 'guifg': '303030', 'guibg': '', 'ctermbg': '' },
  \   'Search':     { 'guibg': '', 'ctermbg': '' },
  \ }
endfunction

" Plugin configuration like the code written in vimrc.
" This configuration is executed *after* a plugin is loaded.
function! s:on_load_post()
  colorscheme jellybeans
  " vimdiffの色設定
  highlight DiffAdd    ctermbg=22
  highlight DiffDelete ctermbg=52
  highlight DiffChange ctermbg=17
  highlight DiffText   ctermbg=21
endfunction

" This function determines when a plugin is loaded.
"
" Possible values are:
" * 'start' (a plugin will be loaded at VimEnter event)
" * 'filetype=<filetypes>' (a plugin will be loaded at FileType event)
" * 'excmd=<excmds>' (a plugin will be loaded at CmdUndefined event)
" <filetypes> and <excmds> can be multiple values separated by comma.
"
" This function must contain 'return "<str>"' code.
" (the argument of :return must be string literal)
function! s:loaded_on()
  return 'start'
endfunction

" Dependencies of this plugin.
" The specified dependencies are loaded after this plugin is loaded.
"
" This function must contain 'return [<repos>, ...]' code.
" (the argument of :return must be list literal, and the elements are string)
" e.g. return ['github.com/tyru/open-browser.vim']
function! s:depends()
  return []
endfunction
