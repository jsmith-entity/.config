vim.api.nvim_set_hl(0, "LspNotifyErr", { fg = "#ff0000" })

local function is_excepted_ft(ft)
	local exceptions = {
		"",
		"qf",
		"harpoon",
		"oil",
		"oil_preview"
	}

	for _, val in ipairs(exceptions) do
		if val == ft then return true end
	end
	return false
end

local function has_lsp(bufnr, filetype)
	if is_excepted_ft(filetype) then
		return true
	end

	local lsp_clients = vim.lsp.get_clients({ bufnr = bufnr })
	if #lsp_clients > 0 then
		return true
	else
		return false
	end
end

local function check_lsp(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

	if not has_lsp(bufnr, filetype) then
		local msg = "LSP not installed for filetype: " .. filetype
		vim.api.nvim_echo({ { msg, "LspNotifyErr" } }, false, {})
	else
		print("")
	end
end

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(args)
		vim.defer_fn(function()
			check_lsp(args.buf)
		end, 250)
	end
})
