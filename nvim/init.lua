vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.termguicolors = true
vim.o.scrolloff = 12
vim.o.signcolumn = "yes"
vim.o.colorcolumn = "81"
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true

-- Plugins
vim.pack.add({
	{ src = "https://github.com/vague-theme/vague.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
})

vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

vim.lsp.enable({ 
	'lua_ls', 
	"bashls", 
	"denols", 
	"dartls",
	"basedpyright",
	"djlsp",
})

require("nvim-treesitter.configs").setup({
	ensure_installed = {},
	sync_install = false,
	auto_install = true,
	highlight = { enable = true }
})

require("oil").setup({
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = true,
	},
	columns = {
		"permissions",
		"icon",
	},
	float = {
		max_width = 0.7,
		max_height = 0.6,
		border = "rounded",
	},
	view_options = {
		show_hidden = true
	}
})

require("telescope").setup({
	defaults = {
		preview = { treesitter = false },
		color_devicons = true,
		sorting_strategy = "ascending",
		borderchars = {
			"─", -- top
			"│", -- right
			"─", -- bottom
			"│", -- left
			"┌", -- top-left
			"┐", -- top-right
			"┘", -- bottom-right
			"└", -- bottom-left
		},
		path_displays = { "smart" },
		layout_config = {
			height = 100,
			width = 400,
			prompt_position = "top",
			preview_cutoff = 40,
		}
	}
})
require("telescope").load_extension("ui-select")

require("harpoon").setup({
	menu = {
		width = vim.api.nvim_win_get_width(0) - 4,
	},
	settings = {
		save_on_toggle = true
	}
})

require("todo-comments").setup({})

-- Keymaps
vim.g.mapleader = " "
local map = vim.keymap.set
map("n", "<leader>lf", vim.lsp.buf.format)
map("n", "<C-k>", "10k", { noremap = true, silent = true })
map("n", "<C-j>", "10j", { noremap = true, silent = true })
map("n", "<leader>pv", "<CMD>Oil<CR>")
map("n", "<leader>pf", require("telescope.builtin").find_files)

map("n", "<leader>h", function()
	local harpoon = require("harpoon")
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
map("n", "<leader>H", function() require("harpoon"):list():add() end)
for i = 1, 5 do
	map("n", "<leader>" .. i, function()
		require("harpoon"):list():select(i)
	end)
end

map("n", "<leader>e", function() vim.diagnostic.open_float(nil, { border = "rounded" }) end)
map("n", "<C-E>", function()
	vim.diagnostic.setqflist({})
	vim.cmd.copen()
end)
map("n", "<M-j>", "<cmd>cnext<CR>")
map("n", "<M-k>", "<cmd>cprev<CR>")
map('i', '<C-a>', '<C-x><C-o>')

-- Custom functions
require("lsp-notify")
require("eof-scrolloff")
require("live-multigrep").setup()
