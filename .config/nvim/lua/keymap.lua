----------------------------------------------------------------------------
-- キーバインド
----------------------------------------------------------------------------
-- 見た目の行で移動
vim.keymap.set('n', '<Up>', 'gk')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', '<Down>', 'gj')
vim.keymap.set('n', 'j', 'gj')

-- <Space>s で split, <Space>v で vsplit
vim.keymap.set('n', '<Space>s', ':<C-u>split<CR>', { silent = true })
vim.keymap.set('n', '<Space>v', ':<C-u>vsplit<CR>', { silent = true })

-- コマンドライン上では emacs 風に移動
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-e>', '<End>')
vim.keymap.set('c', '<C-d>', '<Del>')
vim.keymap.set('c', '<C-f>', '<Right>')
vim.keymap.set('c', '<C-b>', '<Left>')
vim.keymap.set('c', '<C-p>', '<Up>')
vim.keymap.set('c', '<C-n>', '<Down>')


-- diff は C-j, C-k で移動
vim.keymap.set('n', '<C-j>', ']czz')
vim.keymap.set('n', '<C-k>', '[czz')
