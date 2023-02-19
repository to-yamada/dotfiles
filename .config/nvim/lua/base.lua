vim.cmd("autocmd!")

----------------------------------------------------------------------------
-- encoding
----------------------------------------------------------------------------
vim.opt.encoding = "utf-8"
vim.scriptencoding = "utf-8"

----------------------------------------------------------------------------
-- 文字コードの自動認識
----------------------------------------------------------------------------
vim.opt.fileencodings = "ucs-bom,iso-2022-jp-3,utf-8,cp932,euc-jisx0213,euc-jp"
vim.opt.fileformats = "unix,dos,mac"

----------------------------------------------------------------------------
-- 共通の設定
----------------------------------------------------------------------------
-- タブ
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- 自動的にインデントする
vim.opt.autoindent = true

-- 括弧入力時に対応する括弧を表示
vim.opt.showmatch = true

-- ファイル名やディレクトリを補完するときに大文字小文字を無視
vim.opt.wildignorecase = true

-- テキスト挿入中の自動折り返しを日本語に対応させる
vim.opt.formatoptions:append({"m", "M"})

-- クリップボードの共有
vim.opt.clipboard = "unnamed"

-- 矩形選択時はカーソルを文字がないところにも移動できるようにする
vim.opt.virtualedit = "block"

-- 検索時の挙動
vim.opt.ignorecase = true   -- 検索時に大文字小文字を無視
vim.opt.smartcase = true    -- 大文字小文字の両方が含まれている場合は大文字小文字を区別
vim.opt.incsearch = true    -- インクリメンタルサーチ
vim.opt.hlsearch = true     -- 検索結果をハイライト

-- 行番号を表示
vim.opt.number = true

-- 現在行を強調表示
vim.opt.cursorline = true

-- タブや改行を表示
-- どの文字でタブや改行を表示するかを設定
vim.opt.listchars = "tab:» ,nbsp:%,extends:>,precedes:<,eol:↲"
vim.opt.list = true

-- 長い行は折り返さないで表示
vim.opt.wrap = false

-- タイトルを表示
vim.opt.title = true

-- キーコードシーケンスが終了するのを待つ時間を短く
vim.opt.ttimeoutlen = 10

-- tags カレントファイルと同じディレクトリもしくは遡っていって tags ファイルが
-- あればそれを使用する。なければカレントディレクトの tags を使用。
vim.opt.tags = "./tags;,tags;"

-- visual bell
vim.opt.visualbell = true

