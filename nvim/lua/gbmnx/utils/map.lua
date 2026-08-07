local M = {}

---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts? table
function M.map(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, opts or {})
end

return M
