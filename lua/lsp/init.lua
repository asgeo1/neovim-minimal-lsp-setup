require("lsp.handlers")
require("lsp.formatting")
local utils = require("utils")

local M = {}

local on_attach = function(client)
	if client.resolved_capabilities.document_formatting then
		vim.cmd([[augroup Format]])
		vim.cmd([[autocmd! * <buffer>]])
		vim.cmd([[autocmd BufWritePost <buffer> lua require'lsp.formatting'.format_async()]])
		vim.cmd([[augroup END]])

		utils.map("n", "<leader>af", "<cmd>lua require'lsp.formatting'.format_async()<CR>", { buffer = true })
	end

	if client.resolved_capabilities.goto_definition then
		utils.map("n", "<C-]>", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = true })
	end

	if client.resolved_capabilities.hover then
		utils.map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer = true })
	end

	if client.resolved_capabilities.find_references then
		utils.map(
			"n",
			"<Space>*",
			":lua require('lists').change_active('Quickfix')<CR>:lua vim.lsp.buf.references()<CR>",
			{ buffer = true }
		)
	end

	if client.resolved_capabilities.rename then
		utils.map("n", "<Space>rn", "<cmd>lua require'lsp.rename'.rename()<CR>", { silent = true, buffer = true })
	end

	utils.map("n", "<Space><CR>", "<cmd>lua require'lsp.diagnostics'.line_diagnostics()<CR>", { buffer = true })
	utils.map("n", "<Space>sh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = true })
	utils.map("n", "<Space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { buffer = true })

	-- Next/Prev diagnostic issue
	utils.map("n", "<Space>n", "<cmd>lua vim.diagnostic.goto_next()<CR>", { buffer = true })
	utils.map("n", "<Space>p", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { buffer = true })

	-- Send errors to the location list
	utils.map(
		"n",
		"<Space>ll",
		"<cmd>lua vim.lsp.diagnostic.set_loclist({ open_loclist = false })<CR>",
		{ buffer = true }
	)

	-- disabled for now, because of performance issues with `O`, `x`, `u` etc
	-- require "lsp_signature".on_attach()
end

function _G.activeLSP()
	local servers = {}
	for _, lsp in pairs(vim.lsp.get_active_clients()) do
		table.insert(servers, { name = lsp.name, id = lsp.id })
	end
	_G.P(servers)
end

function _G.bufferActiveLSP()
	local servers = {}
	for _, lsp in pairs(vim.lsp.buf_get_clients()) do
		table.insert(servers, { name = lsp.name, id = lsp.id })
	end
	_G.P(servers)
end

M.setup_lsp_servers = function()
	local lspconfig = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

	-- https://github.com/theia-ide/typescript-language-server
	lspconfig.tsserver.setup({
		capabilities = capabilities,
		on_attach = function(client)
			client.resolved_capabilities.document_formatting = false
			require("nvim-lsp-ts-utils").setup({})
			on_attach(client)
		end,
	})

	-- General purpose language server, useful for hooking up prettier
	--
	-- NOTE: This is no longer integrated or dependent on lspconfig
	--
	local null_ls = require("null-ls")

	null_ls.setup({
		-- register any number of sources simultaneously
		sources = {
			null_ls.builtins.formatting.prettierd,
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.sqlformat,
		},
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- https://github.com/hrsh7th/vscode-langservers-extracted
	lspconfig.eslint.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

return M
