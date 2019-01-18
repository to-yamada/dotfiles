"---------------------------------------------------------------------------
" python3
"---------------------------------------------------------------------------
if has("win32")
  let g:python3_host_prog = expand('~/AppData/Local/Programs/Python/Python37-32/python')
else
  let g:python3_host_prog = $PYENV_ROOT . '/versions/3.7.2/bin/python3'
endif

"---------------------------------------------------------------------------
" dein
"---------------------------------------------------------------------------
" reset augroup
augroup DeinAutoCmd
    autocmd!
augroup END

let s:cache_home = empty($XDG_CACHE_HOME) ?
  \ expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_path = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
"deinがinstallされてなければgit clone
if !isdirectory(s:dein_repo_path)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_path
endif
execute 'set runtimepath^=' . s:dein_repo_path

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
  let s:lazy_toml = fnamemodify(expand('<sfile>'), ':h').'/dein_lazy.toml'

  " TOML 読み込み
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" プラグイン削除したいときは :DeinClean で削除
function! s:deinClean()
  if len(dein#check_clean())
    call map(dein#check_clean(), 'delete(v:val, "rf")')
  else
    echo '[ERR] no disabled plugins'
  endif
endfunction
command! DeinClean :call s:deinClean()


"---------------------------------------------------------------------------
" 文字コードの自動認識
"---------------------------------------------------------------------------
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,utf-8,cp932,euc-jisx0213,euc-jp

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" 改行コードの自動認識
set fileformats=unix,dos,mac

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

"-------------------------------------------------------------------------------
" 最後にカーソルがあった場所へカーソルを移動
"-------------------------------------------------------------------------------
if has("autocmd")
  augroup vimrcEx
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
  augroup END
endif

"---------------------------------------------------------------------------
" 共通の設定
"---------------------------------------------------------------------------
" タブ
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" 検索時にファイルの最後まで行ったら最初に戻る
set wrapscan

" 括弧入力時に対応する括弧を表示
set showmatch

" コマンドライン補完するときに強化されたものを使う
set wildmenu

" 補完モード。対象をリストする。
set wildmode=list:longest

" ファイル名やディレクトリを補完するときに大文字小文字を無視
set wildignorecase

" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

" クリップボードの共有
set clipboard=unnamed

" 矩形選択時はカーソルを文字がないところにも移動できるようにする
set virtualedit=block

" 検索時の挙動
set ignorecase  " 検索時に大文字小文字を無視
set smartcase   " 大文字小文字の両方が含まれている場合は大文字小文字を区別
set incsearch   " インクリメンタルサーチ
set inccommand=split    " インクリメンタル置換
set hlsearch    " 検索結果をハイライト

" 行番号を表示
set number

" 現在行を強調表示
set cursorline

" タブや改行を表示
" どの文字でタブや改行を表示するかを設定
set listchars=tab:»\ ,nbsp:%,extends:>,precedes:<,eol:↲
set list

" 長い行は折り返さないで表示
set nowrap

" タイトルを表示
set title

" マウスの使用
set mouse=a

" キーコードシーケンスが終了するのを待つ時間を短く
set ttimeoutlen=10

" バックアップファイルを作成しない
set nobackup

"---------------------------------------------------------------------------
" キーバインド
"---------------------------------------------------------------------------
" 見た目の行で移動
nnoremap <Up> gk
nnoremap k gk
nnoremap <Down> gj
nnoremap j gj

" コマンドライン上では emacs 風に移動
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" https://qiita.com/itmammoth/items/312246b4b7688875d023 より
" カーソル下の単語をハイライトしてから置換する
nnoremap # "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>:%s/<C-r>///g<Left><Left>

" https://qiita.com/itmammoth/items/312246b4b7688875d023 より
" ハイライトを消去する
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" diff は C-j, C-k で移動
nmap <C-j> ]czz
nmap <C-k> [czz

"---------------------------------------------------------------------------
" プロジェクト固有の設定読み込み(.vimrc.local)
"---------------------------------------------------------------------------
" Load settings for each location.
" https://vim-jp.org/vim-users-jp/2009/12/27/Hack-112.html
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
