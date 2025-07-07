local config = {
	sources = {
		"filesystem",
		"buffers",
		"git_status",
	},

	add_blank_line_at_top = false,
	auto_clean_after_session_restore = false,
	close_if_last_window = true,
	default_source = "filesystem",
	enable_diagnostics = true,
	enable_git_status = true,
	enable_modified_markers = true,
	enable_opened_markers = true,
	enable_refresh_on_write = true,
	enable_cursor_hijack = true,

	git_status_async = true,
	git_status_async_options = {
		batch_size = 1000,
		batch_delay = 10,
		max_lines = 10000,
	},

	hide_root_node = false,
	retain_hidden_root_indent = false,
	log_level = "info",
	log_to_file = false,
	open_files_in_last_window = true,
	open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" },
	open_files_using_relative_paths = false,
	popup_border_style = "NC",
	resize_timer_interval = 500,

	sort_case_insensitive = false, -- used when sorting files and directories in the tree
	sort_function = nil , -- uses a custom function for sorting files and directories in the tree
	use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
	use_default_mappings = true,
	-- source_selector provides clickable tabs to switch between sources.
	source_selector = {
		winbar = false, -- toggle to show selector on winbar
		statusline = false, -- toggle to show selector on statusline
		show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
		-- of the top visible node when scrolled down.
		sources = {
			{ source = "filesystem" },
			{ source = "buffers" },
			{ source = "git_status" },
		},
		content_layout = "start", -- only with `tabs_layout` = "equal", "focus"
		tabs_layout = "equal", -- start, end, center, equal, focus
		truncation_character = "…", -- character to use when truncating the tab label
		tabs_min_width = nil, -- nil | int: if int padding is added based on `content_layout`
		tabs_max_width = nil, -- this will truncate text even if `text_trunc_to_fit = false`
		padding = 0, -- can be int or table
		separator = { left = "▏", right= "▕" },
		separator_active = nil,
		show_separator_on_edge = false,
		highlight_tab = "NeoTreeTabInactive",
		highlight_tab_active = "NeoTreeTabActive",
		highlight_background = "NeoTreeTabInactive",
		highlight_separator = "NeoTreeTabSeparatorInactive",
		highlight_separator_active = "NeoTreeTabSeparatorActive",
	},
	default_component_configs = {
		container = {
			enable_character_fade = true,
			width = "100%",
			right_padding = 0,
		},
		indent = {
			indent_size = 2,
			padding = 1,
			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
			-- expander config, needed for nesting files
			with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "󰉖",
			folder_empty_open = "󰷏",
			-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
			-- then these will never be used.
			default = "*",
			highlight = "NeoTreeFileIcon",
			provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
				if node.type == "file" or node.type == "terminal" then
					local success, web_devicons = pcall(require, "nvim-web-devicons")
					local name = node.type == "terminal" and "terminal" or node.name
					if success then
						local devicon, hl = web_devicons.get_icon(name)
						icon.text = devicon or icon.text
						icon.highlight = hl or icon.highlight
					end
				end
			end
		},
		modified = {
			symbol = "[+] ",
			highlight = "NeoTreeModified",
		},
		name = {
			trailing_slash = false,
			highlight_opened_files = false, -- Requires `enable_opened_markers = true`. 
			-- Take values in { false (no highlight), true (only loaded), 
			-- "all" (both loaded and unloaded)}. For more information,
			-- see the `show_unloaded` config of the `buffers` source.
			use_git_status_colors = true,
			highlight = "NeoTreeFileName",
		},
		git_status = {
			symbols = {
				-- Change type
				added     = "✚", -- NOTE: you can set any of these to an empty string to not show them
				deleted   = "✖",
				modified  = "",
				renamed   = "󰁕",
				-- Status type
				untracked = "",
				ignored   = "",
				unstaged  = "󰄱",
				staged    = "",
				conflict  = "",
			},
			align = "right",
		},
		-- If you don't want to use these columns, you can set `enabled = false` for each of them individually
		file_size = {
			enabled = true,
			width = 12, -- width of the column
			required_width = 64, -- min width of window required to show this column
		},
		type = {
			enabled = true,
			width = 10, -- width of the column
			required_width = 110, -- min width of window required to show this column
		},
		last_modified = {
			enabled = true,
			width = 20, -- width of the column
			required_width = 88, -- min width of window required to show this column
			format = "%Y-%m-%d %I:%M %p", -- format string for timestamp (see `:h os.date()`)
			-- or use a function that takes in the date in seconds and returns a string to display
			--format = require("neo-tree.utils").relative_date, -- enable relative timestamps
		},
		created = {
			enabled = false,
			width = 20, -- width of the column
			required_width = 120, -- min width of window required to show this column
			format = "%Y-%m-%d %I:%M %p", -- format string for timestamp (see `:h os.date()`)
			-- or use a function that takes in the date in seconds and returns a string to display
			--format = require("neo-tree.utils").relative_date, -- enable relative timestamps
		},
		symlink_target = {
			enabled = false,
			text_format = " ➛ %s", -- %s will be replaced with the symlink target's path.
		},
	},
	renderers = {
		directory = {
			{ "indent" },
			{ "icon" },
			{ "current_filter" },
			{
				"container",
				content = {
					{ "name", zindex = 10 },
					{
						"symlink_target",
						zindex = 10,
						highlight = "NeoTreeSymbolicLinkTarget",
					},
					{ "clipboard", zindex = 10 },
					{ "diagnostics", errors_only = true, zindex = 20, align = "right", hide_when_expanded = true },
					{ "git_status", zindex = 10, align = "right", hide_when_expanded = true },
					{ "file_size", zindex = 10, align = "right" },
					{ "type", zindex = 10, align = "right" },
					{ "last_modified", zindex = 10, align = "right" },
					{ "created", zindex = 10, align = "right" },
				},
			},
		},
		file = {
			{ "indent" },
			{ "icon" },
			{
				"container",
				content = {
					{
						"name",
						zindex = 10
					},
					{
						"symlink_target",
						zindex = 10,
						highlight = "NeoTreeSymbolicLinkTarget",
					},
					{ "clipboard", zindex = 10 },
					{ "bufnr", zindex = 10 },
					{ "modified", zindex = 20, align = "right" },
					{ "diagnostics",  zindex = 20, align = "right" },
					{ "git_status", zindex = 10, align = "right" },
					{ "file_size", zindex = 10, align = "right" },
					{ "type", zindex = 10, align = "right" },
					{ "last_modified", zindex = 10, align = "right" },
					{ "created", zindex = 10, align = "right" },
				},
			},
		},
		message = {
			{ "indent", with_markers = false },
			{ "name", highlight = "NeoTreeMessage" },
		},
		terminal = {
			{ "indent" },
			{ "icon" },
			{ "name" },
			{ "bufnr" }
		}
	},
	nesting_rules = {},
	-- Global custom commands that will be available in all sources (if not overridden in `opts[source_name].commands`)
	--
	-- You can then reference the custom command by adding a mapping to it:
	--    globally    -> `opts.window.mappings`
	--    locally     -> `opt[source_name].window.mappings` to make it source specific.
	--
	-- commands = {              |  window {                 |  filesystem {
	--   hello = function()      |    mappings = {           |    commands = {
	--     print("Hello world")  |      ["<C-c>"] = "hello"  |      hello = function()
	--   end                     |    }                      |        print("Hello world in filesystem")
	-- }                         |  }                        |      end
	--
	-- see `:h neo-tree-custom-commands-global`
	commands = {}, -- A list of functions

	window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
		-- possible options. These can also be functions that return these options.
		position = "left", -- left, right, top, bottom, float, current
		width = 40, -- applies to left and right positions
		height = 15, -- applies to top and bottom positions
		auto_expand_width = false, -- expand the window when file exceeds the window width. does not work with position = "float"
		popup = { -- settings that apply to float position only
			size = {
				height = "80%",
				width = "50%",
			},
			position = "50%", -- 50% means center it
			title = function (state) -- format the text that appears at the top of a popup window
				return "Neo-tree " .. state.name:gsub("^%l", string.upper)
			end,
			-- you can also specify border here, if you want a different setting from
			-- the global popup_border_style.
		},
		insert_as = "child", -- Affects how nodes get inserted into the tree during creation/pasting/moving of files if the node under the cursor is a directory:
		-- "child":   Insert nodes as children of the directory under cursor.
		-- "sibling": Insert nodes  as siblings of the directory under cursor.
		-- Mappings for tree window. See `:h neo-tree-mappings` for a list of built-in commands.
		-- You can also create your own commands by providing a function instead of a string.
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			["<space>"] = {
				"toggle_node",
				nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
			},
			["<2-LeftMouse>"] = "open",
			["<cr>"] = "open",
			-- ["<cr>"] = { "open", config = { expand_nested_files = true } }, -- expand nested file takes precedence
			["<esc>"] = "cancel", -- close preview or floating neo-tree window
			["P"] = { "toggle_preview", config = {
				use_float = true,
				use_image_nvim = false,
				-- title = "Neo-tree Preview", -- You can define a custom title for the preview floating window.
			} },
			["<C-f>"] = { "scroll_preview", config = {direction = -10} },
			["<C-b>"] = { "scroll_preview", config = {direction = 10} },
			["l"] = "focus_preview",
			["S"] = "open_split",
			-- ["S"] = "split_with_window_picker",
			["s"] = "open_vsplit",
			-- ["sr"] = "open_rightbelow_vs",
			-- ["sl"] = "open_leftabove_vs",
			-- ["s"] = "vsplit_with_window_picker",
			["t"] = "open_tabnew",
			-- ["<cr>"] = "open_drop",
			-- ["t"] = "open_tab_drop",
			["w"] = "open_with_window_picker",
			["C"] = "close_node",
			--["C"] = "close_all_subnodes",
			["z"] = "close_all_nodes",
			--["Z"] = "expand_all_nodes",
			--["Z"] = "expand_all_subnodes",
			["R"] = "refresh",
			["a"] = {
				"add",
				-- some commands may take optional config options, see `:h neo-tree-mappings` for details
				config = {
					show_path = "none", -- "none", "relative", "absolute"
				}
			},
			["A"] = "add_directory", -- also accepts the config.show_path and config.insert_as options.
			["d"] = "delete",
			["r"] = "rename",
			["y"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			["c"] = "copy", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
			["m"] = "move", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
			["e"] = "toggle_auto_expand_width",
			["q"] = "close_window",
			["?"] = "show_help",
			["<"] = "prev_source",
			[">"] = "next_source",
		},
	},
	filesystem = {
		window = {
			mappings = {
				["H"] = "toggle_hidden",
				["/"] = "fuzzy_finder",
				["D"] = "fuzzy_finder_directory",
				["#"] = "fuzzy_sorter", 
				["f"] = "filter_on_submit",
				["<C-x>"] = "clear_filter",
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["[g"] = "prev_git_modified",
				["]g"] = "next_git_modified",
				["i"] = "show_file_details", -- see `:h neo-tree-file-actions` for options to customize the window.
				["b"] = "rename_basename",
				["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["og"] = { "order_by_git_status", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			},
			fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
				["<down>"] = "move_cursor_down",
				["<C-n>"] = "move_cursor_down",
				["<up>"] = "move_cursor_up",
				["<C-p>"] = "move_cursor_up",
				["<Esc>"] = "close",
				["<S-CR>"] = "close_keep_filter",
				["<C-CR>"] = "close_clear_filter",
				["<C-w>"] = { "<C-S-w>", raw = true },
				{
					-- normal mode mappings
					n = {
						["j"] = "move_cursor_down",
						["k"] = "move_cursor_up",
						["<S-CR>"] = "close_keep_filter",
						["<C-CR>"] = "close_clear_filter",
						["<esc>"] = "close",
					}
				}
				-- ["<esc>"] = "noop", -- if you want to use normal mode
				-- ["key"] = function(state, scroll_padding) ... end,
			},
		},
		async_directory_scan = "auto", -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
		-- "always" means directory scans are always async.
		-- "never"  means directory scans are never async.
		scan_mode = "shallow", -- "shallow": Don't scan into directories to detect possible empty directory a priori
		-- "deep": Scan into directories to detect empty or grouped empty directories a priori.
		bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
		cwd_target = {
			sidebar = "tab",   -- sidebar is when position = left or right
			current = "window" -- current is when position = current
		},
		check_gitignore_in_search = true, -- check gitignore status for files/directories when searching
		filtered_items = {
			visible = false, -- when true, they will just be displayed differently than normal items
			force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
			show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
			hide_dotfiles = true,
			hide_gitignored = true,
			hide_hidden = true, -- only works on Windows for hidden files/directories
			hide_by_name = {
				".DS_Store",
				"thumbs.db"
				--"node_modules",
			},
			hide_by_pattern = { -- uses glob style patterns
				--"*.meta",
				--"*/src/*/tsconfig.json"
			},
			always_show = { -- remains visible even if other settings would normally hide it
				--".gitignored",
			},
			always_show_by_pattern = { -- uses glob style patterns
				--".env*",
			},
			never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
				--".DS_Store",
				--"thumbs.db"
			},
			never_show_by_pattern = { -- uses glob style patterns
				--".null-ls_*",
			},
		},
		find_by_full_path_words = false,  -- `false` means it only searches the tail of a path.
		group_empty_dirs = false,
		search_limit = 50, 
		follow_current_file = {
			enabled = false,
			leave_dirs_open = false, 
		},
		hijack_netrw_behavior = "open_default",
		use_libuv_file_watcher = false,
	},
	buffers = {
		bind_to_cwd = true,
		follow_current_file = {
			enabled = true, 
			leave_dirs_open = false,
		},
		group_empty_dirs = true,
		show_unloaded = false,    
		terminals_first = false, 
		window = {
			mappings = {
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["d"] = "buffer_delete",
				["bd"] = "buffer_delete",
				["i"] = "show_file_details",
				["b"] = "rename_basename",
				["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			},
		},
	},
	git_status = {
		window = {
			mappings = {
				["A"] = "git_add_all",
				["gu"] = "git_unstage_file",
				["gU"] = "git_undo_last_commit",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push",
				["i"] = "show_file_details",
				["b"] = "rename_basename",
				["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			},
		},
	},
	document_symbols = {
		follow_cursor = false,
		client_filters = "first",
		renderers = {
			root = {
				{"indent"},
				{"icon", default="C" },
				{"name", zindex = 10},
			},
			symbol = {
				{"indent", with_expanders = true},
				{"kind_icon", default="?" },
				{"container",
					content = {
						{"name", zindex = 10},
						{"kind_name", zindex = 20, align = "right"},
					}
				}
			},
		},
		window = {
			mappings = {
				["<cr>"] = "jump_to_symbol",
				["o"] = "jump_to_symbol",
				["A"] = "noop", -- also accepts the config.show_path and config.insert_as options.
				["d"] = "noop",
				["y"] = "noop",
				["x"] = "noop",
				["p"] = "noop",
				["c"] = "noop",
				["m"] = "noop",
				["a"] = "noop",
				["/"] = "filter",
				["f"] = "filter_on_submit",
			},
		},
		kinds = {
			Unknown = { icon = "?", hl = "" },
			Root = { icon = "", hl = "NeoTreeRootName" },
			File = { icon = "󰈙", hl = "Tag" },
			Module = { icon = "", hl = "Exception" },
			Namespace = { icon = "󰌗", hl = "Include" },
			Package = { icon = "󰏖", hl = "Label" },
			Class = { icon = "󰌗", hl = "Include" },
			Method = { icon = "", hl = "Function" },
			Property = { icon = "󰆧", hl = "@property" },
			Field = { icon = "", hl = "@field" },
			Constructor = { icon = "", hl = "@constructor" },
			Enum = { icon = "󰒻", hl = "@number" },
			Interface = { icon = "", hl = "Type" },
			Function = { icon = "󰊕", hl = "Function" },
			Variable = { icon = "", hl = "@variable" },
			Constant = { icon = "", hl = "Constant" },
			String = { icon = "󰀬", hl = "String" },
			Number = { icon = "󰎠", hl = "Number" },
			Boolean = { icon = "", hl = "Boolean" },
			Array = { icon = "󰅪", hl = "Type" },
			Object = { icon = "󰅩", hl = "Type" },
			Key = { icon = "󰌋", hl = "" },
			Null = { icon = "", hl = "Constant" },
			EnumMember = { icon = "", hl = "Number" },
			Struct = { icon = "󰌗", hl = "Type" },
			Event = { icon = "", hl = "Constant" },
			Operator = { icon = "󰆕", hl = "Operator" },
			TypeParameter = { icon = "󰊄", hl = "Type" },
		}
	},
	example = {
		renderers = {
			custom = {
				{"indent"},
				{"icon", default="C" },
				{"custom"},
				{"name"}
			}
		},
		window = {
			mappings = {
				["<cr>"] = "toggle_node",
				["<C-e>"] = "example_command",
				["d"] = "show_debug_info",
			},
		},
	},
}
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		--"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	config=config,
}
