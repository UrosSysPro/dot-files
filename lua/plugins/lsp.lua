return {
	{
		"williamboman/mason.nvim",
		config = function()
			require('mason').setup{}
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim"
		},
		config = function() 
			require('mason-lspconfig').setup{}
		end
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{
							path = "${3rd}/luv/library",
							words = { "vim%.uv" }
						}
					}
				}
			},
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" }
		},
		config = function()
			local lsp=require("lspconfig")
			lsp.lua_ls.setup {}
			lsp.kotlin_language_server.setup{}
			lsp.clangd.setup{}
			lsp.arduino_language_server.setup{}
		end
	}
}
