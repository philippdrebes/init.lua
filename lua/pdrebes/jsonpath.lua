local ts_utils = require("nvim-treesitter.ts_utils")
local M = {}

local function get_json_path(bufnr)
	local node = ts_utils.get_node_at_cursor()
	if not node then
		return "No Treesitter node found"
	end

	local path = {}
	while node do
		local node_type = node:type()
		if node_type == "pair" then
			local key_node = node:field("key")[1]
			if key_node then
				local key_name = vim.treesitter.get_node_text(key_node, bufnr)
				key_name = key_name:gsub('"', "")
				table.insert(path, 1, key_name)
			end
		end
		node = node:parent()
	end

	if #path == 0 then
		return "Cursor is not inside a JSON object"
	end

	return table.concat(path, ".")
end

function M.show_json_path()
	local bufnr = vim.api.nvim_get_current_buf()
	local json_path = get_json_path(bufnr)
	vim.api.nvim_echo({ { json_path, "Normal" } }, false, {})
end

function M.setup(opts)
	opts = opts or {}
	local keymap = opts.keymap or "<leader>jp"

	vim.keymap.set("n", keymap, M.show_json_path, { noremap = true, silent = true, desc = "Show JSON Path" })
end

return M
