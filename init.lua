require('config.lazy')

vim.opt.number=true
vim.opt.tabstop=4
vim.opt.shiftwidth=4
--vim.opt.relativenumber=true
vim.cmd("colorscheme monokai-pro")
--neo tree and telescope
vim.keymap.set('n','<leader>b','<cmd>Neotree<cr>')
vim.keymap.set('n','<leader>t','<cmd>Telescope<cr>')
--split windows
vim.keymap.set('n','<leader>j','<cmd>vsplit<cr>')
vim.keymap.set('n','<leader>l','<cmd>split<cr>')
--resize windows
--vim.keymap.set('n','<S-->','<cmd>split<cr>')
--ctrl q and ctrl d
vim.keymap.set('n','<C-q>','<cmd>wqall<cr>')
vim.keymap.set('n','<C-d>','yyp')
--omnicomplete
vim.keymap.set('n','<C-Space>', '<C-x><C-o>')
