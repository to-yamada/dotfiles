if &compatible
  set nocompatible               " Be iMproved
endif

"---------------------------------------------------------------------------
" python3
"---------------------------------------------------------------------------
let g:python3_host_prog = $PYENV_ROOT . '/versions/3.7.0/bin/python3'

"---------------------------------------------------------------------------
" dein
"---------------------------------------------------------------------------
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

if has('iconv')
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  else
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
  endif

  " fileencodingsを構築
  let s:fileencodings_default = &fileencodings
  let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
  let &fileencodings = &fileencodings .','. s:fileencodings_default

  " 定数を処分
  unlet s:fileencodings_default
  unlet s:enc_euc
  unlet s:enc_jis
endif

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

"---------------------------------------------------------------------------
" 色
"---------------------------------------------------------------------------
syntax on
set t_Co=256
colorscheme Tomorrow-Night-Bright
" vimdiffの色設定
highlight DiffAdd    ctermbg=22
highlight DiffDelete ctermbg=52
highlight DiffChange ctermbg=17
highlight DiffText   ctermbg=21

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

" 自動的にインデントする
set autoindent

" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start

" 検索時にファイルの最後まで行ったら最初に戻る
set wrapscan

" 括弧入力時に対応する括弧を表示
set showmatch

" コマンドライン補完するときに強化されたものを使う
set wildmenu

" 補完モード。対象をリストする。
set wildmode=list:longest

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

" タブや改行を表示
" どの文字でタブや改行を表示するかを設定
set listchars=tab:>.,nbsp:%,extends:>,precedes:<,eol:$
set list

" 長い行は折り返さないで表示
set nowrap

" コマンドをステータス行に表示
set showcmd

" タイトルを表示
set title

" マウスの使用
set mouse=a

" キーコードシーケンスが終了するのを待つ時間を短く
set ttimeoutlen=10

" バックアップファイルを作成しない
set nobackup

" 履歴
set history=50

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
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
nmap # <Space><Space>:%s/<C-r>///g<Left><Left>

" https://qiita.com/itmammoth/items/312246b4b7688875d023 より
" ハイライトを消去する
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" diff は C-j, C-k で移動
nnoremap <C-j> ]czz
nnoremap <C-k> [czz

" 検索後が画面の真ん中に来るように
nmap n nzz
nmap N Nzz
nmap * *zz

