require('config.lazy')
vim.opt.number=true
vim.opt.tabstop=4
vim.opt.shiftwidth=4
--vim.opt.relativenumber=true
vim.cmd("colorscheme monokai-pro")
vim.keymap.set('n','<C-b>', function()
	vim.cmd('w')
	vim.cmd('Ex')
end)
vim.keymap.set('n','<C-q>',function()
	vim.cmd('wq')
end)
--[[vim.keymap.set('n','<C-n>',function()
	vim.cmd('<C-X>')
	vim.cmd('<C-O>')
end)]]
vim.keymap.set('n','<C-d>', function()
	vim.print('duplicate line')
end)
vim.keymap.set('n','<C-Space>', function()
	vim.print('duplicate line')
end)
