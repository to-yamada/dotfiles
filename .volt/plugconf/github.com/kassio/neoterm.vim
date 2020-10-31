" vim:et:sw=2:ts=2

" Plugin configuration like the code written in vimrc.
" This configuration is executed *before* a plugin is loaded.
function! s:on_load_pre()
  " :Tnew の場合に挿入モードで開始
  let g:neoterm_autoinsert = 1

  " :T {cmd} 実行時に画面スクロールする
  let g:neoterm_autoscroll = 1

  " 横分割
  let g:neoterm_default_mod = 'belowright'

  " :Tnew 実行
  nnoremap <silent> <Space>tt :Tnew<CR>

  " <Esc> で terminal-mode を抜ける
  tnoremap <Esc> <C-\><C-n>

  " <C-w> で ウィンドウ移動
  tnoremap <C-w><C-w> <C-\><C-n><C-w><C-w>
  tnoremap <C-w><C-j> <C-\><C-n><C-w><C-j>
  tnoremap <C-w><C-k> <C-\><C-n><C-w><C-k>
  tnoremap <C-w><C-h> <C-\><C-n><C-w><C-h>
  tnoremap <C-w><C-l> <C-\><C-n><C-w><C-l>
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
