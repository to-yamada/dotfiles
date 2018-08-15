" タブ
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=0
setlocal noexpandtab

" case: 文で{}が使えるように, 閉じていない()の改行時は()後の非空白文字の位置で合わせる
set cinoptions=l1,(0,Ws,m1

if executable('rg')
  call denite#custom#var('grep', 'command', ['rg'])
  call denite#custom#var('grep', 'default_opts',
       \ ['--vimgrep', '--no-heading', '-ESJIS'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
endif

