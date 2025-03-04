require('config.lazy')

vim.cmd("colorscheme habamax")
vim.keymap.set('n','<C-b>', function()
	vim.print('open file tree')
end)

vim.keymap.set('n','<C-d>', function()
	vim.print('duplicate line')
end)

vim.keymap.set('n','<C-n>', function()
	vim.print('code completion')
end)
