" vim:et:sw=2:ts=2

" Plugin configuration like the code written in vimrc.
" This configuration is executed *before* a plugin is loaded.
function! s:on_load_pre()
  function! MyFileEncoding()
    return &bomb ? &fileencoding . '(BOM)' : &fileencoding
  endfunction

  let g:lightline = {
  \   'colorscheme': 'jellybeans',
  \   'active': {
  \     'left': [ [ 'mode', 'paste' ],
  \               [ 'gitbranch', 'readonly', 'filename', 'modified', 'anzu' ] ],
  \     'right': [ [ 'lineinfo' ],
  \                [ 'percent' ],
  \                [ 'fileformat', 'myfileencoding', 'filetype' ] ]
  \   },
  \   'inactive': {
  \     'left': [ [ 'mode', 'paste' ],
  \               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
  \     'right': [ [ 'lineinfo' ],
  \                [ 'percent' ],
  \                [ 'fileformat', 'myfileencoding', 'filetype' ] ]
  \   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \     'anzu': 'anzu#search_status',
  \     'myfileencoding': 'MyFileEncoding'
  \   },
  \ }

  " show statusbar
  set laststatus=2

  " hide --INSERT--
  set noshowmode

  augroup LightlineColorscheme
    autocmd!
    autocmd ColorScheme * call s:lightline_update()
  augroup END

  function! s:lightline_update()
    if !exists('g:loaded_lightline')
      return
    endif
    try
      if g:colors_name =~# 'wombat\|solarized\|landscape\|jellybeans\|seoul256\|Tomorrow'
        let g:lightline.colorscheme =
              \ substitute(substitute(g:colors_name, '-', '_', 'g'), '256.*', '', '')
        call lightline#init()
        call lightline#colorscheme()
        call lightline#update()
      endif
    catch
    endtry
  endfunction
endfunction

" Plugin configuration like the code written in vimrc.
" This configuration is executed *after* a plugin is loaded.
function! s:on_load_post()
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
