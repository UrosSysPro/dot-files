return {

	enabled=false,
	"nothing/nothing",
  dependencies = { },
  ft = { "txt" },
  opts = function()
    vim.print("hello from opts")
    return {}
  end,
  config = function(self, config)
    vim.print("hello from config")
  end
}
