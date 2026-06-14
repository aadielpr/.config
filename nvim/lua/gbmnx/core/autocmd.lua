-- Stop Neovim Daemons.
local stop_neovim_daemons = vim.api.nvim_create_augroup("StopNeovimDaemons", { clear = true })
local core_dir = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")

vim.api.nvim_create_autocmd("ExitPre", {
	group = stop_neovim_daemons,
	callback = function()
		vim.fn.jobstart(core_dir .. "/stop-nvim-daemon.sh", { detach = true })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("n", "j", function()
			local ok = pcall(vim.cmd, "cnext")
			if ok then vim.cmd("wincmd p") end
		end, { buffer = true, silent = true })

		vim.keymap.set("n", "k", function()
			local ok = pcall(vim.cmd, "cprev")
			if ok then vim.cmd("wincmd p") end
		end, { buffer = true, silent = true })
	end,
})
