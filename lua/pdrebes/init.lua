require("pdrebes.set")
require("pdrebes.remap")
require("pdrebes.lazy_init")
--vim.cmd [[colorscheme dracula_pro]]

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local PDrebesGroup = augroup("pdrebes", {})

autocmd("LspAttach", {
	group = PDrebesGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
	end,
})

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Define an autocmd group for the blade workaround
local blade_augroup = vim.api.nvim_create_augroup("lsp_blade_workaround", { clear = true })

-- Autocommand to temporarily change 'blade' filetype to 'php' when opening for LSP server activation
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = blade_augroup,
	pattern = "*.blade.php",
	callback = function()
		vim.bo.filetype = "php"
	end,
})

-- Additional autocommand to switch back to 'blade' after LSP has attached
vim.api.nvim_create_autocmd("LspAttach", {
	pattern = "*.blade.php",
	callback = function(args)
		vim.schedule(function()
			-- Check if the attached client is 'intelephense'
			for _, client in ipairs(vim.lsp.get_active_clients()) do
				if client.name == "intelephense" and client.attached_buffers[args.buf] then
					vim.api.nvim_buf_set_option(args.buf, "filetype", "blade")
					-- update treesitter parser to blade
					vim.api.nvim_buf_set_option(args.buf, "syntax", "blade")
					break
				end
			end
		end)
	end,
})

-- make $ part of the keyword for php.
vim.api.nvim_exec(
	[[
autocmd FileType php set iskeyword+=$
]],
	false
)

vim.filetype.add({
	extension = {
		systems = "systems",
	},
})
