require('config.lazy')

vim.cmd("colorscheme habamax")

vim.g.counter=0
vim.keymap.set('n','b',function() 
	local counter=vim.g.counter
	counter=counter+1
	vim.g.counter=counter
	vim.print(counter)
end)

vim.keymap.set('i','zz',function() 
	vim.print('zz')
end)


