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

	local width = math.ceil(string.len(json_path) + 4)
	local height = 1
	local opts = {
		relative = "cursor",
		width = width,
		height = height,
		row = 1,
		col = 0,
		style = "minimal",
		border = "single",
	}

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { json_path })
	local win = vim.api.nvim_open_win(buf, false, opts)

	vim.api.nvim_create_autocmd("CursorMoved", {
		buffer = bufnr,
		callback = function()
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
			end
		end,
	})
end

function M.setup(opts)
	opts = opts or {}
	local keymap = opts.keymap or "<leader>jp"

	vim.keymap.set("n", keymap, M.show_json_path, { noremap = true, silent = true, desc = "Show JSON Path" })
end

return M