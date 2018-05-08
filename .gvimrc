" vim:set ts=8 sts=2 sw=2 tw=0:

"---------------------------------------------------------------------------
" 色テーマ設定
set background=dark
colorscheme Tomorrow-Night-Bright

"---------------------------------------------------------------------------
" フォント設定:
"
if has('win32')
  " Windows用
  set guifont=VL_Gothic_Regular:h12:cSHIFTJIS,MS_Gothic:h12:cSHIFTJIS
  "set guifont=Consolas:h10.5:cDEFAULT
  "set guifontwide=MS_Gothic:h10.5:cSHIFTJIS
  if has('directx')
    " メニュー文字化け対策
    source $VIMRUNTIME/delmenu.vim
    set langmenu=ja_jp.utf-8
    source $VIMRUNTIME/menu.vim
    " directx を用いて描画
    set renderoptions=type:directx,geom:1,renmode:5,gamma:2.0
  endif
elseif has('mac')
  set guifont=Osaka?等幅:h14
elseif has('xfontset')
  " UNIX用 (xfontsetを使用)
  set guifontset=a14,r14,k14
elseif has('unix')
  set guifont=VL\ ゴシック\ 10,Monospace\ 10
endif

" 印刷用フォント
if has('printer')
  if has('win32')
    " set printfont=MS_Gothic:h12:cSHIFTJIS
  endif
endif

"---------------------------------------------------------------------------
" ウインドウに関する設定:
"
" ウインドウの幅
set columns=120
" ウインドウの高さ
set lines=40
" コマンドラインの高さ(GUI使用時)
set cmdheight=1
" 行間隔の設定
set linespace=1

"---------------------------------------------------------------------------
" 日本語入力に関する設定:
"
if has('multi_byte_ime') || has('xim')
  " IME ON時のカーソルの色を設定(設定例:紫)
  highlight CursorIM guibg=Purple guifg=NONE
  " 挿入モード・検索モードでのデフォルトのIME状態設定
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    " XIMの入力開始キーを設定:
    " 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
    "set imactivatekey=s-space
  endif
  " 挿入モードでのIME状態を記憶させない
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

