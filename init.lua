require('config.lazy')

vim.opt.number=true
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.cmd("colorscheme monokai-pro")

--neo tree and telescope
vim.keymap.set('n','<leader>b','<cmd>Neotree<cr>')
vim.keymap.set('n','<leader>t','<cmd>Telescope<cr>')

--split windows
vim.keymap.set('n','<leader>v','<cmd>vsplit<cr>')
vim.keymap.set('n','<leader>s','<cmd>split<cr>')

--select window
vim.keymap.set('n','<leader>h','<C-w>h')
vim.keymap.set('n','<leader>j','<C-w>j')
vim.keymap.set('n','<leader>k','<C-w>k')
vim.keymap.set('n','<leader>l','<C-w>l')

--ctrl q and ctrl d
vim.keymap.set('n','<C-q>','<cmd>wqall<cr>')
vim.keymap.set('n','<C-d>','yyp')

--omnicomplete
vim.keymap.set('n','<C-Space>', '<C-x><C-o>')
