" vim:set ts=8 sts=2 sw=2 tw=0:
"
"
if &compatible
  set nocompatible               " Be iMproved
endif

"---------------------------------------------------------------------------
" dein
"---------------------------------------------------------------------------
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_path = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
"deinがinstallされてなければgit clone
if !isdirectory(s:dein_repo_path)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_path
endif
execute 'set runtimepath^=' . s:dein_repo_path

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:config_dir  = expand('~/.config/nvim')
  let s:toml        = g:config_dir . '/dein.toml'
  let s:lazy_toml   = g:config_dir . '/dein_lazy.toml'

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

" プラグイン削除用
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
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
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
" 検索の挙動に関する設定:
"---------------------------------------------------------------------------
set ignorecase	" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set smartcase	" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set incsearch	" インクリメンタルサーチ
set hlsearch

"---------------------------------------------------------------------------
" 編集に関する設定:
"---------------------------------------------------------------------------
" タブの画面上での幅
set tabstop=4
set shiftwidth=4
set softtabstop=0

" タブをスペースに展開しない (expandtab:展開する)
set noexpandtab

" 自動的にインデントする (noautoindent:インデントしない)
set autoindent

" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start

" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan

" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch

" matchhit
source $VIMRUNTIME/macros/matchit.vim

" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu

" 補完モード。対象をリストする。
set wildmode=list:longest

" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

" case: 文で{}が使えるように, 閉じていない()の改行時は()後の非空白文字の位置で合わせる
set cinoptions=l1,(0,Ws,m1

" ヘルプファイルを日本語に
"set helpfile=$VIMRUNTIME/doc/help.jax

" 起動時のメッセージを表示しない
set shortmess+=I

" クリップボードの共有
set clipboard=unnamed

" 矩形選択時はカーソルを文字がないところにも移動できるようにする
set virtualedit=block

"-------------------------------------------------------------------------------
" autocmd に関する設定
"-------------------------------------------------------------------------------
if has("autocmd")
  filetype plugin indent on
  augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
  autocmd FileType python setlocal tabstop=4
  autocmd FileType python setlocal shiftwidth=4
  autocmd FileType python setlocal softtabstop=4
  autocmd FileType python setlocal expandtab
  autocmd FileType ruby setlocal tabstop=2
  autocmd FileType ruby setlocal shiftwidth=2
  autocmd FileType ruby setlocal softtabstop=2
  autocmd FileType ruby setlocal expandtab
  autocmd FileType asm setlocal tabstop=8
  autocmd FileType asm setlocal shiftwidth=8
  autocmd FileType asm setlocal softtabstop=8
  autocmd BufRead,BufNewFile *.go setfiletype go
else
  set autoindent
endif

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"---------------------------------------------------------------------------
" 行番号を非表示 (number:表示)
set nonumber
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
" どの文字でタブや改行を表示するかを設定
set listchars=tab:>.,nbsp:%,extends:>,precedes:<,eol:$
set list
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=1
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" マウスの使用
set mouse=a
"set ttymouse=xterm2
" 色付け
syntax on

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"---------------------------------------------------------------------------
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
set nobackup
" 履歴
set history=50

set viminfo='100,<50,s10,h,n~/.viminfo

"---------------------------------------------------------------------------
" colorscheme for terminal
"---------------------------------------------------------------------------
if !has('gui_running') && !has('win32')
  set t_Co=256
  colorscheme Tomorrow-Night-Bright
endif

"---------------------------------------------------------------------------
" キーバインドの設定
"---------------------------------------------------------------------------
" 見た目の行で移動
nnoremap <Up> gk
nnoremap k gk
nnoremap <Down> gj
nnoremap j gj

" C-j で IME 切り替え、C-k, jjで挿入モード抜ける
imap <C-j> <C-^>
imap <C-k> <Esc>
inoremap <silent> jj <ESC>

" キーコードシーケンスが終了するのを待つ時間を短く
set ttimeoutlen=10

" C-g で カーソル直下の単語を vimgrep
function! s:GrepVimWord()
  let findwords = expand("<cword>")

  if findwords == ""
    echo "検索用語がありません"
    return
  end

  let ext = expand("%:e")
  let target = "*"
  if ext == "c" || ext == "cpp" || ext == "h" || ext == "hpp"
    let target = "*.c *.cpp *.h *.hpp"
  elseif ext == "py" || ext == "pyw"
    let target = "*.py *.pyw"
  elseif ext == "rb"
    let target = "*.rb"
  elseif ext == "asm"
    let target = "*.asm *.inc *.h"
  endif
  execute 'vimgrep /\C\<' . findwords . '\>/j ' . target . ' | cwin'
endfunction

command! GrepVimWord call s:GrepVimWord()
nmap <C-g> :GrepVimWord<Enter>

" 検索後が画面の真ん中に来るように
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz


let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
