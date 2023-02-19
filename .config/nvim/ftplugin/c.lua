-- タブ
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 0
vim.opt_local.expandtab = false

-- l1: case 文で{}が使ったときのインデントをcaseラベルを基準にする
-- :0: case ラベルをswitchと同じ位置にする
-- (0: 閉じていない()使用時、()後の非空白文字の位置で合わせる
-- Ws: 閉じていない()使用時、続く行を最初の行から相対的にインデントする
-- m1: 閉じていない()使用時、)で始まる行を行頭に並べる
vim.opt_local.cinoptions = 'l1,:0,(0,Ws,m1'

