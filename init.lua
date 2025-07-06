require('config.lazy')
vim.opt.number=true
vim.opt.tabstop=4
vim.opt.shiftwidth=4
--vim.opt.relativenumber=true
vim.cmd("colorscheme monokai-pro")
vim.keymap.set('n','<C-b>', function()
	vim.cmd('Neotree')
end)
vim.keymap.set('n','<C-q>','<cmd>wqall')
vim.keymap.set('n','<C-d>','yyp')
vim.keymap.set('n','<C-Space>', '<C-x><C-o>')
vim.keymap.set('n','<C-20>', '<C-x><C-o>')
